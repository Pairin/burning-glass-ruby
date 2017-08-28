module BurningGlass
  module Explorer
    class JobIndustry < ExplorerResource

      class << self

        def get_by_occupation_id(id)
          response = deliver_request(:get, "occupations/#{id}/industries")
          parse_multiple_resources(response['data'])
        end

      end


    end
  end
end
