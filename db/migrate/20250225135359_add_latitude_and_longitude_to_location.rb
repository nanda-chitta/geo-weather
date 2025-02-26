# frozen_string_literal: true

class AddLatitudeAndLongitudeToLocation < ActiveRecord::Migration[7.0]
  def change
    change_table :locations, bulk: true do |t|
      t.string :latitude, null: false, default: ''
      t.string :longitude, null: false, default: ''
    end
  end
end
