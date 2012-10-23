class OpinionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

	def index
		@opinions = Opinion.all
	end

	def new
		@opinion = Opinion.new
	end

	def create
		@opinion = Opinion.new(params[:opinion])

    # sets up place
    @place = Place.find(params[:place_id])
    @opinion.place = @place
    @opinion.user = current_user

    if @opinion.save
      flash[:success] = "Opinion created."
      redirect_to @place
    else
      render :new
    end
	end

end
