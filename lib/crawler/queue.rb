module Crawler
  class Queue
    def initialize(items)
      @store = items
      @total = items.count
      @items_left = items.count
      @items_shifted = 0
    end

    def next
      thread_lock.synchronize do
        @items_left -= 1
        @items_shifted += 1
        @store.shift
      end
    end

    private

    attr_accessor :lock

    def thread_lock
      @lock = lock.nil? ? Mutex.new : lock
    end
  end
end
