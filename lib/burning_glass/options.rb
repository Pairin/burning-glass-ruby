module BurningGlass
  class Options < Struct.new(:consumer_key, :consumer_secret, :production,
    :insight_token, :insight_secret,
    :explorer_token, :explorer_secret)

    def initialize;end

  end
end
