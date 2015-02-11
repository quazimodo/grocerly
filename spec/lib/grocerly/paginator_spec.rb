require 'spec_helper'
require 'grocerly/paginator.rb'

describe Grocerly::Paginator do

  let(:products) { EnumerableData.heaps_of_products }
  let(:paginated) { products.pop; Grocerly::Paginator.new products, 20 }

  it "inits with an array of elems and a number of elems per page" do
    expect{paginated}.to_not raise_error
  end

  describe "pages" do

    it "shows how many pages in total" do
      expect(paginated.pages).to eq 5
    end

  end

  describe "page" do

    it "returns an array of elems on the arg page" do
      arry = products.slice(20..39)
      expect(paginated.page(2)).to eq arry
    end

    it "returns an empty array if an out of bounds page is given" do
      expect(paginated.page(10)).to eq []
    end

  end

end
