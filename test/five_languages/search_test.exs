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

    test "list_repositories/1 returns all repositories" do
      repository = repository_fixture()
      assert Search.list_repositories() == [repository]
    end

    test "get_repository/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Search.get_repository!(repository.id) == repository
    end
  end
end
