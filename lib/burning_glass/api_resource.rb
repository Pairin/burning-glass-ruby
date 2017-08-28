module BurningGlass
  class APIResource

    class << self

      def url_with_params(url, params={})
        wo_params = URL_BASE + url
        params.empty? ? wo_params : wo_params + Util::StringHelper.hash_to_query_string(params)
      end

    end

  end
end
