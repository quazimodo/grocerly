module Grocerly

  class ExpectsEnumerableArgument < Exception
  end

  class ProductList

    attr_accessor :data

    def initialize data

      raise ExpectsEnumerableArgument unless data.respond_to? :each
      @data = data

    end

    def retailers
      data.map{|h| h.fetch("retailer")}.uniq
    end

    def find_by_retailer(retailer)

      products = data.collect do |hash|
        if hash["retailer"] == retailer
          hash
        else
          nil
        end
      end

      products.compact

    end

  end

end
