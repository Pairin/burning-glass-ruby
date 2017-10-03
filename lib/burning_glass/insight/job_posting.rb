module BurningGlass
  module Insight
    class JobPosting < InsightResource
      extend Actions::Gettable

      get_by_criteria :job_report, method: :post, path: %w(data reportData data)

      class << self

        def resource_name
          'jobs/posting'
        end

      end

    end
  end
end
