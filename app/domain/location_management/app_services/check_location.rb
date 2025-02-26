# frozen_string_literal: true

class LocationManagement::AppServices::CheckLocation
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do::All

  def initialize
    @location_repo = AppContainer['location_management.infrastructures.repos.location_repository']
    @location_param_validator = AppContainer['location_management.app_services.validators.location_param']
  end

  def find_location(loc)
    return Failure(:invalid_latitude) if loc.key?('lat') && loc['lat'].blank?
    return Failure(:invalid_longitude) if loc.key?('lon') && loc['lon'].blank?
    return Failure(:invalid_address) if loc.key?('address') && loc['address'].blank?

    yield @location_param_validator.validate(valid_params(loc))
  end

  def call(params)
    location = !params.key?(:search) || params[:search].blank? ? DEFAULT_LOCATION : params[:search]
    # TODO: add geocoding logic here to get latitude and longitude from address
    # latitude = 37.7749
    response = Geocoder.search(location)
    Rails.logger.info("Geocoder response:: #{response.inspect}")
    return Failure(::Commons::FailureConstant::GeocoderError.new(extras: 'Location invalid/empty')) if response.blank?

    valid_loc = find_location(response.first.data)
    return Failure(valid_loc.failure) unless valid_loc.is_a?(Hash) || valid_loc.success?

    new_loc = Location.find_or_initialize_by(valid_loc)
    Rails.logger.info("New location:: #{new_loc.inspect}")

    saved_location = @location_repo.get_transaction do
      yield @location_repo.update(new_loc)
    end

    Rails.logger.info("Saved location:: #{saved_location.inspect}")

    Success(saved_location)
  end

  private

  def valid_params(loc)
    {
      location: {
        name: loc['name'],
        address: loc['name'],
        latitude: loc['lat'],
        longitude: loc['lon'],
        country: loc['address']['country_code'].try(:upcase),
        city: loc['address']['city'],
        state: loc['address']['state'],
        zip_code: loc['address'].key?('postcode') ? loc['address']['postcode'] : ''
      }
    }
  end
end

# {"place_id"=>230023034,
#  "licence"=>"Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
#  "osm_type"=>"relation",
#  "osm_id"=>7868535,
#  "lat"=>"17.360589",
#  "lon"=>"78.4740613",
#  "class"=>"boundary",
#  "type"=>"administrative",
#  "place_rank"=>16,
#  "importance"=>0.637894307087777,
#  "addresstype"=>"city",
#  "name"=>"Hyderabad",
#  "display_name"=>"Hyderabad, Bahadurpura mandal, Hyderabad, Telangana, India",
#  "address"=>{"city"=>"Hyderabad", "county"=>"Bahadurpura mandal", "state_district"=>"Hyderabad", "state"=>"Telangana", "ISO3166-2-lvl4"=>"IN-TS", "country"=>"India", "country_code"=>"in"},
#  "boundingbox"=>["17.2916377", "17.5608321", "78.2387067", "78.6223912"]}
