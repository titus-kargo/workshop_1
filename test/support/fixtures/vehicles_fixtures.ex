defmodule Workshop1.VehiclesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workshop1.Vehicles` context.
  """

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        license_plate: "some license_plate"
      })
      |> Workshop1.Vehicles.create_vehicle()

    vehicle
  end

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        id: 42,
        license_plate: "some license_plate"
      })
      |> Workshop1.Vehicles.create_vehicle()

    vehicle
  end

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        license_plate: "some license_plate",
        status: "some status"
      })
      |> Workshop1.Vehicles.create_vehicle()

    vehicle
  end
end
