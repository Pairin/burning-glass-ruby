module BurningGlass
  module Explorer
    class Degree < ExplorerResource

      class << self

        def get_by_occupation_id(id)
          response = deliver_request(:get, "occupations/#{id}/degrees")
          parse_multiple_resources(response['data']['degreeData'])
        end

      end


    end
  end
end
