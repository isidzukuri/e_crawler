class ApplicationController < ActionController::Base
  include UserMessagable

  protect_from_forgery with: :exception
  before_action :messages_for_user

  private

  def messages_for_user
    retrieve_users_messages.each{|message|  add_flash(message['text'], message['type']) }
  end

  def add_flash text, type = 'success'
    flash[type] ||= ''
    flash[type] << "#{text} "
  end


end
