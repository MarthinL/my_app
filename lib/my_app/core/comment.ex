defmodule MyApp.Core.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  use MyApp.Part
  alias MyApp.Core.PostComment

  schema "bases" do
    field :part, Ecto.Enum, values: Part.no(:__enumerators__)
    field :text, :string, source: :value

    has_one :post_link, PostComment, where: [part: :post_comment]
    has_one :post, through: [:post_link, :post]

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> put_change(:part, :comment)
    |> validate_required([:part, :text])
  end
end
