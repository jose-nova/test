defmodule Ukio.Bookings.Handlers.BookingUtilities do
  def calculate(apartment) do
    case apartment.city do
      "Barcelona" -> 20_000
      "Mars" -> apartment.square_meters * 200
      _ -> 20_000
    end
  end
end
