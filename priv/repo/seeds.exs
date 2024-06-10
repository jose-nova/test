# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ukio.Repo.insert!(%Ukio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "CAPITAN",
  monthly_price: 250_000,
  address: "Carrer de Balmes 76",
  city: "Barcelona",
  square_meters: 120
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "CAPITAN",
  monthly_price: 195_000,
  address: "Carrer de Granados 45",
  city: "Barcelona",
  square_meters: 89
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "98765",
  name: "ESCAPE",
  monthly_price: 9_495_000,
  address: "Martian Ave. 89",
  city: "Mars",
  square_meters: 39
})
