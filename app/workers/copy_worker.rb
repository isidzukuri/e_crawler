class CopyWorker
  include Sidekiq::Worker
  include UserMessagable

  def perform(type, url, category_id, user_id)
    @result = CategoryCopier.copy(type, url, category_id)
    add_flash_for_user(user_id)
  end

  private

  attr_reader :result

  def add_flash_for_user user_id
    if result[:error]
      store_message(user_id, result[:error], :error)
    else
      store_message(user_id, "Coping of #{url} completed.")
    end
  end

end
