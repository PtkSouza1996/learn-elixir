defmodule Blog.MyBlog.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(posts, attrs) do
    posts
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
