module BurningGlass
  module Criteria
    class Pagination

      ACCEPTED_PARAMETERS = %w(culture offset limit orderBy)

      class << self

        def accepted_parameters
          ACCEPTED_PARAMETERS
        end

      end

    end
  end
end
