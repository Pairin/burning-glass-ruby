module BurningGlass
  module Criteria
    class JobReport

      class << self

        def accepted_parameters
          %w(
            !groupBy !timePeriod !queryString geography offset limit
          )
        end

      end

    end
  end
end
