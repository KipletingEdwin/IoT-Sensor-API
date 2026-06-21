class RenameLocationInSesors < ActiveRecord::Migration[8.1]
  def change
    rename_column :sensors, :location, :zone_identifier
  end
end
