defmodule Workshop1.Resolvers.Vehicles do
  def get_vehicle_by_id(_entity, %{id: id}, _context) do
    {:ok, Workshop1.Vehicles.get_vehicle!(id)}
  end

  def create_vehicle(_entity, %{input: vehicle_params}, _context) do
    Workshop1.Vehicles.create_vehicle(vehicle_params)
  end
end
