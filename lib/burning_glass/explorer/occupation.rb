module BurningGlass
  module Explorer
    class Occupation < ExplorerResource

      get_by :id
      has_many :skills

    end
  end
end
