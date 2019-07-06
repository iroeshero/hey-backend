class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true 

  before_action :authenticate_user!

  $page_name = ""
  $sub_page_name =""
  
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_member = Member.find(@decoded[:member_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

end
