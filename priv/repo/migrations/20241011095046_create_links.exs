defmodule MyApp.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :part, :integer
      add :parent_id, references(:bases, on_delete: :nothing)
      add :child_id, references(:bases, on_delete: :nothing)

      timestamps()
    end

    create index(:links, [:parent_id])
    create index(:links, [:child_id])
  end
end
