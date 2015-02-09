module Grocerly

  class ProductList

    def initialize data
      @data = data
    end

    def retailers
      @data.map{|h| h.fetch("retailer")}.uniq
    end

    def find_by_retailer retailer
      ary = @data.collect do |h|
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
