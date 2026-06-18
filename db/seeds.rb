
# db/seeds.rb

# 1. Clear out any previous data to keep tests completely pristine
Sensor.destroy_all

# 2. Define 10 specific machines across a simulated factory floor
factory_sensors = [
  { sensor_id: "SNSR-001", machine_name: "Hydraulic Assembly Press", temperature: 45.2, voltage: 230.5, status: "Normal" },
  { sensor_id: "SNSR-002", machine_name: "Robotic Welding Arm Alpha", temperature: 62.1, voltage: 400.2, status: "Normal" },
  { sensor_id: "SNSR-003", machine_name: "Robotic Welding Arm Beta",  temperature: 58.7, voltage: 398.9, status: "Normal" },
  { sensor_id: "SNSR-004", machine_name: "Main Conveyor Belt Motor",  temperature: 38.4, voltage: 220.1, status: "Normal" },
  { sensor_id: "SNSR-005", machine_name: "High-Speed CNC Milling Machine", temperature: 71.3, voltage: 415.0, status: "Normal" },
  { sensor_id: "SNSR-006", machine_name: "Laser Cutting Station",      temperature: 50.0, voltage: 230.0, status: "Normal" },
  { sensor_id: "SNSR-007", machine_name: "Cooling Fluid Pump System",  temperature: 22.8, voltage: 115.5, status: "Normal" },
  { sensor_id: "SNSR-008", machine_name: "Primary Air Compressor",     temperature: 41.9, voltage: 230.2, status: "Normal" },
  { sensor_id: "SNSR-009", machine_name: "Automated Packaging Unit",   temperature: 33.1, voltage: 218.4, status: "Normal" },
  { sensor_id: "SNSR-010", machine_name: "Exhaust Ventilation Fan",    temperature: 29.5, voltage: 110.1, status: "Normal" }
]

# 3. Create records in the PostgreSQL database
factory_sensors.each do |sensor_data|
  Sensor.create!(sensor_data)
end

puts "🌱 Successfully seeded #{Sensor.count} IoT machine sensors into PostgreSQL!"
