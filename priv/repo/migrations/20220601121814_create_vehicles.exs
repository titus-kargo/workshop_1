defmodule Workshop1.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :license_plate, :string
      add :status, :string
      add :transporter_id, references(:transporters, on_delete: :nothing)

      timestamps()
    end

    create index(:vehicles, [:transporter_id])
  end
end
