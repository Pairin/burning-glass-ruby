module BurningGlass
  module Explorer
    class Occupation < ExplorerResource

      get_by :id
      get_by_criteria :occupation, :pagination
      has_many :skills
      has_many :similar_occupations

    end
  end
end
