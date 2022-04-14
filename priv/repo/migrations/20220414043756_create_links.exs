defmodule KicksiteUrlShortener.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :hash, :string
      add :url, :string
      add :expires_at, :naive_datetime

      timestamps()
    end
  end
end
