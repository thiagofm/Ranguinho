class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate_user!(opts={}) 
    opts[:scope] = :user
    warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
    if user_signed_in? && !current_user.completed?
      redirect_to new_user_profile_path(current_user)
      flash[:alert] = "You must complete your profile before proceeding."
    end
  end
end
