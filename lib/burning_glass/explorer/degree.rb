module BurningGlass
  module Explorer
    class Degree < ExplorerResource

      belongs_to :occupation, resource_key: ['degreeData']

    end
  end
end
