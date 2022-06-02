defmodule Workshop1Web.TransporterControllerTest do
  use Workshop1Web.ConnCase

  import Workshop1.TransportersFixtures

  alias Workshop1.Transporters.Transporter

  @create_attrs %{
    name: "some name",
    npwp_number: "some npwp_number",
    phone_number: "some phone_number",
    status: "some status"
  }
  @update_attrs %{
    name: "some updated name",
    npwp_number: "some updated npwp_number",
    phone_number: "some updated phone_number",
    status: "some updated status"
  }
  @invalid_attrs %{name: nil, npwp_number: nil, phone_number: nil, status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transporters", %{conn: conn} do
      conn = get(conn, Routes.transporter_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transporter" do
    test "renders transporter when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transporter_path(conn, :create), transporter: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transporter_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "npwp_number" => "some npwp_number",
               "phone_number" => "some phone_number",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transporter_path(conn, :create), transporter: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transporter" do
    setup [:create_transporter]

    test "renders transporter when data is valid", %{conn: conn, transporter: %Transporter{id: id} = transporter} do
      conn = put(conn, Routes.transporter_path(conn, :update, transporter), transporter: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.transporter_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "npwp_number" => "some updated npwp_number",
               "phone_number" => "some updated phone_number",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transporter: transporter} do
      conn = put(conn, Routes.transporter_path(conn, :update, transporter), transporter: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transporter" do
    setup [:create_transporter]

    test "deletes chosen transporter", %{conn: conn, transporter: transporter} do
      conn = delete(conn, Routes.transporter_path(conn, :delete, transporter))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transporter_path(conn, :show, transporter))
      end
    end
  end

  defp create_transporter(_) do
    transporter = transporter_fixture()
    %{transporter: transporter}
  end
end
