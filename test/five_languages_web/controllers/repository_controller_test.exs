defmodule FiveLanguagesWeb.RepositoryControllerTest do
  use FiveLanguagesWeb.ConnCase

  import Mox

  alias FiveLanguages.Search
  alias FiveLanguages.Git.Adapters.Mock
  alias FiveLanguages.DataCase

  describe "index/1" do
    test "listar os repositórios", %{conn: conn} do
      stub(Mock, :search_repositories, & DataCase.search_repositories_success/1)

      languages = ["elixir", "python", "swift", "kotlin", "javascript"]

      conn = get(conn, Routes.repository_path(conn, :index, %{"languages"  => languages}))

      assert html_response(conn, 200)
    end

    test "erro ao listar os repositórios (menos de 5 linguagens como parâmetro)", %{conn: conn} do
      languages = ["elixir", "python", "swift", "kotlin"]

      conn = get(conn, Routes.repository_path(conn, :index, %{"languages"  => languages}))

      assert html_response(conn, 417)
    end

    test "erro ao listar os repositórios (repositórios não encontrados)", %{conn: conn} do
      stub(Mock, :search_repositories, & DataCase.search_repositories_error/1)

      languages = ["elixir", "python", "swift", "kotlin", "javascript"]

      conn = get(conn, Routes.repository_path(conn, :index, %{"languages"  => languages}))

      assert html_response(conn, 404)
    end
  end

  describe "show/1" do
    test "consultar repositório", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end

    test "erro ao consultar repositório (repositório não encontrado)", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 404) =~ "Listing Repositories"
    end
  end
end
