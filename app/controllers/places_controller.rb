class PlacesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :new, :create]

	def index
    # filters
    if params.key? '/places'
      @maximum_distance = params['/places']['maximum_distance'] # in km
    else
      @maximum_distance = 5
    end

		@places = Place.near([current_user.profile.latitude, current_user.profile.longitude], @maximum_distance)
    @places_gmaps = Place.near([current_user.profile.latitude, current_user.profile.longitude], @maximum_distance).to_gmaps4rails
    # TODO: customize markers
    #do |place, marker|
      #(marker.picture({picture: place.place_image.baby, width: 25, height: 25})) if place.place_image.present?
      #marker.title(place.title)
    #end
	end

	def new
		@place = Place.new
	end

	def show
		@place = Place.find(params[:id])
		@opinions = @place.opinions
    @opinion = Opinion.new
	end

	def create
		@place = Place.new(params[:place])

    # setting up who owns this place
    @place.user = current_user

    if @place.save
      flash[:success] = "Place created."

      redirect_to @place
    else
      # flash if address is inexistant in gmaps
      flash[:alert] = @place.errors.messages[:gmaps4rails_address].first if @place.errors.messages.key? :gmaps4rails_address

      render :new
    end
	end
end
