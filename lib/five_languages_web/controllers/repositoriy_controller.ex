defmodule FiveLanguagesWeb.RepositoryController do
  use FiveLanguagesWeb, :controller

  alias FiveLanguages.Search
  alias FiveLanguages.Search.Repository

  def index(conn, _params) do
    repositories = Search.list_repositories() |> IO.inspect
    render(conn, "index.html", repositories: repositories)
  end

  def new(conn, _params) do
    changeset = Search.change_repository(%Repository{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repository" => repository_params}) do
    case Search.create_repository(repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository created successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repository = Search.get_repository!(id)
    render(conn, "show.html", repository: repository)
  end

  def edit(conn, %{"id" => id}) do
    repository = Search.get_repository!(id)
    changeset = Search.change_repository(repository)
    render(conn, "edit.html", repository: repository, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Search.get_repository!(id)

    case Search.update_repository(repository, repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository updated successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repository: repository, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Search.get_repository!(id)
    {:ok, _repository} = Search.delete_repository(repository)

    conn
    |> put_flash(:info, "Repository deleted successfully.")
    |> redirect(to: Routes.repository_path(conn, :index))
  end
end
