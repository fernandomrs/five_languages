defmodule FiveLanguages.SearchTest do
  use FiveLanguages.DataCase

  alias FiveLanguages.Search

  describe "repositories" do
    test "list_main_repositories/1 retorna todos os repositórios após primeira consulta" do
      repository = repository_fixture()
      assert Search.list_main_repositories() == [repository]
    end

    test "list_main_repositories/1 erro na consulta no git_api na primeira consulta dos repositórios" do
    end

    test "list_main_repositories/1 erro na consulta do banco na primeira consulta dos repositórios" do
    end

    test "list_main_repositories/1 retorna todos os repositórios após segunda consulta" do
    end

    test "sync_main_repositories/1 retorna todos os repositórios" do
    end

    test "sync_main_repositories/1 erro ao excluir os repositórios" do
    end

    test "sync_main_repositories/1 erro na consulta de um ou mais repositórios" do
    end

    test "get_repository/1 retorna o repositório de acordo com o id" do
    end

    test "get_repository/1 erro na consulta do banco ao retornar o repositório" do
    end

    test "get_repository/1 erro na consulta da api_git ao retornar o repositório" do
    end
  end
end
