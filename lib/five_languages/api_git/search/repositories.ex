defmodule FiveLanguages.ApiGit.Search.Repositories do
  @moduledoc """
  """

  use FiveLanguages.ApiGit.BaseRequest,
    path: "/search/repositories",
    method: :get
end
