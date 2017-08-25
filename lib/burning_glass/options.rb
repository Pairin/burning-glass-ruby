module BurningGlass
  class Options < Struct.new(:consumer_key, :consumer_secret, :sandbox,
    :insight_token, :insight_secret,
    :explorer_token, :explorer_secret)

    def initialize;end

  end
end
