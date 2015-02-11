require 'spec_helper'
require 'grocerly/html/navbar.rb'

describe Grocerly::Html::Navbar do

  let(:generator) {  }

  describe "#call" do

    let(:general_generator) { Grocerly::Html::Navbar.new }

    it "generates a navbar" do
      html = general_generator.call

      expect(html).to include "<NAV"
      expect(html).to include "</NAV>"

    end

    it "generates a generalised navbar" do
      html = general_generator.call

      expect(html).to include "Grocerly"
      expect(html).to include '<A href="/index.html">Index'

    end

    it "generates a specific navbar" do
      retailers = ["YourGrocer", "La Manna Fresh", "Melba's Food Hall"]
      generator = Grocerly::Html::Navbar.new retailers: retailers

      html = generator.call
      expect(html).to include '<A href="/YourGrocer/index.html">YourGrocer'
      expect(html).to include '<A href="/La Manna Fresh/index.html">La Manna Fresh'
      expect(html).to include %-<A href="/Melbas Food Hall/index.html">Melba&#39;s Food Hall-
    end

  end


end
