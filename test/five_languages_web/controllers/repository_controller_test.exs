defmodule FiveLanguagesWeb.RepositoryControllerTest do
  use FiveLanguagesWeb.ConnCase

  alias FiveLanguages.Search

  describe "index" do
    test "listar os repositórios", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end

    test "erro ao listar os repositórios", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 417) =~ "Listing Repositories"
    end
  end

  describe "show/1" do
    test "consultar repositório", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end

    test "erro ao consultar repositório", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end
  end
end
