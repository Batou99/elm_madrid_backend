defmodule TemariosApi.TemaView do
  use TemariosApi.Web, :view

  def render("index.json", %{temas: temas}) do
    render_many(temas, TemariosApi.TemaView, "tema.json")
  end

  def render("show.json", %{tema: tema}) do
    render_one(tema, TemariosApi.TemaView, "tema.json")
  end

  def render("tema.json", %{tema: tema}) do
    %{id: tema.id,
      titulo: tema.titulo,
      duracion: tema.duracion}
  end
end
