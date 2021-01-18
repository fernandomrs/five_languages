defmodule FiveLanguages.Search.Repositoriy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do

    timestamps()
  end

  @doc false
  def changeset(repositoriy, attrs) do
    repositoriy
    |> cast(attrs, [])
    |> validate_required([])
  end
end
