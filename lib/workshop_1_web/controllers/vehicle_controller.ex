defmodule Workshop1Web.VehicleController do
  use Workshop1Web, :controller

  alias Workshop1.Vehicles
  alias Workshop1.Vehicles.Vehicle

  action_fallback Workshop1Web.FallbackController

  defmodule Result do
    defstruct [:id, :license_plate, :transporter, :status]
  end

  def index(conn, _params) do
    vehicles = Vehicles.list_vehicles()
    IO.inspect(vehicles)
    render(conn, "index.json", vehicles: vehicles)
  end

  def create(conn, %{"vehicle" => vehicle_params}) do
    IO.inspect(vehicle_params["status"])
    vehicle_params = Map.put(vehicle_params, "status", "not_validated")
    IO.inspect(vehicle_params)
    # res = %Result{
    #   license_plate: vehicle_params["license_plate"],
    #   transporter: vehicle_params["transporter_id"],
    #   status: "not_validated"
    # }
    with {:ok, %Vehicle{} = vehicle} <- Vehicles.create_vehicle(vehicle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.vehicle_path(conn, :show, vehicle))
      |> render("show.json", vehicle: vehicle)
    end
  end

  def show(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)
    transporter = Workshop1.Transporters.get_transporter!(vehicle.transporter_id)
    # res = %{
    #   id: vehicle.id,
    #   license_plate: vehicle.license_plate,
    #   transporter: transporter,
    #   status: vehicle.status
    # }
    render(conn, "show.json", vehicle: vehicle)
  end

  def update(conn, %{"id" => id, "vehicle" => vehicle_params}) do
    vehicle = Vehicles.get_vehicle!(id)

    with {:ok, %Vehicle{} = vehicle} <- Vehicles.update_vehicle(vehicle, vehicle_params) do
      render(conn, "show.json", vehicle: vehicle)
    end
  end

  def status_update(conn, %{"id" => id, "status" => status}) do
    vehicle = Vehicles.get_vehicle!(id)
    vehicle_params = %{status: status}

    with {:ok, %Vehicle{} = vehicle} <- Vehicles.update_vehicle(vehicle, vehicle_params) do
      render(conn, "show.json", vehicle: vehicle)
    end
  end

  def delete(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)

    with {:ok, %Vehicle{}} <- Vehicles.delete_vehicle(vehicle) do
      send_resp(conn, :no_content, "")
    end
  end
end
