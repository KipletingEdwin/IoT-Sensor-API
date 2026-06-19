
class SimulationsController < ApplicationController

  # GET /api/v1/simulations

  def index
    render json: Sensor.all, status: :ok
  end


  # POST /api/v1/simulations/start
  def start
    test_duration = params.fetch(:duration, 15).to_i
    test_interval = params.fetch(:interval, 50).to_i

    Thread.new do
      SimulationEngine.start_stress_test(
        duration_seconds: test_duration,
        interval_ms: test_interval
      )
    end

    render json: { 
      status: "success", 
      message: "IoT high-frequency simulation initiated successfully.",
      configuration: { duration_sec: test_duration, interval_ms: test_interval }
    }, status: :ok
  end
end
