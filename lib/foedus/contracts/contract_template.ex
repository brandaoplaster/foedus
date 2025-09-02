defmodule Foedus.Contracts.ContractTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contract_templates" do
    field :title, :string
    field :content, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contract_template, attrs) do
    contract_template
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
