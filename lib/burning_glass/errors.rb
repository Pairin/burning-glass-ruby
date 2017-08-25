module BurningGlass
  class Error < StandardError
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def to_s
      @message
    end

  end

  class APIError < Error
    attr_reader :status, :message, :body

    def initialize(status, message, body='')
      @status = status
      @message = message
      @body = body
    end

    def to_s
      "#{@status}: #{super} #{@body}"
    end

  end

  class ConfigurationError < Error;end

end
