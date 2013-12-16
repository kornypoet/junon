module Junon
  class Connection

    attr_reader :hostname, :port

    def self.establish(options = {})
      self.new(options)
    end

    def initialize options
      @hostname = options[:host] || 'localhost'
      @port     = options[:port] || 4440
      cache_session(options) if options[:username] && options[:password]
      attach_token(options)  if options[:token]
    end

    def base_uri
      "http://#{hostname}:#{port}/"
    end

    def connection
      @connection ||= Faraday.new(base_uri + 'api/7') do |setup|
        setup.response :xml, content_type: /\bxml$/
        setup.adapter  Faraday.default_adapter
      end
    end

    def cache_session options
      session = connection.post(base_uri + 'j_security_check') do |request|
        request.params = { j_username: options[:username], j_password: options[:password] }
      end
      # Handle authorization errors here
      connection.headers['Cookie'] = session.headers['set-cookie']
    end

    def attach_token options
      connection.headers['X-Rundeck-Auth-Token'] = options[:token]
    end

    def call_http_method(action, path, params = nil, handler = nil)
      response = connection.send(action, path) do |request|
        request.params = params unless params.nil?
      end
      handle_response(handler || path, response)
    end
    
    def get(path, params = nil)
      response = connection.get(path) do |request|
        request.params = params unless params.nil?
      end
      handle_response(path, response)
    end

    def post(path, params = nil)
      response = connection.post(path) do |request|
        request.params = params unless params.nil?
      end
      handle_response(path, response)
    end

    def handle_response(handler, response)
      ResponseHandler.receive_as(handler, response.body)
    end
  end
end
