defmodule TemariosApi.TemaControllerTest do
  use TemariosApi.ConnCase

  alias TemariosApi.Tema
  @valid_attrs %{duracion: 42, titulo: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tema_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    tema = Repo.insert! %Tema{}
    conn = get conn, tema_path(conn, :show, tema)
    assert json_response(conn, 200)["data"] == %{"id" => tema.id,
      "titulo" => tema.titulo,
      "duracion" => tema.duracion}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tema_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, tema_path(conn, :create), tema: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Tema, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tema_path(conn, :create), tema: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    tema = Repo.insert! %Tema{}
    conn = put conn, tema_path(conn, :update, tema), tema: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Tema, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tema = Repo.insert! %Tema{}
    conn = put conn, tema_path(conn, :update, tema), tema: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    tema = Repo.insert! %Tema{}
    conn = delete conn, tema_path(conn, :delete, tema)
    assert response(conn, 204)
    refute Repo.get(Tema, tema.id)
  end
end
