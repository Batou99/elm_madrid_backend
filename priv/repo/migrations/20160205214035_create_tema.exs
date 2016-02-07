defmodule TemariosApi.Repo.Migrations.CreateTema do
  use Ecto.Migration

  def change do
    create table(:temas) do
      add :titulo, :string
      add :duracion, :integer

      timestamps
    end

  end
end
