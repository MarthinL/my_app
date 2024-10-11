defmodule MyApp.Repo.Migrations.CreateBases do
  use Ecto.Migration

  def change do
    create table(:bases) do
      add :part, :integer
      add :value, :string

      timestamps()
    end
  end
end
