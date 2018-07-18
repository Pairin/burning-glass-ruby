require 'forwardable'

module BurningGlass
  class Results
    extend Forwardable
    include Enumerable

    attr_reader :results, :meta

    def_delegators :@results, :each, :map,
    :inject, :first, :last, :count, :length, :empty?,
    :present?, :select, :reject, :sample

    def initialize(results, metadata={})
     @results = results
     @metadata = metadata
    end

  end
end
