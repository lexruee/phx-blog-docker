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

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Content.get_comment!(id)

    case Content.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    {:ok, _comment} = Content.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
