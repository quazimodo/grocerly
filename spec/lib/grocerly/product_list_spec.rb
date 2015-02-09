require 'spec_helper'
require 'grocerly/product_list'

describe Grocerly::ProductList do

  let(:data) { EnumerableData.two_retailers }
  let(:list) { Grocerly::ProductList.new data }

  it "inits with a single arg of enumerable data" do
    expect{list}.not_to raise_error
  end

  describe "#retailers" do

    it "returns an array of unique retailers" do
      r = list.retailers
      expect(r.count).to eq 2
      expect(r).to include "YourGrocer"
      expect(r).to include "La Manna Fresh"
    end

  end

  describe "#find_by_retailer" do

    it "returns an array of products for a supplied retailer" do
      p = list.find_by_retailer "YourGrocer"
      expect(p.count).to eq 2
      expect(p.first.fetch("name")).to include "Meat Sampler"
      expect(p).not_to include nil
    end

  end

end
