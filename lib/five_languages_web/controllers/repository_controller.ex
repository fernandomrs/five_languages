defmodule FiveLanguagesWeb.RepositoryController do
  use FiveLanguagesWeb, :controller

  alias FiveLanguages.Search

  def index(conn, params) do
    with %{"languages" => languages} <- params,
         5 <- Enum.count(languages) do
      languages
      |> Search.list_main_repositories()
      |> case do
        {:ok, repositories} ->
          render(conn, "index.html", repositories: repositories)

        _ ->
          conn
          |> put_status(:not_found)
      end

    else
      _ ->
        conn
        |> put_status(:expectation_failed)
        |> json(%{})
    end
  end

  def show(conn, %{"id" => id}) do
    id
    |> Search.get_repository()
    |> case do
      {:ok, repository} ->
        render(conn, "show.html", repository: repository)

      _ ->
        conn
        |> put_status(:expectation_failed)
        |> json(%{})
    end
  end
end
