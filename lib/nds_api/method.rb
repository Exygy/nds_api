require 'json'
require 'net/http'
require 'open-uri'
require 'uri'

module NdsApi
  class Method
    def initialize(method = '')
      @method = method.to_s
    end

    def is_create?
      @method.include? 'create'
    end

    def is_update?
      @method.include? 'update'
    end

    def is_search?
      @method.include? 'search'
    end

    def is_search_providers?
      @method.include? 'search_providers'
    end

    def action
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
        when 'providers'
          'providers'
        end
      "#{action}_#{object_type}#{method_split[2] ? "_#{method_split[2]}" : ''}"
    end

    private

    def method_split
      @method_split ||= @method.split('_')
    end
  end
end
