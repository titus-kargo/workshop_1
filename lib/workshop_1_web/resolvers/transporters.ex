defmodule Workshop1.Resolvers.Transporters do
  def get_transporter_by_id(_entity, %{id: id}, _context) do
    {:ok, Workshop1.Transporters.get_transporter!(id)}
  end

  def create_transporter(_entity, %{input: transporter_params}, _context) do
    Workshop1.Transporters.create_transporter(transporter_params)
  end

  def update_transporter(_entity, %{input: transporter_params}, _context) do
    IO.inspect(transporter_params)
    transporter = Workshop1.Transporters.get_transporter!(transporter_params.id)
    Workshop1.Transporters.update_transporter(transporter, transporter_params)
  end
end
