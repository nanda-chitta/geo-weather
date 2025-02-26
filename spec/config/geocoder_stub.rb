# frozen_string_literal: true

module GeocoderStub
  def self.stub_with(loc)
    Geocoder.configure(lookup: :test)

    results = [
      {
        'lat' => '34.0536909',
        'lon' => '-118.242766',
        'name' => 'Los Angeles',
        'address' => {
          'city' => 'Los Angeles',
          'state' => 'CA',
          'country' => 'United States',
          'country_code' => 'US',
          'postcode' => '90018'
        }
      }
    ]
    Geocoder::Lookup::Test.add_stub(loc.name, results)
  end
end
