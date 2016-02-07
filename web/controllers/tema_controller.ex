defmodule TemariosApi.TemaController do
  use TemariosApi.Web, :controller

  alias TemariosApi.Tema

  plug :scrub_params, "tema" when action in [:create, :update]

  def index(conn, _params) do
    temas = Repo.all(Tema)
    render(conn, "index.json", temas: temas)
  end

  def create(conn, %{"tema" => tema_params}) do
    changeset = Tema.changeset(%Tema{}, tema_params)

    case Repo.insert(changeset) do
      {:ok, tema} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", tema_path(conn, :show, tema))
        |> render("show.json", tema: tema)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TemariosApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tema = Repo.get!(Tema, id)
    render(conn, "show.json", tema: tema)
  end

  def update(conn, %{"id" => id, "tema" => tema_params}) do
    tema = Repo.get!(Tema, id)
    changeset = Tema.changeset(tema, tema_params)

    case Repo.update(changeset) do
      {:ok, tema} ->
        render(conn, "show.json", tema: tema)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TemariosApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tema = Repo.get!(Tema, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tema)

    send_resp(conn, :no_content, "")
  end
end
