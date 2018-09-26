require 'nds_api/http'
require 'nds_api/method'
require 'nds_api/url'
require 'nds_api/utils'
require 'nds_api/version'

module NdsApi
  class Client
    # Create a new client instance
    #
    # @param [Hash] options
    # @option options [String] :user NDS User
    # @option options [String] :password NDS Password
    # @option options [String] :agency_key NDS Agency Key
    # @option options [Boolean] :debug
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
      console_debug(step: 1)
      @response = http_action(method, *args, &block)
      console_debug(step: 2)
      NdsApi::Utils.hash_keys_str_to_sym(@response)
    end

    private

    def http_action(method, *args)
      if @method.is_create? || @method.is_search?
        @http.post(url, data)
      elsif @method.is_update?
        @http.put(url, data)
      else
        console_debug(url: @url.send(method, *args))
        @http.get(@url.send(method, *args))
      end
    end

    def data
      @args.include?(:data) ? @args[:data] : @args.first
    end

    def url
      if @method.is_search? && query_params
        @url.send(@method.action, query_params)
      else
        @url.send(@method.action)
      end
    end

    def query_params
      @args.count > 1 ? @args[1] : nil
    end

    def console_debug(params)
      return unless @options[:debug]
      if params[:step] == 1
        params_to_display = @options.dup
        params_to_display[:password] = 'XXXXXXXXXXXXXXX'
        puts "NDS API GEM PARAMS: #{params_to_display}"
        if @method.is_create? || @method.is_search? || @method.is_update?
          puts "NDS API DEBUG: #{@method.is_update? ? 'PUT' : 'POST'}"
          puts "NDS API DEBUG: URL: #{url.inspect}"
        else
          puts 'NDS API DEBUG: METHOD GET'
        end
      end
      puts "NDS API DEBUG: RESPONSE: #{@response.inspect}" if params[:step] == 2
      puts "NDS API DEBUG: URL: #{params[:url]}" if params[:url]
    end
  end
end
