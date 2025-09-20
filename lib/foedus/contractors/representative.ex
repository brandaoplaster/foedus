defmodule Foedus.Contractors.Representative do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Contractors.Contractor

  @required_fields ~w(role first_name last_name document birth_date email phone contractor_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "representatives" do
    field :role, Ecto.Enum, values: [legal: 0, autorizado: 1, other: 3], default: :legal
    field :first_name, :string
    field :last_name, :string
    field :document, :string
    field :birth_date, :date
    field :email, :string
    field :phone, :string

    belongs_to :contractor, Contractor

    timestamps(type: :utc_datetime)
  end

  def changeset(representative, attrs) do
    representative
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
