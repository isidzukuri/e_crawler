module Crawler
  class Parser
    # '.product a:not(.button)'
    # '.paging-box a'

    def initialize(settings = {})
      @settings = {
        threads_number: 1,
        use_cache: true
      }
      @settings.merge!(settings)
      @data = []
    end

    def parse(url, item_attr, paginator_attr = nil)
      sitemap = Sitemap.new(url, item_attr, paginator_attr, @settings)
      urls_list = sitemap.items_urls
      @queue = Crawler::Queue.new(urls_list)
      run_threads
      @data
    end

    private

    def run_threads
      threads = []
      @settings[:threads_number].times do
        threads << Thread.new do
          browser = Browser.new @settings[:use_cache]
          next_url = @queue.next
          next_url = process(next_url, browser) while next_url
        end
      end
      threads.each(&:join)
    end

    def process(next_url, browser)
      # begin
      parse_item(next_url, browser)
      # rescue
      # end
      @queue.next
    end

    def parse_item(url, browser)
    	ap url
      page = browser.load_page(url)
      data = extract_data(page)
      ap "--#{url}"
      @data << data if data
    end

    def extract_data(_page)
      # raise NoMethodError.new("Implement :extract_data method")
      # raise Crawler::Exception, 'Implement :extract_data method'
    end
  end
end
