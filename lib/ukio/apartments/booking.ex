defmodule Ukio.Apartments.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ukio.Apartments.Apartment

  schema "bookings" do
    belongs_to(:apartment, Apartment)

    field :check_in, :date
    field :check_out, :date
    field :deposit, :integer
    field :monthly_rent, :integer
    field :utilities, :integer

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:check_in, :check_out, :apartment_id, :monthly_rent, :deposit, :utilities])
    |> validate_required([
      :check_in,
      :check_out,
      :apartment_id,
      :monthly_rent,
      :deposit,
      :utilities
    ])
    |> validate_checkin_order()
  end

  defp validate_checkin_order(changeset) do
    check_in = get_field(changeset, :check_in)
    check_out = get_field(changeset, :check_out)

    if Date.compare(check_in, check_out) != :lt do
      add_error(changeset, check_in, "must be before check_out")
    end
    changeset
  end
end
