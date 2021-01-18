defmodule FiveLanguagesWeb.RepositoriyControllerTest do
  use FiveLanguagesWeb.ConnCase

  alias FiveLanguages.Search

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:repositoriy) do
    {:ok, repositoriy} = Search.create_repositoriy(@create_attrs)
    repositoriy
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get(conn, Routes.repositoriy_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end
  end

  describe "new repositoriy" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.repositoriy_path(conn, :new))
      assert html_response(conn, 200) =~ "New Repositoriy"
    end
  end

  describe "create repositoriy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.repositoriy_path(conn, :create), repositoriy: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.repositoriy_path(conn, :show, id)

      conn = get(conn, Routes.repositoriy_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Repositoriy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.repositoriy_path(conn, :create), repositoriy: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Repositoriy"
    end
  end

  describe "edit repositoriy" do
    setup [:create_repositoriy]

    test "renders form for editing chosen repositoriy", %{conn: conn, repositoriy: repositoriy} do
      conn = get(conn, Routes.repositoriy_path(conn, :edit, repositoriy))
      assert html_response(conn, 200) =~ "Edit Repositoriy"
    end
  end

  describe "update repositoriy" do
    setup [:create_repositoriy]

    test "redirects when data is valid", %{conn: conn, repositoriy: repositoriy} do
      conn = put(conn, Routes.repositoriy_path(conn, :update, repositoriy), repositoriy: @update_attrs)
      assert redirected_to(conn) == Routes.repositoriy_path(conn, :show, repositoriy)

      conn = get(conn, Routes.repositoriy_path(conn, :show, repositoriy))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, repositoriy: repositoriy} do
      conn = put(conn, Routes.repositoriy_path(conn, :update, repositoriy), repositoriy: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Repositoriy"
    end
  end

  describe "delete repositoriy" do
    setup [:create_repositoriy]

    test "deletes chosen repositoriy", %{conn: conn, repositoriy: repositoriy} do
      conn = delete(conn, Routes.repositoriy_path(conn, :delete, repositoriy))
      assert redirected_to(conn) == Routes.repositoriy_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.repositoriy_path(conn, :show, repositoriy))
      end
    end
  end

  defp create_repositoriy(_) do
    repositoriy = fixture(:repositoriy)
    %{repositoriy: repositoriy}
  end
end
