class ProfilesController < ApplicationController
  skip_filter :require_completed_profile, :only => [:new]
  before_filter :require_ownership_of_profile, :only => [:edit]
  before_filter :authenticate_user!, :except => [:show]
  before_filter :no_profile_user, :only => [:new, :create]

	def edit
		@profile = current_user.profile
	end

  def update
    @profile = current_user.profile

    params[:profile][:gmaps] = false

    if @profile.update_attributes(params[:profile])
      flash[:notice] = 'Profile updated.'
      redirect_to profile_path(:username => @profile.user.username)
    else
      render :edit
    end
  end

	def show
		@profile = User.find_by_username(params[:username]).profile
	end

	def new
    @profile = Profile.new
	end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user

    if @profile.save
      # update completed
      @profile.user.update_attribute(:completed, true)

      flash[:success] = "Your profile is complete. Enjoy your stay!"

      redirect_to places_path
    else
      # flash if address is inexistant in gmaps
      flash[:alert] = @profile.errors.messages[:gmaps4rails_address].first if @profile.errors.messages.key? :gmaps4rails_address

      render :new
    end
  end

  protected
  def require_ownership_of_profile
    if params[:id] != current_user.profile.id.to_s || params[:user_id] != current_user.id.to_s
      flash[:alert] = "You shouldn't be here."
      redirect_to edit_user_profile_path(:user_id => current_user.id, :id => current_user.profile.id)
    end
  end

  def no_profile_user
    if current_user.profile.present?
      flash[:alert] = "You already have a profile."

      redirect_to places_path
    else
      @profile = Profile.new
    end
  end
end
