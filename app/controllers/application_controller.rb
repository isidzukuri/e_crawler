class ApplicationController < ActionController::Base
  include UserMessagable

  protect_from_forgery with: :exception
  before_action :messages_for_user, only: [:index, :show, :new, :edit]

  private

  def messages_for_user
    return unless signed_in?
    retrieve_user_messages(current_user.id).each do |message|
      add_flash(message['text'], message['type'])
    end
  end

  def add_flash(text, type = 'success')
    flash[type] ||= ''
    flash[type] << "#{text} "
  end
end
