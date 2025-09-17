defmodule Foedus.Repo.Migrations.CreateRepresentatives do
  use Ecto.Migration

  def change do
    create table(:representatives, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :role, :integer, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :document, :string, null: false
      add :birth_date, :date, null: false
      add :email, :string, null: false
      add :phone, :string, null: false

      add :contractor_id, references(:contractors, type: :binary_id, on_delete: :nothing)

      timestamps()
    end

    create index(:representatives, [:contractor_id])
    create index(:representatives, [:role])
  end
end
