defmodule ETV.Data.Transaction do
  use ETV.Data.Repo.Schema

  alias ETV.Data.Transaction
  alias Enums.TxStatus


  @hash_regex ~r/^0x([A-Fa-f0-9]{64})$/
  @fields_required [:tx_hash, :status]



  # Schema
  # ------

  schema "transactions" do
    field :tx_hash, :string
    field :status,  TxStatus, default: :pending

    timestamps()
  end




  # Changeset
  # ---------

  @doc "Create Changeset"
  def changeset(struct \\ %Transaction{}, attrs) do
    struct
    |> cast(attrs, @fields_required)
    |> validate_required(@fields_required)
    |> validate_format(:tx_hash, @hash_regex)
    |> unique_constraint(:tx_hash)
  end




  # Public API
  # ----------

  @doc "Find all unconfirmed transactions"
  def unconfirmed do
    Transaction
    |> Query.where([t], t.status == ^:pending)
    |> Repo.all
  end


end
