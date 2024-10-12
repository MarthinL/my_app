defmodule MyApp.Core.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  use MyApp.Part
  alias MyApp.Core.PostComment
  alias MyApp.Core.Comment

  @behaviour MyApp.Core.Base

  schema "bases" do
    field :part, Ecto.Enum, values: Part.base(:__enumerators__)
    field :text, :string, source: :value

    has_one :post_link, PostComment, where: [part: :post_comment]
    has_one :post, through: [:post_link, :post]

    timestamps()
  end

  def query() do
    from c in Comment, where: c.part == :comment
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> put_change(:part, :comment)
    |> validate_required([:part, :text])
  end
end
