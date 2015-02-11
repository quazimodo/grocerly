require 'delegate'

module Grocerly

  class Paginator < SimpleDelegator

    attr_accessor :perpage

    def initialize(source, perpage = 20)

      super source
      @perpage = perpage

    end

    def source
      __getobj__
    end

    def pages

      pages = source.count / perpage
      source.count % perpage != 0 ? pages + 1 : pages

    end

    def page(n)

      start = (n-1)*20
      ending = (n * 20) - 1
      source.slice(start..ending) || []

    end

  end

end
