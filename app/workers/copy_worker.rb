class CopyWorker
  include Sidekiq::Worker
  include UserMessagable

  def perform(type, url, category_id)
    result = CategoryCopier.copy(type, url, category_id)

    if result[:error]
      store_message(result[:error], :error)
    else
      store_message("Coping of #{url} completed.")
    end
  end
end
