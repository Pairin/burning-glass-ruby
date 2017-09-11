
require 'burning_glass/explorer/explorer_resource'

require 'burning_glass/criteria/occupation'

require 'burning_glass/explorer/occupation'
require 'burning_glass/explorer/similar_occupation'
require 'burning_glass/explorer/degree'
require 'burning_glass/explorer/job_industry'
require 'burning_glass/explorer/skill'
require 'burning_glass/explorer/state_area'

module BurningGlass
  module Explorer

    class << self

      REQUIREMENTS = %w(consumer_key consumer_secret token token_secret)

      def requirements
        REQUIREMENTS
      end

    end


  end
end
