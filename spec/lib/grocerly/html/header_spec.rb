require 'spec_helper'
require 'grocerly/html/header.rb'

describe Grocerly::Html::Header do

  describe "#call" do

    it "generates a generalised header" do
      generator = Grocerly::Html::Header.new

      html = generator.call
      expect(html).to include "<HEAD>"
      expect(html).to include "</HEAD>"
      expect(html).to include "Grocerly | No Title"
    end

    it "generates a specific header" do
      generator = Grocerly::Html::Header.new title: "awesome title"
      html = generator.call
      expect(html).to include "Grocerly | awesome title"
    end

  end

end
