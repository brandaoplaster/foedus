defmodule Foedus.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :address_type, :integer, null: false
      add :street, :string, null: false
      add :number, :string, null: false
      add :complement, :string
      add :neighborhood, :string, null: false
      add :city, :string, null: false
      add :state, :string, null: false
      add :zipcode, :string, null: false
      add :country, :string, null: false

      add :contractor_id, references(:contractors, type: :binary_id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:addresses, [:contractor_id])
  end
end
