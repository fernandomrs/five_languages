defmodule FiveLanguagesWeb.RepositoryController do
  use FiveLanguagesWeb, :controller

  alias FiveLanguages.Search

  def index(conn, _params) do
    {:ok, repositories} = Search.list_main_repositories(["elixir", "python", "swift", "kotlin", "javascript"])
    render(conn, "index.html", repositories: repositories)
  end

  def show(conn, %{"id" => id}) do
    repository = Search.get_repository(id)
    render(conn, "show.html", repository: repository)
  end
end
