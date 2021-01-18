defmodule FiveLanguages.ApiGit.BaseRequest do
  @moduledoc """
  """

  defmacro __using__(opts \\ []) do
    quote do
      alias FiveLanguages.ApiGit.BaseRequest

      @path unquote(opts[:path] || throw(:opts_path))
      @method unquote(opts[:method] || throw(:opts_method))

      @doc """
      """
      def do_request(params \\ []) do
        urn = BaseRequest.prepare_urn(@method, params, @path)
        body = BaseRequest.prepare_body(@method, params, @path)
        headers = BaseRequest.prepare_headers()

        @method
        |> HTTPoison.request("https://api.github.com#{urn}", body, headers)
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
  def prepare_urn(:get, params, urn) do
    params =
      params
      |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
      |> Enum.join("&")

    "urn?#{params}"
  end

  def prepare_urn(_, _, urn), do: urn

  def prepare_body(_, _, _), do: %{}
end
