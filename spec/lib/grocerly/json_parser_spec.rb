require 'spec_helper'
require 'grocerly/json_parser.rb'
require 'grocerly/product_list.rb'

describe Grocerly::JsonParser do

  let(:data) { JsonData.two_products }

  it "Inits with a single arg of json data" do
    expect{Grocerly::JsonParser.new data}.not_to raise_error
  end

  describe "#parse" do

    let(:parser) { Grocerly::JsonParser.new data }
    let(:malformed_data) { JsonData.malformed_json }

    it "raises an error on malformed json data" do
      p = Grocerly::JsonParser.new malformed_data
      expect{p.parse}.to raise_error
    end

    it "returns a ProductList" do
      expect(parser.parse).to be_a_kind_of Grocerly::ProductList
    end

  end

end
