require 'rails_helper'

RSpec.describe Crawler::Browser do
  before :each do
    @url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @instance = Crawler::Browser.new false
  end

  describe '#load_page' do
    it 'throw exception if url not valid' do
      expect { @instance.load_page('dummy string') }.to raise_error(ArgumentError)
    end

    it "should load web page return mechanize page's object " do
      VCR.use_cassette("category") do
        expect(@instance.load_page(@url)).to be_a(Mechanize::Page)
      end
    end
  end
end
