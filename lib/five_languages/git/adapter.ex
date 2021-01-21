defmodule FiveLanguages.Git.Adapter do

  @callback search_repositories(map()) :: [map()] | :error
  @callback get_repositorio(map()) :: map()

end
