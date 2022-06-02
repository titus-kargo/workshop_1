defmodule Workshop1.Schema.Context.Vehicles.Types do
  use Absinthe.Schema.Notation

  object :vehicle do
    field :id, :id
    field :license_plate, :string
    field :transporter_id, :id
    field :status, :string
  end

  input_object :vehicle_input do
    field :license_plate, :string
    field :transporter_id, :id
  end
end
