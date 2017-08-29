module BurningGlass
  module Criteria
    class Occupation

      class << self

        def accepted_parameters
          %w(
            !areaId careerAreaId careerAreaJobTitle occupationGroupId
            employerId primaryJobId firstStep starterJob specializedTraining
            occupationIds
          )
        end

      end

    end
  end
end
