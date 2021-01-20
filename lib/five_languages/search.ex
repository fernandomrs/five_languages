defmodule FiveLanguages.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias FiveLanguages.Repo

  alias FiveLanguages.Search.Repository
  alias FiveLanguages.ApiGit.Search.Repositories
  alias FiveLanguages.ApiGit.Repositories.GetRepository

  @doc """
  Retorna a listagem de repositórios com mais estrelas de cinco linguagens.

  ## Examples
      iex> list_main_repositories(["elixir", "python", "swift", "kotlin", "javascript"])
      [%Repository{}, ...]

  """
  def list_main_repositories(languages) when is_list(languages) do
    Repository
    |> Repo.all()
    |> case do
      result when length(result) >= 5 ->
        {:ok, result}

      _ ->
        sync_main_repositories(languages)
    end
  end

  @doc """
  Consulta e salva os repositórios com mais estrelas de cinco linguagens.

  ## Examples
      iex> sync_main_repositories(["elixir", "python", "swift", "kotlin", "javascript"])
      [%Repository{}, ...]

  """
  def sync_main_repositories(languages) do
    Repo.delete_all(Repository)

    languages
    |> Task.async_stream(fn language ->
      attrs = search_repositories([
        q: "language:#{language}",
        per_page: 1,
        sort: "stars",
        order: "desc"
      ])

      %Repository{}
      |> Repository.changeset(attrs)
      |> Repo.insert!()
    end)
    |> Stream.into(%{})
    |> Enum.map(fn {:ok, item} -> item end)
  end

  defp search_repositories(params \\ []) do
    params
    |> Repositories.do_request()
    |> case do
      %{"items" => [item]} ->
        item
        |> Map.update!("owner", & Map.get(&1, "login"))
        |> Map.put("git_id", Map.get(item, "id"))

      error -> error
    end
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository(id) do
    repository = Repo.get!(Repository, id)

    repository
    |> Map.take([:owner, :name])
    |> GetRepository.do_request()
  end
end
