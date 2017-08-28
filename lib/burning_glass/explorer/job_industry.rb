module BurningGlass
  module Explorer
    class JobIndustry < ExplorerResource

      belongs_to :occupation, resource_name: 'industries'

    end
  end
end
