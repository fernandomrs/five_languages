defmodule FiveLanguages.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias FiveLanguages.Repo

  alias FiveLanguages.Search.Repositoriy

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repositoriy{}, ...]

  """
  def list_repositories do
    url = "https://api.github.com/search/repositories?q=language:elixir&per_page=1"
    url
    |> HTTPoison.get!()
    |> case do
      %HTTPoison.Response{body: body} -> Jason.decode!(body)
      _ -> :error
    end
    |> case do
      %{"items" => items} -> items
      error -> error
    end
    # Repo.all(Repositoriy)
  end

  @doc """
  Gets a single repositoriy.

  Raises `Ecto.NoResultsError` if the Repositoriy does not exist.

  ## Examples

      iex> get_repositoriy!(123)
      %Repositoriy{}

      iex> get_repositoriy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repositoriy!(id), do: Repo.get!(Repositoriy, id)

  @doc """
  Creates a repositoriy.

  ## Examples

      iex> create_repositoriy(%{field: value})
      {:ok, %Repositoriy{}}

      iex> create_repositoriy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repositoriy(attrs \\ %{}) do
    %Repositoriy{}
    |> Repositoriy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repositoriy.

  ## Examples

      iex> update_repositoriy(repositoriy, %{field: new_value})
      {:ok, %Repositoriy{}}

      iex> update_repositoriy(repositoriy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repositoriy(%Repositoriy{} = repositoriy, attrs) do
    repositoriy
    |> Repositoriy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repositoriy.

  ## Examples

      iex> delete_repositoriy(repositoriy)
      {:ok, %Repositoriy{}}

      iex> delete_repositoriy(repositoriy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repositoriy(%Repositoriy{} = repositoriy) do
    Repo.delete(repositoriy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repositoriy changes.

  ## Examples

      iex> change_repositoriy(repositoriy)
      %Ecto.Changeset{data: %Repositoriy{}}

  """
  def change_repositoriy(%Repositoriy{} = repositoriy, attrs \\ %{}) do
    Repositoriy.changeset(repositoriy, attrs)
  end
end
