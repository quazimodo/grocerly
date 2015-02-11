require 'spec_helper'
require 'grocerly/html/body.rb'

describe Grocerly::Html::Body do

  describe "#call" do

    let(:products) { EnumerableData.heaps_of_products }

    it "creates thumbnails of the items" do
      generator = Grocerly::Html::Body.new products: products
      html = generator.call
      require 'pry'; binding.pry
      expect(html).to include products[0][:image]
    end

  end

end
