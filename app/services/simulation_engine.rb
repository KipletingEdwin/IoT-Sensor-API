class SimulationEngine
  def self.start_stress_test(duration_seconds: 15, interval_ms: 50)
    interval_in_seconds = interval_ms / 1000.0
    
    # ⏱️ Create an absolute mathematical cutoff deadline
    end_time = Time.current + duration_seconds.seconds
    sensors = Sensor.all.to_a

    # Loop strictly while our time limit has not expired
    while Time.current < end_time
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
          location: sensor.location,
          temperature: sensor.temperature,
          voltage: sensor.voltage,
          status: sensor.status,
          sent_at: Time.current.to_f
        }

        ActionCable.server.broadcast("ticker_stream", payload)
      end

      # 🔍 SAFETY CHECK: If we ran out of time while executing the inner sensor loop, stop immediately!
      break if Time.current >= end_time

      sleep(interval_in_seconds)
    end
  end
end
