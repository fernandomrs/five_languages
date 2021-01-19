defmodule FiveLanguages.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias FiveLanguages.Repo

  alias FiveLanguages.Search.Repository
  alias FiveLanguages.ApiGit.SearchRepositories

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """

  # FiveLanguages.Search.list_repositories(["elixir", "python", "swift", "kotlin", "javascript"])
  def list_repositories(languages) do
    sync_main_repositories(languages)
    Repo.all(Repository)
  end

  defp sync_main_repositories(languages) do
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
      |> Repo.insert()
    end)
    |> Stream.into(%{})
    |> Enum.map(fn {:ok, item} -> item end)
  end

  def search_repositories(params \\ []) do
    params
    |> SearchRepositories.do_request()
    |> case do
      %{"items" => [item]} ->
        item
        |> Map.update!("owner", & &1["login"])
        |> IO.inspect()
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
  def get_repository!(id), do: Repo.get!(Repository, id)

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{data: %Repository{}}

  """
  def change_repository(%Repository{} = repository, attrs \\ %{}) do
    Repository.changeset(repository, attrs)
  end
end
