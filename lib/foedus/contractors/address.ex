defmodule Foedus.Contractors.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foedus.Contractors.Contractor

  @cast_fields ~w(address_type street number complement neighborhood
                city state zipcode country contractor_id)a

  @required_fields @cast_fields -- ~w(complement)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "addresses" do
    field :address_type, Ecto.Enum,
      values: [residential: 0, commercial: 1, billing: 3],
      default: :residential

    field :street, :string
    field :number, :string
    field :complement, :string
    field :neighborhood, :string
    field :city, :string
    field :state, :string
    field :zipcode, :string
    field :country, :string

    belongs_to :contractor, Contractor

    timestamps(type: :utc_datetime)
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
  end
end
