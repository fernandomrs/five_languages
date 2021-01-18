defmodule FiveLanguages.ApiGit.SearchRepositories do
  @moduledoc """
  """

  use FiveLanguages.ApiGit.BaseRequest,
    path: "/search/repositories",
    method: :get
end
