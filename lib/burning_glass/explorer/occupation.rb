module BurningGlass
  module Explorer
    class Occupation < ExplorerResource

      get_by :id
      get_by_criteria :occupation, :pagination
      has_many :skills

    end
  end
end
