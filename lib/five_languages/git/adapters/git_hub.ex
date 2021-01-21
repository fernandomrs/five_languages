defmodule FiveLanguages.Git.Adapters.GitHub do

  @behaviour FiveLanguages.Git.Adapter

  @url "https://api.github.com"

  def search_repositories(params) do
    "#{@url}/search/repositories"
    |> HTTPoison.get([], params: params)
    |> handler_response()
  end

  def get_repositorio(%{owner: owner, name: name}, opts \\ []) do
    "#{@url}/repos/#{owner}/#{name}"
    |> HTTPoison.get()
    |> handler_response()
  end

  defp handler_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body, keys: :atoms)}

      {:ok, %HTTPoison.Response{status_code: 422}} ->
        :error

      _ ->
        :error
    end
  end
end
