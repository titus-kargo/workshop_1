defmodule Workshop1.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field :license_plate, :string
    field :status, :string
    field :transporter_id, :id

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:license_plate, :transporter_id, :status])
    |> validate_required([:license_plate, :transporter_id])
  end
end
