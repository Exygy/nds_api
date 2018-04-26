module NdsApi
  class Http

    def initialize(options = {})
      @options = options.dup
    end

    def get(url)
      begin
        JSON.parse(open(url, http_basic_authentication: [api_user, api_password]).read)
      rescue => error
        puts error.backtrace
      end
    end

    def post(url, data)
      puts "IMPLEMENT POST"
    end

    def put(url, data)
      puts "IMPLEMENT PUT"
    end

    private

    def api_user
      @options[:user]
    end

    def api_password
      @options[:password]
    end
  end
end
