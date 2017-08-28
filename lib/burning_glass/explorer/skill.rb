module BurningGlass
  module Explorer
    class Skill < ExplorerResource

      get_by :id
      belongs_to :occupation

    end
  end
end
