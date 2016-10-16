module UserMessagable
  extend ActiveSupport::Concern

  def store_message text, type = :success
    users_messages_store.sadd('users_messages_store', {type: type, text:text}.to_json)
  end

  def retrieve_users_messages
    result = []
    messages = users_messages_store.smembers('users_messages_store')
    result = messages.map{|item| JSON.parse(item) } if messages
    users_messages_store.del('users_messages_store')
    result
  end

  private

  def users_messages_store
    @users_messages_store ||= Redis.new
  end

end