defmodule MyApp.Core.PostComment do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part
  alias MyApp.Core.{Post, Comment}

  schema "links" do
    field :part, Ecto.Enum, values: Part.link(:__enumerators__)

    belongs_to :post, Post, source: :parent_id, where: [part: :post]
    belongs_to :comment, Comment, source: :child_id, where: [part: :comment]

    timestamps()
  end

  @doc false
  def changeset(base, attrs) do
    base
    |> cast(attrs, [:part, :post_id, :comment_id])
    |> put_change(:part, :post_comment)
    |> validate_required([:part, :post_id, :comment_id])
  end
end
