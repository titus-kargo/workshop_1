defmodule Workshop1Web.VehicleView do
  use Workshop1Web, :view
  alias Workshop1Web.VehicleView

  def render("index.json", %{vehicles: vehicles}) do
    %{data: render_many(vehicles, VehicleView, "vehicle.json")}
  end

  def render("show.json", %{vehicle: vehicle}) do
    %{data: render_one(vehicle, VehicleView, "vehicle.json")}
  end

  def render("vehicle.json", %{vehicle: vehicle}) do
    %{
      id: vehicle.id,
      license_plate: vehicle.license_plate,
      transporter: vehicle.transporter_id,
      status: vehicle.status
    }
  end
end
