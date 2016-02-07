defmodule TemariosApi.Tema do
  use TemariosApi.Web, :model

  schema "temas" do
    field :titulo, :string
    field :duracion, :integer

    timestamps
  end

  @required_fields ~w(titulo duracion)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
