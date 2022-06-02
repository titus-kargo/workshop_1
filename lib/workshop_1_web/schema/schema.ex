defmodule Workshop1Web.Schema do
  use Absinthe.Schema
  alias Workshop1.Resolvers.Vehicles
  alias Workshop1.Resolvers.Transporters

  import_types(Workshop1.Schema.Context.Vehicles.Types)
  import_types(Workshop1.Schema.Context.Transporters.Types)

  query do
    field :get_vehicle_by_id, :vehicle do
      arg(:id, non_null(:id))
      resolve(&Vehicles.get_vehicle_by_id/3)
    end

    field :list_vehicles, list_of(:vehicle) do
      resolve(fn _entity, _args, _context ->
        {:ok, Workshop1.Vehicles.list_vehicles()}
      end)
    end

    field :get_transporter_by_id, :transporter do
      arg(:id, non_null(:id))
      resolve(&Transporters.get_transporter_by_id/3)
    end

    field :list_transporters, list_of(:transporter) do
      resolve(fn _entity, _args, _context ->
        {:ok, Workshop1.Transporters.list_transporters()}
      end)
    end
  end

  mutation do
    field :create_vehicle, :vehicle do
      arg(:input, :vehicle_input)
      resolve(&Vehicles.create_vehicle/3)
    end

    field :create_transporter, :transporter do
      arg(:input, :transporter_input)
      resolve(&Transporters.create_transporter/3)
    end
  end
end
