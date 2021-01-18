defmodule FiveLanguages.SearchTest do
  use FiveLanguages.DataCase

  alias FiveLanguages.Search

  describe "repositories" do
    alias FiveLanguages.Search.Repository

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Search.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Search.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Search.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Search.create_repository(@valid_attrs)
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Search.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{} = repository} = Search.update_repository(repository, @update_attrs)
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Search.update_repository(repository, @invalid_attrs)
      assert repository == Search.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Search.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Search.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Search.change_repository(repository)
    end
  end
end
