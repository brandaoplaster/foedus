defmodule Foedus.Contractors.Contractor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contractors" do
    field :entity_type, :integer, default: 0
    field :full_name, :string
    field :cpf, :string
    field :birth_date, :date
    field :nationality, :string
    field :mobile_phone, :string

    field :company_name, :string
    field :trade_name, :string
    field :cnpj, :string
    field :company_type, :string
    field :email, :string
    field :phone, :string
    field :website, :string

    field :legal_representative_first_name, :string
    field :legal_representative_last_name, :string
    field :legal_representative_cpf, :string
    field :legal_representative_birth_date, :date
    field :legal_representative_email, :string
    field :authorized_representative_first_name, :string
    field :authorized_representative_last_name, :string
    field :authorized_representative_cpf, :string
    field :authorized_representative_birth_date, :date
    field :authorized_representative_email, :string

    field :address_street, :string
    field :address_number, :string
    field :address_complement, :string
    field :address_neighborhood, :string
    field :address_city, :string
    field :address_state, :string
    field :address_zipcode, :string
    field :address_country, :string

    field :notes, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contractor, attrs) do
    contractor
    |> cast(attrs, [
      :entity_type,
      :full_name,
      :cpf,
      :birth_date,
      :nationality,
      :company_name,
      :trade_name,
      :cnpj,
      :company_type,
      :legal_representative_first_name,
      :legal_representative_last_name,
      :legal_representative_cpf,
      :legal_representative_birth_date,
      :legal_representative_email,
      :authorized_representative_first_name,
      :authorized_representative_last_name,
      :authorized_representative_cpf,
      :authorized_representative_birth_date,
      :authorized_representative_email,
      :email,
      :phone,
      :mobile_phone,
      :website,
      :address_street,
      :address_number,
      :address_complement,
      :address_neighborhood,
      :address_city,
      :address_state,
      :address_zipcode,
      :address_country,
      :notes
    ])

    # |> validate_required([
    #   :entity_type,
    #   :full_name,
    #   :cpf,
    #   :birth_date,
    #   :nationality,
    #   :company_name,
    #   :trade_name,
    #   :cnpj,
    #   :company_type,
    #   :legal_representative_first_name,
    #   :legal_representative_last_name,
    #   :legal_representative_cpf,
    #   :legal_representative_birth_date,
    #   :legal_representative_email,
    #   :authorized_representative_first_name,
    #   :authorized_representative_last_name,
    #   :authorized_representative_cpf,
    #   :authorized_representative_birth_date,
    #   :authorized_representative_email,
    #   :email,
    #   :phone,
    #   :mobile_phone,
    #   :website,
    #   :address_street,
    #   :address_number,
    #   :address_complement,
    #   :address_neighborhood,
    #   :address_city,
    #   :address_state,
    #   :address_zipcode,
    #   :address_country,
    #   :notes
    # ])
  end
end
