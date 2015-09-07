defmodule Chatt.Message do
  use Chatt.Web, :model

  schema "messages" do
    field :content, :string
    belongs_to :room, Chatt.Room

    timestamps
  end

  @required_fields ~w(content)
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
