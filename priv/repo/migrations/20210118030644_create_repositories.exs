defmodule FiveLanguages.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do

      timestamps()
    end

  end
end
