defmodule MyApp.Core.Basis do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part

  schema "bases" do
    field :part, Ecto.Enum, values: Part.no(:__enumerators__)
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(basis, attrs) do
    basis
    |> cast(attrs, [:value, :text])
    |> validate_required([:value, :text])
  end
end
