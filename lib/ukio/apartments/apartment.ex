defmodule Ukio.Apartments.Apartment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apartments" do
    field :address, :string
    field :monthly_price, :integer
    field :name, :string
    field :square_meters, :integer
    field :zip_code, :string
    field :city, :string

    timestamps()
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:name, :address, :zip_code, :city, :monthly_price, :square_meters])
    |> validate_required([:name, :address, :zip_code, :city, :monthly_price, :square_meters])
  end
end
