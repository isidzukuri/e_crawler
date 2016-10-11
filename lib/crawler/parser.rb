module Crawler
  class Parser
    def initialize(settings = {})
      @settings = {
        threads_number: 20,
        use_cache: true
      }
      @settings.merge!(settings)
      @data = []
    end

    private

    def parse(url, item_attr, paginator_attr = nil)
      sitemap = Sitemap.new(url, item_attr, paginator_attr, @settings)
      urls_list = sitemap.items_urls
      @queue = Crawler::Queue.new(urls_list)
      run_threads
      @data
    end

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
      parse_item(next_url, browser)
      @queue.next
    end

    def parse_item(url, browser)
      page = browser.load_page(url)
      data = extract_data(page)
      @data << data if data
    end

    def extract_data(_page)
      raise NoMethodError, 'Implement :extract_data method'
    end
  end
end
