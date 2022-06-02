defmodule Workshop1.Repo do
  use Ecto.Repo,
    otp_app: :workshop_1,
    adapter: Ecto.Adapters.Postgres
end
