defmodule UkioWeb.BookingController do
  use UkioWeb, :controller

  alias Ukio.Apartments
  alias Ukio.Apartments.Booking
  alias Ukio.Bookings.Handlers.BookingCreator

  action_fallback UkioWeb.FallbackController

  def create(conn, %{"booking" => booking_params}) do
    result = BookingCreator.create(booking_params)

    with {:ok, %Booking{} = booking} <- result do
      conn
      |> put_status(:created)
      |> render(:show, booking: booking)
    end

    # with {:error, %Booking{} = booking} <- result do
    #   conn
    #   |> put_status(:unauthorized)
    #   |> render("unauthorized")
    # end
  end

  def show(conn, %{"id" => id}) do
    booking = Apartments.get_booking!(id)
    render(conn, :show, booking: booking)
  end

  def index(conn, _params) do
    bookings = Apartments.list_bookings()
    render(conn, :index, bookings: bookings)
  end
end
