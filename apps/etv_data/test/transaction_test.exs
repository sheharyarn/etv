defmodule Tests.ETV.Data.Transaction do
  use ExUnit.Case, async: true

  alias ETV.Data.Transaction
  alias Tests.Support



  setup(tags) do
    Support.Ecto.setup(tags)
  end



  describe "#changeset" do
    @valid_hash "0x07b2aab7860ab5e9b7a21e86f148c38b1314c7137de3f7c8f091184977ba74cf"
    @invalid_hash "some_invalid_hash"


    test "it validates presence of hash" do
      changeset = Transaction.changeset(%{})

      refute changeset.valid?
      assert changeset.errors[:tx_hash] == {"can't be blank", [validation: :required]}
    end


    test "it returns a changeset for valid tx hashes" do
      changeset = Transaction.changeset(%{tx_hash: @valid_hash})
      assert changeset.valid?
    end


    test "it returns error for invalid tx hashes" do
      changeset = Transaction.changeset(%{tx_hash: @invalid_hash})

      refute changeset.valid?
      assert changeset.errors[:tx_hash] == {"has invalid format", [validation: :format]}
    end
  end



  describe "#unconfirmed" do
    setup do
      txs = [
        %Transaction{tx_hash: build_hash(1), status: :pending},
        %Transaction{tx_hash: build_hash(2), status: :pending},
        %Transaction{tx_hash: build_hash(3), status: :complete},
        %Transaction{tx_hash: build_hash(4), status: :pending},
        %Transaction{tx_hash: build_hash(5), status: :complete},
      ]

      Enum.each(txs, &Transaction.insert!/1)
    end


    test "returns only pending transactions" do
      txs = Transaction.unconfirmed

      assert length(txs) == 3
      assert %{status: :pending} = hd(txs)
    end

  end





  # Private Helpers
  # ---------------

  @base    16
  @length  64
  @default "0"
  @prefix  "0x"

  defp build_hash(integer) do
    hex =
      integer
      |> Integer.to_string(@base)
      |> String.pad_leading(@length, @default)

    @prefix <> hex
  end

end
