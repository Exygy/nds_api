require "nds_api/http"
require "nds_api/url"
require "nds_api/version"

module NdsApi
  class Client

    # Create a new client instance
    #
    # @param [Hash] options
    # @option options [String] :user NDS User
    # @option options [String] :password NDS Password
    #
    # @return [NdsApi::Client] a new client instance


    # NdsApi::Client.new({user: 'exygy', password: 'SnowflakeFrog?'}).providers

    def initialize(options = {})
      @options = options.dup
      @http = NdsApi::Http.new(options)
      @url = NdsApi::Url
    end

    def method_missing(method, *args, &block)
      @method = method
      if is_create? or is_update?
        @args = args
        @http.post(@url.send(url), data) if is_create?
        @http.put(@url.send(url), data) if is_update?
      else
        @http.get(@url.send(method, *args, &block))
      end
    end

    private

    def data
      @args[:data]
    end

    def method_split
      @method_split ||= method.split('_')
    end

    def is_create?
      method.include? 'create'
    end

    def is_update?
      method.include? 'update'
    end

    def method
      @method_str ||= @method.to_s
    end

    def url
      method_split ||= @method.split('_')
      action = method_split[0]
      object_type =
        case method_split[1]
        when 'child'
          'children'
        when 'client'
          'clients'
        when 'referral'
          'referrals'
        when 'person'
          'persons'
        when 'provider'
          'providers'
        end
      "#{action}_#{object_type}"
    end

  end
end
