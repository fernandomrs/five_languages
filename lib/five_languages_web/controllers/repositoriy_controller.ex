defmodule FiveLanguagesWeb.RepositoryController do
  use FiveLanguagesWeb, :controller

  alias FiveLanguages.Search

  def index(conn, _params) do
    repositories = Search.list_repositories()
    render(conn, "index.html", repositories: repositories)
  end

  def show(conn, %{"id" => id}) do
    repository = Search.get_repository!(id)
    render(conn, "show.html", repository: repository)
  end
end
