defmodule Foedus.Repo.Migrations.CreateContractTemplates do
  use Ecto.Migration

  def change do
    create table(:contract_templates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :content, :text, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:contract_templates, [:title])
  end
end
