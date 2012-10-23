module ApplicationHelper
  def state?(place)
    if place.country.present?
      Country.find_country_by_alpha2(place.country)
             .states
             .map {|state| state[1]["name"] }
    else
      []
    end
  end
end
