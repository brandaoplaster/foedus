defmodule Foedus.Repo.Migrations.CreateSigners do
  use Ecto.Migration

  def change do
    create table(:signers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :lastname, :string, null: false
      add :email, :string, null: false
      add :document, :string
      add :role, :string
      add :birthdate, :date
      add :status, :boolean, default: false, null: false
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:signers, [:company_id])
    create unique_index(:signers, [:email, :company_id])
  end
end
