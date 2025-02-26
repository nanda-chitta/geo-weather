require 'rails_helper'

RSpec.describe LocationManagement::Infrastructures::Repos::LocationRepository do
  include Dry::Monads::Result::Mixin

  let(:location) { FactoryBot.create(:location) }

  describe '#update(location:)' do
    let(:valid_params) do
      {
        name: 'Los Angeles',
        address: 'Los Angeles',
        city: 'Los Angeles',
        state: 'CA',
        country: 'US',
        zip_code: '90018',
        latitude: '34.0536909',
        longitude: '-118.242766'
      }
    end

    let(:update_location)  { Location.find_or_initialize_by(valid_params) }

    context 'when success' do
      it 'updates successfully' do
        result = subject.update(update_location)
        expect(result.success?).to be_truthy
      end
    end

    context 'when failure' do
      it 'fails to update' do
        update_location.name = nil
        result = subject.update(update_location)
        expect(result.failure?).to be_truthy
      end
    end
  end
end
