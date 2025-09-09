defmodule Foedus.Repo.Migrations.CreateContractors do
  use Ecto.Migration

  def change do
    create table(:contractors, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :entity_type, :integer, default: 0, null: false

      add :full_name, :string
      add :cpf, :string
      add :birth_date, :date
      add :nationality, :string

      add :company_name, :string
      add :trade_name, :string
      add :cnpj, :string
      add :company_type, :string

      add :legal_representative_first_name, :string
      add :legal_representative_last_name, :string
      add :legal_representative_cpf, :string
      add :legal_representative_birth_date, :date
      add :legal_representative_email, :string

      add :authorized_representative_first_name, :string
      add :authorized_representative_last_name, :string
      add :authorized_representative_cpf, :string
      add :authorized_representative_birth_date, :date
      add :authorized_representative_email, :string

      add :email, :string
      add :phone, :string
      add :mobile_phone, :string
      add :website, :string

      add :address_street, :string
      add :address_number, :string
      add :address_complement, :string
      add :address_neighborhood, :string
      add :address_city, :string
      add :address_state, :string
      add :address_zipcode, :string
      add :address_country, :string, default: "Brasil"

      add :notes, :text

      timestamps()
    end

    create index(:contractors, [:entity_type])
    create index(:contractors, [:cpf])
    create index(:contractors, [:cnpj])
    create index(:contractors, [:email])
  end
end
