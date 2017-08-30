module BurningGlass
  module Explorer
    class Degree < ExplorerResource

      get_by :id
      belongs_to :occupation, resource_key: ['degreeData']

    end
  end
end
