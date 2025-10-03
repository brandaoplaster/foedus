defmodule Foedus.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Accounts.{User, PlatformAccess}

  @required_fields ~w(trade_name cnpj active)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "companies" do
    field :active, :boolean, default: false
    field :trade_name, :string
    field :cnpj, :string

    has_many :users, User
    has_many :platform_accesses, PlatformAccess

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
