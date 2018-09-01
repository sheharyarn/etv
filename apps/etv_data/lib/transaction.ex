defmodule ETV.Data.Transaction do
  use ETV.Data.Repo.Schema
  alias Enums.TxStatus



  # Schema
  # ------

  @fields_required [:tx_hash, :status]

  schema "transactions" do
    field :tx_hash, :string
    field :status,  TxStatus, default: :pending

    timestamps()
  end




  # Changeset
  # ---------


  @doc "Create Changeset"
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @fields_required)
    |> validate_required(@fields_required)
    |> unique_constraint(:tx_hash)
  end

end
