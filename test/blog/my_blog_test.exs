defmodule Blog.MyBlogTest do
  use Blog.DataCase

  alias Blog.MyBlog

  describe "posts" do
    alias Blog.MyBlog.Posts

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def posts_fixture(attrs \\ %{}) do
      {:ok, posts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MyBlog.create_posts()

      posts
    end

    test "list_posts/0 returns all posts" do
      posts = posts_fixture()
      assert MyBlog.list_posts() == [posts]
    end

    test "get_posts!/1 returns the posts with given id" do
      posts = posts_fixture()
      assert MyBlog.get_posts!(posts.id) == posts
    end

    test "create_posts/1 with valid data creates a posts" do
      assert {:ok, %Posts{} = posts} = MyBlog.create_posts(@valid_attrs)
      assert posts.body == "some body"
      assert posts.title == "some title"
    end

    test "create_posts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MyBlog.create_posts(@invalid_attrs)
    end

    test "update_posts/2 with valid data updates the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{} = posts} = MyBlog.update_posts(posts, @update_attrs)
      assert posts.body == "some updated body"
      assert posts.title == "some updated title"
    end

    test "update_posts/2 with invalid data returns error changeset" do
      posts = posts_fixture()
      assert {:error, %Ecto.Changeset{}} = MyBlog.update_posts(posts, @invalid_attrs)
      assert posts == MyBlog.get_posts!(posts.id)
    end

    test "delete_posts/1 deletes the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{}} = MyBlog.delete_posts(posts)
      assert_raise Ecto.NoResultsError, fn -> MyBlog.get_posts!(posts.id) end
    end

    test "change_posts/1 returns a posts changeset" do
      posts = posts_fixture()
      assert %Ecto.Changeset{} = MyBlog.change_posts(posts)
    end
  end
end
