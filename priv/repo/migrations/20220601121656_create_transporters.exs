defmodule Workshop1.Repo.Migrations.CreateTransporters do
  use Ecto.Migration

  def change do
    create table(:transporters) do
      add :name, :string
      add :phone_number, :string
      add :npwp_number, :string
      add :status, :string

      timestamps()
    end
  end
end
