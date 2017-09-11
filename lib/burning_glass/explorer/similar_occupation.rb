module BurningGlass
  module Explorer
    class SimilarOccupation < ExplorerResource

      belongs_to :occupation, resource_name: 'occupations-similar'

      def occupation(params={})
        @occupation ||= Occupation.get_by_id(self.integer_id, params)
      end

    end
  end
end
