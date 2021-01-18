defmodule FiveLanguages.SearchTest do
  use FiveLanguages.DataCase

  alias FiveLanguages.Search

  describe "repositories" do
    alias FiveLanguages.Search.Repositoriy

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def repositoriy_fixture(attrs \\ %{}) do
      {:ok, repositoriy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Search.create_repositoriy()

      repositoriy
    end

    test "list_repositories/0 returns all repositories" do
      repositoriy = repositoriy_fixture()
      assert Search.list_repositories() == [repositoriy]
    end

    test "get_repositoriy!/1 returns the repositoriy with given id" do
      repositoriy = repositoriy_fixture()
      assert Search.get_repositoriy!(repositoriy.id) == repositoriy
    end

    test "create_repositoriy/1 with valid data creates a repositoriy" do
      assert {:ok, %Repositoriy{} = repositoriy} = Search.create_repositoriy(@valid_attrs)
    end

    test "create_repositoriy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Search.create_repositoriy(@invalid_attrs)
    end

    test "update_repositoriy/2 with valid data updates the repositoriy" do
      repositoriy = repositoriy_fixture()
      assert {:ok, %Repositoriy{} = repositoriy} = Search.update_repositoriy(repositoriy, @update_attrs)
    end

    test "update_repositoriy/2 with invalid data returns error changeset" do
      repositoriy = repositoriy_fixture()
      assert {:error, %Ecto.Changeset{}} = Search.update_repositoriy(repositoriy, @invalid_attrs)
      assert repositoriy == Search.get_repositoriy!(repositoriy.id)
    end

    test "delete_repositoriy/1 deletes the repositoriy" do
      repositoriy = repositoriy_fixture()
      assert {:ok, %Repositoriy{}} = Search.delete_repositoriy(repositoriy)
      assert_raise Ecto.NoResultsError, fn -> Search.get_repositoriy!(repositoriy.id) end
    end

    test "change_repositoriy/1 returns a repositoriy changeset" do
      repositoriy = repositoriy_fixture()
      assert %Ecto.Changeset{} = Search.change_repositoriy(repositoriy)
    end
  end
end
