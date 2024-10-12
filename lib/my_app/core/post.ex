defmodule MyApp.Core.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  use MyApp.Part
  alias MyApp.Core.Post
  alias MyApp.Core.PostComment

  @behaviour MyApp.Core.Base

  schema "bases" do
    field :part, Ecto.Enum, values: Part.base(:__enumerators__)
    field :text, :string, source: :value

    has_many :comment_links, PostComment, foreign_key: :post_id, where: [part: :post_comment]

    has_many :comments, through: [:comment_links, :comment], where: [part: :comment]

    timestamps()
  end

  def query() do
    from p in Post, where: p.part == :post
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text])
    |> put_change(:part, :post)
    |> validate_required([:part, :text])
  end
end
