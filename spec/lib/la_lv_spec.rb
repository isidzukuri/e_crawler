require 'rails_helper'

RSpec.describe LaLv do
  before :all do
    @valid_url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @not_valid_url = 'http://google.com'
    @item_keys = [:title, :description, :price, :source, :images]
    VCR.use_cassette('items') do
      @parsed_items = LaLv.copy(@valid_url)
    end
    @first_item = @parsed_items.first
    @images = JSON.parse(@first_item[:images])
  end

  describe '#parse' do
    it 'scrape data from a 1a.lv' do
      expect { LaLv.copy(@not_valid_url) }.to raise_error(ArgumentError)
    end

    it "scrape data from a website's category" do
      expect(@parsed_items).to be_a(Array)
    end

    it "scrape data from a website's category" do
      expect(@parsed_items.first.keys).to eq @item_keys
    end

    it "item's title should" do
      expect(@first_item[:title]).to be_a(String)
    end

    it "item's title should be present" do
      expect(@first_item[:title].present?).to eq true
    end

    it "item's description should" do
      expect(@first_item[:description]).to be_a(String)
    end

    it "item's description should be present" do
      expect(@first_item[:description].present?).to eq true
    end

    it "item's price should" do
      expect(@first_item[:price]).to be_a(Integer)
    end

    it "item's source should be" do
      expect(@first_item[:source]).to be_url
    end

    it "item's images should be json string" do
      expect(@first_item[:images]).to be_a(String)
    end

    it "item's images should" do
      expect(@images).to be_a(Array)
    end

    it "item's image's items should be" do
      expect(@images.first).to be_url
    end
  end
end
