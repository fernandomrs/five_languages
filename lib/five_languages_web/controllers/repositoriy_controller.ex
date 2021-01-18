defmodule FiveLanguagesWeb.RepositoriyController do
  use FiveLanguagesWeb, :controller

  alias FiveLanguages.Search
  alias FiveLanguages.Search.Repositoriy

  def index(conn, _params) do
    repositories = Search.list_repositories() |> IO.inspect
    render(conn, "index.html", repositories: repositories)
  end

  def new(conn, _params) do
    changeset = Search.change_repositoriy(%Repositoriy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repositoriy" => repositoriy_params}) do
    case Search.create_repositoriy(repositoriy_params) do
      {:ok, repositoriy} ->
        conn
        |> put_flash(:info, "Repositoriy created successfully.")
        |> redirect(to: Routes.repositoriy_path(conn, :show, repositoriy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repositoriy = Search.get_repositoriy!(id)
    render(conn, "show.html", repositoriy: repositoriy)
  end

  def edit(conn, %{"id" => id}) do
    repositoriy = Search.get_repositoriy!(id)
    changeset = Search.change_repositoriy(repositoriy)
    render(conn, "edit.html", repositoriy: repositoriy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repositoriy" => repositoriy_params}) do
    repositoriy = Search.get_repositoriy!(id)

    case Search.update_repositoriy(repositoriy, repositoriy_params) do
      {:ok, repositoriy} ->
        conn
        |> put_flash(:info, "Repositoriy updated successfully.")
        |> redirect(to: Routes.repositoriy_path(conn, :show, repositoriy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repositoriy: repositoriy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repositoriy = Search.get_repositoriy!(id)
    {:ok, _repositoriy} = Search.delete_repositoriy(repositoriy)

    conn
    |> put_flash(:info, "Repositoriy deleted successfully.")
    |> redirect(to: Routes.repositoriy_path(conn, :index))
  end
end
