require 'rails_helper'

RSpec.describe CategoryCopier do

  let(:category) { FactoryGirl.create :category }
  let!(:count) { Product.count }

  let(:item) { Product.find_by_source("http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem/hp_hl510e_next_business_day_onsite_care_pack_3_year") }
  let(:item_source){"http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem/hp_hl510e_next_business_day_onsite_care_pack_3_year"}
  let(:title){"HP HL510E Next Business Day On-Site Care Pack 3 year"}
  let(:description){"<table class=\"characteristics-table\">\r<tr><td class=\"half\"><strong>Portatīvā datora ražotājs:</strong> HP</td><td class=\"values\"><strong>Garantijas pagarināšanas termiņš:</strong> 3 gadi (kopā ar standarta garantiju)</td></tr><tr class=\"table-break\">\r<td colspan=\"2\"></td>\r</tr>\r<tr>\r<td><strong><span class=\"green\">Garantija:</span> Nav</strong></td>\r<td><strong><span class=\"green\">Preces kods:</span> HL510E</strong></td></tr>\r\r<tr class=\"gift\"><td colspan=\"2\"><strong><span class=\"green\">DĀVANA:</span> Bezmaksas piegāde visā Latvijā uz Pasta nodaļām ar kodu \"TORNADOPASTS\" (līdz 20kg), Statoil DUS (līdz 7kg) ar kodu \"TORNADODUS\" vai DPD Pickup (līdz 10kg) ar kodu \"DPD1210\"</strong><br></td></tr></table>"}
  let(:price){237}
  let(:images){"[\"http://www.1a.lv/images/products/000165/119459_xs.jpg\",\"http://www.1a.lv/images/special_offers/000001/542343_product_thumbnail.png\"]"}

  before do
    url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @count = Product.count

    VCR.use_cassette('items') do
      CategoryCopier.copy(:la_lv, url, category.id)
    end
    
  end

  describe '#bulk_create' do
    it 'shold insert items 40 into db' do
      expect(Product.count - count).to eq 40
    end

    it 'shold insert correct item into db' do
      expect(item[:source]).to eq item_source
      expect(item[:category_id]).to eq category.id
      expect(item[:title]).to eq title
      expect(item[:description]).to eq description
      expect(item[:price]).to eq price
      expect(item[:images]).to eq images
    end
  end

end
