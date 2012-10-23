class PagesController < ApplicationController

	def index
    @latest_places = Place.order("created_at DESC")
    @latest_profiles = Profile.order("created_at DESC")
    redirect_to places_path if user_signed_in?
	end

  def how_it_works

  end

end
