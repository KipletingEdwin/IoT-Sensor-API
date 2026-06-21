class AddLocationToSensors < ActiveRecord::Migration[8.1]
  def change
    add_column :sensors, :location, :string, null: false, default: "Main Floor - Zone 1"
  end
end
