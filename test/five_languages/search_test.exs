defmodule FiveLanguages.SearchTest do
  use FiveLanguages.DataCase

  import Mox

  alias FiveLanguages.Search
  alias FiveLanguages.Git.Adapters.Mock
  alias FiveLanguages.DataCase

  describe "repositories" do
    test "list_main_repositories/1 retorna todos os repositórios após primeira consulta" do
      expect(Mock, :search_repositories, & DataCase.many_repo_success/1)

      [repo] = Search.list_main_repositories(["teste"])

      save_repo = DataCase.get_save_repo()

      assert repo == save_repo
    end

    test "list_main_repositories/1 erro na consulta no git_api na primeira consulta dos repositórios" do
      expect(Mock, :search_repositories, & DataCase.many_repo_error/1)

      repos = Search.list_main_repositories(["teste"])

      assert Enum.empty?(repos)
    end

    test "list_main_repositories/1 retorna todos os repositórios após segunda consulta" do
      DataCase.insert_repositories()

      {:ok, repos} = Search.list_main_repositories(["teste"])

      assert Enum.count(repos) == 5
    end

    test "sync_main_repositories/1 retorna todos os repositórios" do
      expect(Mock, :search_repositories, & DataCase.many_repo_success/1)

      [repo] = Search.sync_main_repositories(["teste"])

      save_repo = DataCase.get_save_repo()

      assert repo == save_repo
    end

    test "sync_main_repositories/1 erro na consulta de repositórios" do
      expect(Mock, :search_repositories, & DataCase.many_repo_error/1)

      repos = Search.list_main_repositories(["teste"])

      assert Enum.empty?(repos)
    end

    test "get_repository/1 retorna o repositório de acordo com o id" do
    end

    test "get_repository/1 erro na consulta do banco ao retornar o repositório" do
    end

    test "get_repository/1 erro na consulta da api_git ao retornar o repositório" do
    end
  end
end
