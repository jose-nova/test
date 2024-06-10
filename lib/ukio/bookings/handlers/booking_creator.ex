defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Bookings.Handlers.BookingDeposit
  alias Ukio.Bookings.Handlers.BookingUtilities
  alias Ukio.Apartments

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          params
      ) do
    with a <- Apartments.get_apartment!(apartment_id),
         b <- generate_booking_data(a, check_in, check_out) do
      Apartments.create_booking(b)
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: BookingUtilities.calculate(apartment),
      deposit: BookingDeposit.calculate(apartment)
    }
  end
end
