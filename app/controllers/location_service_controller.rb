class LocationServiceController < ApplicationController
  respond_to :html
  layout false 

  def states
    @states = Country.find_country_by_alpha2(params[:alpha2]).states
  end
end
