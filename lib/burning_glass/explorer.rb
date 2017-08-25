
require 'burning_glass/explorer/explorer_resource'

module BurningGlass
  module Explorer

    class << self

      REQUIREMENTS = %w(consumer_key consumer_secret explorer_token explorer_secret)

      def requirements
        REQUIREMENTS
      end

    end


  end
end
