defmodule FiveLanguages.Git do
  def search_repositories(params),
    do: adapter().search_repositories(params)

  def get_repositorio(params, opts \\ []),
    do: adapter().get_repositorio(params, opts)

  defp adapter do
    :five_languages
    |> Application.get_env(__MODULE__)
    |> Keyword.fetch!(:adapter)
  end
end
