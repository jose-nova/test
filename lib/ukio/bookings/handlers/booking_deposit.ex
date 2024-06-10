defmodule Ukio.Bookings.Handlers.BookingDeposit do
  def calculate(apartment) do
    case apartment.city do
      "Barcelona" -> 100_000
      "Mars" -> apartment.monthly_price
      _ -> 100_000
    end
  end
end
