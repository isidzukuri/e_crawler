require 'rails_helper'

RSpec.describe UserMessagable do
  let!(:instance) { MessagableTest.new }
  let!(:stored) { instance.store_message('some message') }
 
  it 'store message ' do
    expect(stored).to eq true
  end

  it 'stored messaged should be like ' do
    predicted_message = {'type'=>'success', 'text' => 'some message'}
    expect(instance.retrieve_users_messages.first).to eq predicted_message
  end
    
end

class MessagableTest
  include UserMessagable
end
