# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  country    :string
#  latitude   :string           default(""), not null
#  longitude  :string           default(""), not null
#  name       :string
#  state      :string
#  zip_code   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'creates a valid location' do
    expect(FactoryBot.build(:location)).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(190) }
  end
end
