defmodule FiveLanguages.Search.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [])
    |> validate_required([])
  end
end
