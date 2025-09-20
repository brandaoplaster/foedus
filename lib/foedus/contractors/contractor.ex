defmodule Foedus.Contractors.Contractor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Contractors.{Address, Representative}

  @fields ~w(entity_type full_name document birth_date nationality mobile_phone
             company_name trade_name cnpj company_type email phone website notes)a

  @company_required_fields ~w(company_name trade_name cnpj company_type email phone website)a
  @individual_required_fields ~w(full_name document birth_date nationality mobile_phone)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contractors" do
    field :entity_type, Ecto.Enum, values: [company: 0, individual: 1], default: :company

    field :status, Ecto.Enum, values: [active: 0, inactive: 1, draft: 2], default: :draft

    field :full_name, :string
    field :document, :string
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

    field :notes, :string

    has_many :addresses, Address
    has_many :representatives, Representative

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contractor, attrs) do
    contractor
    |> cast(attrs, @fields)
    |> validate_required_by_entity_type()
    |> cast_assoc(:representatives, required: true)
    |> cast_assoc(:addresses, required: true)
  end

  defp validate_required_by_entity_type(%{changes: %{entity_type: :company}} = changeset) do
    validate_required(changeset, @company_required_fields)
  end

  defp validate_required_by_entity_type(%{changes: %{entity_type: :individual}} = changeset) do
    validate_required(changeset, @individual_required_fields)
  end

  defp validate_required_by_entity_type(changeset), do: changeset
end
