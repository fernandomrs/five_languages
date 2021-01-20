defmodule FiveLanguagesWeb.RepositoryControllerTest do
  use FiveLanguagesWeb.ConnCase

  alias FiveLanguages.Search

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:repository) do
    {:ok, repository} = Search.create_repository(@create_attrs)
    repository
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end
  end

  defp create_repository(_) do
    repository = fixture(:repository)
    %{repository: repository}
  end
end
