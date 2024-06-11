defmodule Ukio.Apartments.Booking do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
    |> validate_dates()
    |> validate_availability()
  end

  defp validate_dates(changeset) do
    if changeset.valid? do
    check_in = get_field(changeset, :check_in)
    check_out = get_field(changeset, :check_out)

    case Date.compare(check_in, check_out) != :lt do
      true -> add_error(changeset, :check_in, "must be before check_out")
      false -> changeset
    end
    else
      changeset
    end
  end

  defp validate_availability(changeset) do
    if changeset.valid? do
      check_in = get_field(changeset, :check_in)
      check_out = get_field(changeset, :check_out)
      apartment_id = get_field(changeset, :apartment_id)

      query =
        from b in Ukio.Apartments.Booking,
          where: b.apartment_id == ^apartment_id and
                b.check_in < ^check_out and
                b.check_out > ^check_in

      case Ukio.Repo.exists?(query) do
        true -> add_error(changeset, :apartment_unavailable, "no availability for the selected dates")
        false -> changeset
      end
    else
      changeset
    end
  end
end
