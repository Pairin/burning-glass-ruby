module BurningGlass
  module Explorer
    class StateArea < ExplorerResource

      class << self

        def get(params={})
          response = deliver_request(:get, 'stateareas', params)
          parse_multiple_resources(response['data'])
        end

      end

    end
  end
end
