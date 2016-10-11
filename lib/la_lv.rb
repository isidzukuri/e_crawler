class LaLv < Crawler::Parser
  # '.product a:not(.button)'
  # '.paging-box a'
  def copy_items(url)
    # parse 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/portativiedatori/2', '.product a:not(.button)', '.paging-box a'
    # ap @data
    # ap @data.count
    # true
    parse url, '.product a:not(.button)', '.paging-box a'
  end

  private

  def extract_data(page)
    price = page.search('.new-price').text
    price = page.search('.price-box .price').text if price == ''

    {
      title: page.search('.product-title-container h2').text,
      description: page.search('.product-description-details .characteristics-table').to_s.gsub(/\n|\t/,""),
      price: price.to_i,
      source: page.uri.to_s,
      images: images(page).to_json
    }
  end

  def images(page)
    result = []
    page.search('.image-thumbnails-slider img').each do |tag|
      path = tag.attribute('src')
      if path
        path.to_s.gsub!('_xs', '_xl')
        result << "#{page.uri.scheme}://#{page.uri.host}#{path}"
      end
    end
    result
  end
end
