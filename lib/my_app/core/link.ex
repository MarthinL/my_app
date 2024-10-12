defmodule MyApp.Core.Link do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part
  alias MyApp.Core.Base

  schema "links" do
    field :part, Ecto.Enum, values: Part.link(:__enumerators__)

    belongs_to :parent, Base, foreign_key: :parent_id
    belongs_to :child, Base, foreign_key: :child_id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:part, :parent_id, :child_id])
    |> validate_required([:part, :parent_id, :child_id])
  end
end
