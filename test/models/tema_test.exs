defmodule TemariosApi.TemaTest do
  use TemariosApi.ModelCase

  alias TemariosApi.Tema

  @valid_attrs %{duracion: 42, titulo: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tema.changeset(%Tema{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tema.changeset(%Tema{}, @invalid_attrs)
    refute changeset.valid?
  end
end
