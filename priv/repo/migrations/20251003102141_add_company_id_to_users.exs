defmodule Foedus.Repo.Migrations.AddCompanyIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :company_id, references(:companies, on_delete: :delete_all, type: :binary_id)
    end

    create index(:users, [:company_id])
  end
end
