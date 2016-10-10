class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def initialize
    post_initialize
    super
  end

  private
  def post_initialize
  end
  
  def permited_params
    parameter_name = @model.name.downcase.to_sym
    params.require(parameter_name).permit(@permited_fields)
  end
end
