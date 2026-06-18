
class TickerChannel < ApplicationCable::Channel
  # Triggered automatically when the React client initiates a WebSocket handshake
  def subscribed
    stream_from "ticker_stream"
  end

  def unsubscribed
    # Cleans up resources when the user closes or refreshes the browser tab
  end
end
