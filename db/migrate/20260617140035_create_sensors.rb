class CreateSensors < ActiveRecord::Migration[8.1]
  def change
    create_table :sensors do |t|
      t.string :sensor_id
      t.string :machine_name
      t.float :temperature
      t.float :voltage
      t.string :status

      t.timestamps
    end
  end
end
