require 'json'
require 'net/http'
require 'open-uri'
require 'uri'

module NdsApi
  class Http
    def initialize(options = {})
      @options = options.dup
    end

    def get(url)
      JSON.parse(open(url, http_basic_authentication: [api_user, api_password]).read)
    rescue => e
      puts "NDS API GEM: #{e} (#{url})"
      return e
    end

    def post(url, data)
      http_action('post', url, data)
    end

    def put(url, data)
      http_action('put', url, data)
    end

    private

    def http_action(post_or_put, url, data)
      url = URI.parse(url)
      req = http_verb_object(post_or_put).new(
        url.path,
        'Content-Type' => 'application/json'
      )
      req.basic_auth api_user, api_password
      # req.use_ssl = true
      req.body = data.to_json
      response = Net::HTTP.new(url.host, url.port).request(req)
      JSON.parse(response.body)
    rescue => e
      puts "NDS API GEM: #{e} (#{post_or_put}:#{url})"
      return e
    end

    def http_verb_object(post_or_put)
      return Net::HTTP::Post if post_or_put == "post"
      return Net::HTTP::Put if post_or_put == "put"
    end

    def api_user
      @options[:user]
    end

    def api_password
      @options[:password]
    end
  end
end
