# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationManagement::AppServices::Validators::LocationParam do
  describe '#validate' do
    context 'validate with valid location params' do
      let(:valid_params) do
        {
          location: {
            name: 'Los Angeles',
            address: 'Los Angeles',
            city: 'Los Angeles',
            state: 'CA',
            country: 'US',
            zip_code: '90018',
            latitude: '34.0536909',
            longitude: '-118.242766'
          }
        }
      end

      it 'succeeds and returns required params' do
        result = subject.validate(valid_params)
        expect(result.success?).to be_truthy
        param = result.value!
        expect(param).to eq valid_params[:location]
      end

      it 'failed for missing parameters' do
        missing_params = valid_params.dup.tap do |o|
          o[:location].delete(:name)
        end
        result = subject.validate(missing_params)
        expect(result.failure).to be_instance_of(::Commons::FailureConstant::InvalidParameter)
      end
    end

    context 'validate location name and address params' do
      let(:params) do
        {
          location: {
            name: 'Service - Blue',
            address: '5th Street, 7th Cross',
            city: 'New York',
            state: 'NY',
            country: 'US',
            zip_code: '10025',
            latitude: '40.7128',
            longitude: '-74.0060'
          }
        }

        it 'succeeds and returns required params' do
          result = subject.validate(params)
          expect(result.success?).to be_truthy
          param = result.value!
          expect(param).to eq params[:location]
        end

        it 'failed for invalid parameters' do
          invalid_params = params.dup.tap do |o|
            o[:location][:name] = " Test - Name "
          end
          result = subject.validate(invalid_params)
          expect(result.failure).to be_instance_of(::Error::ParameterError)
        end
      end
    end
  end
end
