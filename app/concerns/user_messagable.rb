module UserMessagable

  def store_message(user_id, text, type = :success)
    users_messages_store.sadd(messeges_store_key(user_id), { type: type, text: text }.to_json)
  end

  def retrieve_user_messages(user_id)
    result = []
    messages = users_messages_store.smembers(messeges_store_key(user_id))
    result = messages.map { |item| JSON.parse(item) } if messages
    users_messages_store.del(messeges_store_key(user_id))
    result
  end

  private

  def messeges_store_key(user_id)
    "users_messages_#{user_id}"
  end

  def users_messages_store
    @users_messages_store ||= Redis.new
  end
end
