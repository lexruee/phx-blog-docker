defmodule Blog.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    field :title, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
