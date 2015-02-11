require 'spec_helper'
require 'grocerly/html/html.rb'
require 'grocerly/html/navbar.rb'
require 'grocerly/html/body.rb'
require 'grocerly/html/header.rb'

describe Grocerly::Html::Html do

  let(:html_class) { Grocerly::Html::Html }
  let(:navbar) { Grocerly::Html::Navbar.new }
  let(:body) { Grocerly::Html::Body.new }
  let(:header) { Grocerly::Html::Header.new }
  let(:generator) { Grocerly::Html::Html.new(navbar: navbar,
                                             body: body,
                                             header: header) }

  describe "#call" do

    it "raises error when no header is given" do
      expect{html_class.new(navbar: lambda{}, body: lambda{})}.to raise_error
    end

    it "raises error when no navbar is given" do
      expect{html_class.new(header: lambda{}, body: lambda{})}.to raise_error
    end

    it "raises error when no body is given" do
      expect{html_class.new(header: lambda{}, navbar: lambda{})}.to raise_error
    end


    it "generates a html page" do
      expect(generator.call).to include "</HTML>"
    end

    it "generates a html page with a body" do
      expect(generator.call).to include "</HEAD>"
    end

    it "generates a html page with a navbar" do
      expect(generator.call).to include "</NAV>"
    end

    it "generates a html page with a header" do
      expect(generator.call).to include "</BODY>"
    end

  end

end
