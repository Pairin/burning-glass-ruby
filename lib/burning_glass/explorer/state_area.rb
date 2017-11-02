module BurningGlass
  module Explorer
    class StateArea < ExplorerResource

      get_by_criteria :pagination

      class << self

        def resource_name
          'statearea'
        end

      end

    end
  end
end
