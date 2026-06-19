
class SimulationEngine
  def self.start_stress_test(duration_seconds: 15, interval_ms: 50)
    interval_in_seconds = interval_ms / 1000.0
    
    # Calculate exactly how many loops to run (e.g., 15 seconds / 0.05 seconds = 300 loops)
    total_broadcast_ticks = (duration_seconds / interval_in_seconds).to_i

    # Load sensors into memory
    sensors = Sensor.all.to_a

    # Run a fixed number of times so it is guaranteed to stop

    total_broadcast_ticks.times do
      sensors.each do |sensor|
        temp_fluctuation = rand(-1.5..1.5)
        volt_fluctuation = rand(-2.0..2.0)

        sensor.temperature = (sensor.temperature + temp_fluctuation).round(2)
        sensor.voltage = (sensor.voltage + volt_fluctuation).round(2)

        sensor.status = if sensor.temperature > 85.0 || sensor.voltage > 410.0
                          "Critical"
                        elsif sensor.temperature > 70.0 || sensor.voltage > 240.0
                          "Warning"
                        else
                          "Normal"
                        end

        payload = {
          sensor_id: sensor.sensor_id,
          machine_name: sensor.machine_name,
          temperature: sensor.temperature,
          voltage: sensor.voltage,
          status: sensor.status,
          sent_at: Time.current.to_f
        }

        ActionCable.server.broadcast("ticker_stream", payload)
      end

      sleep(interval_in_seconds)
    end
  end
end
