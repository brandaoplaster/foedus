defmodule Foedus.Contracts.ContractTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Accounts.User

  @required_fields ~w(title content user_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contract_templates" do
    field :title, :string
    field :content, :string

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contract_template, attrs) do
    contract_template
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 3, max: 255)
    |> validate_length(:content, min: 100)
    |> assoc_constraint(:user)
  end
end
