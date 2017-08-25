require 'burning_glass/version'

require 'burning_glass/util/oauth_helper'
require 'burning_glass/util/string_helper'
require 'burning_glass/util/requester'

require 'burning_glass/errors'
require 'burning_glass/options'
require 'burning_glass/client'

require 'burning_glass/insight'
require 'burning_glass/explorer'

module BurningGlass

  class << self

    def client
      @client ||= BurningGlass::Client.new(opts)
    end

    def opts
      @opts ||= Options.new
    end

    def configure
      clear
      yield(opts)
      client
    end

    def clear
      [@opts, @client].each{ |att| att = nil }
    end

  end

end
