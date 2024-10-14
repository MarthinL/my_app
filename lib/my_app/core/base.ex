defmodule MyApp.Core.Base do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part

  @callback query() :: Ecto.Queryable.t

  schema "bases" do
    field :part, Ecto.Enum, values: Part.base(:__enumerators__)
    field :value, :string

    timestamps()
  end

  def query(callback_module), do: callback_module.query()

  @doc false
  def changeset(base, attrs) do
    base
    |> cast(attrs, [:value, :text])
    |> validate_required([:value, :text])
  end
end
