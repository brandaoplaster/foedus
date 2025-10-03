defmodule Foedus.Accounts.PlatformAccess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Accounts.{Company, User}

  @required_fields ~w(company_id user_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "platform_accesses" do
    belongs_to :company, Company
    belongs_to :user, User
    field :deleted_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(platform_access, attrs) do
    platform_access
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:company_id)
    |> foreign_key_constraint(:user_id)
  end
end
