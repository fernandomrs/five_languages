defmodule FiveLanguages.ApiGit.Repositories.GetRepository do
  @moduledoc """
  """

  use FiveLanguages.ApiGit.BaseRequest,
    path: "/repos/:owner/:name",
    method: :get
end
