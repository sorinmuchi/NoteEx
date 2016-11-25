class ApiController < ApplicationController
  protected

  def render_error(error, message, par={})
    par[:status] ||= 400
    render json: { error: error, msg: message, status: par[:status] }
  end

  def render_success(par={})
    par[:status] ||= 200
    data = par[:data] ? { data: par[:data] } : {}
    resp = { status: par[:status] }.merge(data)
    render json: resp
  end

  def require_user_presence!
    unless User.exists?(id: session[:user_id])
      render_error("Authentication Error", "User is not signed in")
      false
    end
  end
end