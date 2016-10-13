require 'rails_helper'

RSpec.describe LaLv do
  before :each do
    @valid_url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @not_valid_url = 'http://google.com'
    @item_keys = [:title, :description, :price, :source, :images]
  end

  describe '#parse' do
    it "scrape data from a website's category" do
      expect(LaLv.copy(@valid_url)).to be_a(Array)
    end

    it "scrape data from a website's category" do
      expect(LaLv.copy(@valid_url).first.keys).to eq @item_keys
    end

    it "scrape data from a website's category" do
      expect { LaLv.copy(@not_valid_url) }.to raise_error(ArgumentError)
    end
  end
end
