require 'spec_helper'
require 'grocerly/html/body.rb'

describe Grocerly::Html::Body do

  describe "#call" do

    let(:products) { EnumerableData.heaps_of_products }
    let(:generator) { Grocerly::Html::Body.new products: products }
    let(:html) { generator.call }

    it "creates thumbnails of the items" do
      img_src = products[5]["image"]
      expect(html).to include %-src="#{img_src}"-
    end

    it "produces the right number of columns for a row of less than 5 products" do
      prod = products.slice 0..3
      generator = Grocerly::Html::Body.new products: prod
      html =  generator.call

      expect(html.scan(%-class="thumbnail"-).length).to eq 4

    end

    it "doesn't output anything when no products are specified" do
      html = Grocerly::Html::Body.new.call
      expect(html).to include "No Products"
    end

  end

end
