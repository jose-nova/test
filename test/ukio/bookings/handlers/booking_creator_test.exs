defmodule Ukio.Bookings.BookingCreatorTest do
  use Ukio.DataCase

  describe "bookings" do
    alias Ukio.Apartments.Booking
    alias Ukio.Bookings.Handlers.BookingCreator

    import Ukio.ApartmentsFixtures

    test "create_booking/1 with valid data and city is Mars" do
      apartment = apartment_fixture(%{city: "Mars"})

      valid_attrs = %{
        "apartment_id" => apartment.id,
        "check_in" => ~D[2023-03-26],
        "check_out" => ~D[2023-03-27]
      }

      assert {:ok, %Booking{} = booking} = BookingCreator.create(valid_attrs)
      assert booking.deposit == apartment.monthly_price
      assert booking.utilities == apartment.square_meters * 200
    end

  end

end
