# frozen_string_literal: true

# ApplicationController is the base class for all controllers in the application
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_admin
    return if current_user&.admin?

    flash[:alert] = 'Você não tem permissão para acessar esta página.'
    redirect_to root_path
  end

  private

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'Você precisa esta logado para fazer isto'
    redirect_to login_path
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'Você não tem permissão para acessar esta página' unless current_user&.admin?
  end

  def authenticate_collaborator!
    return if current_user&.collaborator? || current_user&.admin?

    redirect_to root_path,
                alert: 'Você não tem permissão para acessar esta página'
  end
end
