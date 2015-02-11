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

    def find_by_retailer retailer

      ary = data.collect do |h|
        if h.fetch("retailer") == retailer
          h
        else
          nil
        end
      end

      ary.compact

    end

  end

end
