defmodule Workshop1.Schema.Context.Transporters.Types do
  use Absinthe.Schema.Notation

  object :transporter do
    field :id, :id
    field :name, :string
    field :npwp_number, :string
    field :phone_number, :string
    field :status, :string
  end

  input_object :transporter_input do
    field :name, :string
    field :npwp_number, :string
    field :phone_number, :string
  end
end
