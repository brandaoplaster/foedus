defmodule Foedus.Contracts.Signer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Accounts.Company

  @fields_required ~w(name lastname email role  company_id)a
  @fields_optional ~w(document birthdate status)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "signers" do
    field :name, :string
    field :status, :boolean, default: false
    field :role, :string
    field :lastname, :string
    field :email, :string
    field :document, :string
    field :birthdate, :date

    belongs_to :company, Company

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(signer, attrs) do
    signer
    |> cast(attrs, @fields_required ++ @fields_optional)
    |> validate_required(@fields_required)
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:lastname, min: 2, max: 100)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "must be a valid email")
    |> foreign_key_constraint(:company_id)
  end
end
