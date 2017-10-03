
require 'burning_glass/insight/insight_resource'

require 'burning_glass/criteria/job_report'

require 'burning_glass/insight/job_posting'

module BurningGlass
  module Insight

    class << self

      REQUIREMENTS = %w(consumer_key consumer_secret token token_secret)

      def requirements
        REQUIREMENTS
      end

    end

  end
end
