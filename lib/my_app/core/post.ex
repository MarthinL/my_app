defmodule MyApp.Core.Post do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part
  alias MyApp.Core.PostComment

  schema "bases" do
    field :part, Ecto.Enum, values: Part.no(:__enumerators__)
    field :text, :string, source: :value

    has_many :comment_links, PostComment, foreign_key: :post_id, where: [part: :post_comment]

    has_many :comments, through: [:comment_links, :comment], where: [part: :comment]

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text])
    |> put_change(:part, :post)
    |> validate_required([:part, :text])
  end
end
