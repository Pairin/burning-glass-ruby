module BurningGlass
  module Explorer
    class Skill < ExplorerResource

      class << self

        def get_by_id(id)
          response = deliver_request(:get, "skills/#{id}")
          parse_singular_resource(response['data'])
        end

        def get_by_occupation_id(id)
          response = deliver_request(:get, "occupations/#{id}/skills")
          parse_multiple_resources(response['data'])
        end

      end

    end
  end
end
