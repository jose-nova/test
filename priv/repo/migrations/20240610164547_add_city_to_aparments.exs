defmodule Ukio.Repo.Migrations.AddCityToAparments do
  use Ecto.Migration

  def change do
    alter table(:apartments) do
     add :city, :string
    end
  end
end
