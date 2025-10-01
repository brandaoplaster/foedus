defmodule Foedus.Repo.Migrations.CreatePlatformAccesses do
  use Ecto.Migration

  def change do
    create table(:platform_accesses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :login, :string
      add :password, :string
      add :status, :boolean, default: false, null: false
      add :deleted_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:platform_accesses, [:company_id])
    create index(:platform_accesses, [:user_id])
  end
end
