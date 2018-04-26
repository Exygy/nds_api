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
      puts "failed #{e}"
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
      req.use_ssl = true
      req.form_data(data)
      Net::HTTP.new(url.host, url.port).start{ |http| http.request(req) }
    rescue => e
      puts "failed #{e}"
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
