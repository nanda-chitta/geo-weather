require 'rails_helper'

RSpec.describe LocationManagement::AppServices::CheckLocation do
  include Dry::Monads::Result::Mixin

  let(:location_repo) { double }
  let(:location_param_validator) { double }

  before do
    AppContainer.stub('location_management.infrastructures.repos.location_repository', location_repo)
    AppContainer.stub('location_management.app_services.validators.location_param', location_param_validator)
  end

  after do
    AppContainer.unstub('location_management.infrastructures.repos.location_repository')
    AppContainer.unstub('location_management.app_services.validators.location_param')
  end

  describe '.call' do
    let(:location) { FactoryBot.build(:location,
                                      name: 'Los Angeles',
                                      address: 'Los Angeles',
                                      city: 'Los Angeles',
                                      state: 'CA',
                                      country: 'US',
                                      zip_code: '90018',
                                      latitude: '34.0536909',
                                      longitude: '-118.242766') }
    let(:params)  { { search: location.name } }

    context 'when success' do
      let(:loc_params) do
        {
          'location' => {
            'name' => 'Los Angeles',
            'address' => 'Los Angeles',
            'city' => 'Los Angeles',
            'state' => 'CA',
            'country' => 'US',
            'zip_code' => '90018',
            'latitude' => '34.0536909',
            'longitude' => '-118.242766'
          }
        }
      end

      it 'return location' do
        expect(location_param_validator).to receive(:validate).once.and_return(::Dry::Monads::Success(loc_params['location']))
        location.update(updated_at: Time.zone.now)
        location.reload
        expect(location_repo).to receive(:get_transaction) do |_, &block|
          expect(location_repo).to receive(:update).once.and_return(Success(location))

          block.call
        end

        result = subject.call(params)
        expect(result.success?).to be_truthy
      end
    end
  end

  describe '.find_location' do
    context 'when success' do
      let(:loc_params) do
        {
          'location' => {
            'name' => 'Los Angeles',
            'address' => 'Los Angeles',
            'city' => 'Los Angeles',
            'state' => 'CA',
            'country' => 'US',
            'zip_code' => '90018',
            'latitude' => '34.0536909',
            'longitude' => '-118.242766'
          }
        }
      end

      let(:raw_params) do
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
      end

      it 'return location' do
        expect(location_param_validator).to receive(:validate).once.and_return(::Dry::Monads::Success(loc_params['location']))

        result = subject.find_location(raw_params)
        expect(result).to eq(loc_params['location'])
      end
    end
  end
end
