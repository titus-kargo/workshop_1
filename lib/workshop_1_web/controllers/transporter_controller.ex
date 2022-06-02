defmodule Workshop1Web.TransporterController do
  use Workshop1Web, :controller

  alias Workshop1.Transporters
  alias Workshop1.Transporters.Transporter

  action_fallback Workshop1Web.FallbackController

  def index(conn, _params) do
    transporters = Transporters.list_transporters()
    render(conn, "index.json", transporters: transporters)
  end

  def create(conn, %{"transporter" => transporter_params}) do
    with {:ok, %Transporter{} = transporter} <- Transporters.create_transporter(transporter_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transporter_path(conn, :show, transporter))
      |> render("show.json", transporter: transporter)
    end
  end

  def show(conn, %{"id" => id}) do
    transporter = Transporters.get_transporter!(id)
    render(conn, "show.json", transporter: transporter)
  end

  def update(conn, %{"id" => id, "transporter" => transporter_params}) do
    transporter = Transporters.get_transporter!(id)

    with {:ok, %Transporter{} = transporter} <- Transporters.update_transporter(transporter, transporter_params) do
      render(conn, "show.json", transporter: transporter)
    end
  end

  def status_update(conn, %{"id" => id, "status" => status}) do
    transporter = Transporters.get_transporter!(id)
    transporter_params = %{status: status}

    with {:ok, %Transporter{} = transporter} <- Transporters.update_transporter(transporter, transporter_params) do
      render(conn, "show.json", transporter: transporter)
    end
  end

  def delete(conn, %{"id" => id}) do
    transporter = Transporters.get_transporter!(id)

    with {:ok, %Transporter{}} <- Transporters.delete_transporter(transporter) do
      send_resp(conn, :no_content, "")
    end
  end
end
