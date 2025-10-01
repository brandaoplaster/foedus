defmodule Foedus.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :trade_name, :string, null: false
      add :cnpj, :string, null: false
      add :active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
    create unique_index(:companies, [:cnpj])
    create index(:companies, [:trade_name])
    create index(:companies, [:cnpj])
  end
end
