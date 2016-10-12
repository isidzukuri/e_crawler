require "rails_helper"

RSpec.describe Crawler::Queue do
  before :each do
    array = Array(1..5)
    @instance = Crawler::Queue.new(array)
  end

  describe '#next' do
    it 'shifts first item in the queue' do
      expect(@instance.next).to eq 1
    end

    it 'shifts 4th item in the queue' do
      3.times{@instance.next}
      expect(@instance.next).to eq 4
    end

    it 'should return nil' do
      5.times{@instance.next}
      expect(@instance.next).to be_nil
    end
  end

end

