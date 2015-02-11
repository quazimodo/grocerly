require 'json'
require 'grocerly/product_list'

module Grocerly

  # Built to be easily converted to a strategy for
  # use in a more generic 'Parser' context in the future
  class JsonParser

    def initialize(json)
      @json = json
    end

    def parse

      data = JSON.parse @json
      Grocerly::ProductList.new data

    end

  end

end

