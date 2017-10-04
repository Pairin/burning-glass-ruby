module BurningGlass
  module Insight
    class JobPosting < InsightResource
      extend Actions::Gettable

      get_by_criteria :job_report, method: :post, path: %w(data reportData data)

      class << self

        def resource_name
          'jobs/posting'
        end

        def posting(id)
          response = deliver_request(:get, resource_name.plural, {jobid: id})
          response['data']
        end

      end

      def posting
        self.class.posting(self.id)
      end

    end
  end
end
