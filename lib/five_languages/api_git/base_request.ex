defmodule FiveLanguages.ApiGit.BaseRequest do
  @moduledoc """
  """

  @url "https://api.github.com"

  defmacro __using__(opts \\ []) do
    quote do
      alias FiveLanguages.ApiGit.BaseRequest

      @path unquote(opts[:path] || throw(:opts_path))
      @method unquote(opts[:method] || throw(:opts_method))

      @doc """
      """
      def do_request(params \\ []) do
        urn = BaseRequest.prepare_urn(params, @path)
        headers = BaseRequest.prepare_headers()

        @method
        |> BaseRequest.request(urn, params, headers)
        |> case do
          {:ok, %HTTPoison.Response{body: result, status_code: status}} when status in [200, 202] ->
            Jason.decode!(result)

          _ -> :error
        end
      end
    end
  end

  def prepare_headers() do
    [
      {"Content-type", "application/json"}
    ]
  end

  @doc """
  """
  def prepare_urn(params, urn) do
    ~r/:([a-z|_]+)?/
    |> Regex.replace(urn, fn _, match ->
      atom = String.to_existing_atom(match)

      params
      |> Map.get(atom)
      |> String.trim()
    end)
    |> String.replace(" ", "")
  end

  def request(method, urn, params, headers) when method in [:get, :delete] do
    HTTPoison.request(method, @url <> urn, "{}", headers, params: params)
  end

  def request(method, urn, params, headers) do
    HTTPoison.request(method, @url <> urn, Jason.encode!(params), headers)
  end
end
