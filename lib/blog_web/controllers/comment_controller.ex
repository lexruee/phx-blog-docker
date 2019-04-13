defmodule BlogWeb.CommentController do
  use BlogWeb, :controller
  import IEx

  alias Blog.Content
  alias Blog.Content.Comment

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Content.get_post!(post_id)
    case Content.create_comment(post, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Comment couldn't been saved.")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end

  def delete(conn, %{"id" => id, "post_id" => post_id}) do
    post = Content.get_post!(post_id)
    comment = Content.get_comment!(id)
    {:ok, _comment} = Content.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :show, post))
  end
end
