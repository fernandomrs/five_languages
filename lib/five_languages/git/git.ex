defmodule FiveLanguages.Git do
  @moduledoc """

  """

  @doc """

  """
  def search_repositories(params),
    do: adapter().search_repositories(params)

  @doc """

  """
  def get_repository(params, opts \\ []),
    do: adapter().get_repository(params, opts)

  defp adapter do
    :five_languages
    |> Application.get_env(__MODULE__)
    |> Keyword.fetch!(:adapter)
  end
end
