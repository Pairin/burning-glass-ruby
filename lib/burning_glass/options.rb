module BurningGlass

  class APIOptions < Struct.new(:consumer_key, :consumer_secret, :token, :token_secret);end

  class Options < Struct.new(:production, :insight, :explorer)

    def initialize;end

    def insight=(args)
      super(create_api_options(args))
    end

    def explorer=(args)
      super(create_api_options(args))
    end

    private

    def create_api_options(args)
      APIOptions.new(
        args[:consumer_key],
        args[:consumer_secret],
        args[:token],
        args[:token_secret]
      )
    end

  end
end
