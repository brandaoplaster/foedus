defmodule Foedus.Repo.Migrations.CreateContractors do
  use Ecto.Migration

  def change do
    create table(:contractors, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :entity_type, :integer, default: 0, null: false

      add :full_name, :string
      add :document, :string
      add :birth_date, :date
      add :nationality, :string

      add :company_name, :string
      add :trade_name, :string
      add :cnpj, :string
      add :company_type, :string

      add :email, :string
      add :phone, :string
      add :mobile_phone, :string
      add :website, :string
      add :status, :integer, default: 0, null: false

      add :notes, :text

      timestamps(type: :utc_datetime)
    end

    create index(:contractors, [:entity_type])
    create index(:contractors, [:document])
    create index(:contractors, [:cnpj])
    create index(:contractors, [:email])
  end
end
