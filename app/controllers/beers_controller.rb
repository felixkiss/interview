VALID_BEERS = {
  "IPA" => {flavor: "Horrible"},
  "brown_ale" => {flavor: "Dark"},
  "pilsner" => {flavor: "Royal"},
  "lager" => {flavor: "Stale"},
  "lambic" => {flavor: "Old"},
  "hefeweizen" => {flavor: "Wheaty"},
}

class BeersController < ApplicationController
  def show
    type = params[:type]
    return render "beers/unknown", status: :not_found unless VALID_BEERS.has_key?(type)

    @beer = OpenStruct.new({type: type}.merge(VALID_BEERS[type]))
  end
end
