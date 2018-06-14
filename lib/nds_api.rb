require "nds_api/http"
require "nds_api/method"
require "nds_api/url"
require "nds_api/utils"
require "nds_api/version"

module NdsApi
  class Client
    # Create a new client instance
    #
    # @param [Hash] options
    # @option options [String] :user NDS User
    # @option options [String] :password NDS Password
    # @option options [String] :agency_key NDS Agency Key
    #
    # @return [NdsApi::Client] new client instance

    def initialize(options = {})
      @options = options.dup
      @http = NdsApi::Http.new(options)
      @url = NdsApi::Url.new(options)
    end

    def method_missing(method, *args, &block)
      @method = NdsApi::Method.new(method)
      @args = *args
      response = http_action(method, *args, &block)
      NdsApi::Utils.hash_keys_str_to_sym(response)
    end

    private

    def http_action(method, *args, &block)
      if @method.is_create? or @method.is_search?
        @http.post(url, data)
      elsif @method.is_update?
        @http.put(url, data)
      else
        @http.get(@url.send(method, *args))
      end
    end

    def data
      @args.include?(:data) ? @args[:data] : @args.first
    end

    def url
      if @method.is_search? and query_params
        @url.send(@method.action, query_params)
      else
        @url.send(@method.action)
      end
    end

    def query_params
      @args.count > 1 ? @args[1] : nil
    end
  end
end
