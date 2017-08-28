module BurningGlass
  module Explorer
    class Occupation < ExplorerResource

      has_many :skills

      class << self

        def get_by_id(id)
          response = deliver_request(:get, "occupations/#{id}")
          parse_singular_resource(response['data'])
        end

      end


    end
  end
end
