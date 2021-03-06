class LaLv < Crawler::Parser
  HOST = 'www.1a.lv'.freeze

  def self.copy(url)
    new.copy(url)
  end

  def copy(url)
    check_url(url)
    parse url, '.product a:not(.button)', '.paging-box a'
  end

  def check_url(url)
    raise ArgumentError, 'Not valid url' unless url =~ URI.regexp
    raise ArgumentError, "Argument should be a url from #{HOST}" unless URI(url).host == HOST
  end

  private

  def extract_data(page)
    price = page.search('.new-price').text
    price = page.search('.price-box .price').text if price == ''

    {
      title: page.search('.product-title-container h2').text,
      description: page.search('.product-description-details .characteristics-table').to_s.gsub(/\n|\t/, ''),
      price: price.to_i,
      source: page.uri.to_s,
      images: images(page).to_json
    }
  end

  def images(page)
    result = []
    page.search('.image-thumbnails-slider img').each do |tag|
      path = tag.attribute('src')
      # path.to_s.gsub!('_xs', '_xl') for big images
      result << "#{page.uri.scheme}://#{page.uri.host}#{path}" if path
    end
    result
  end
end
