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

      def posting
        response = self.class.deliver_request(:get, self.class.resource_name.plural, {jobid: self.job_id})
        response['data']
      end

    end
  end
end
