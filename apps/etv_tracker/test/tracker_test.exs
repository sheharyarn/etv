defmodule Tests.ETV.Tracker do
  use ExUnit.Case, async: true

  alias ETV.Tracker
  alias ETV.Data.Transaction
  alias Tests.Support


  setup(tags) do
    _ecto  = Support.Ecto.setup(tags)
    bypass = Support.Bypass.setup

    {:ok, [bypass: bypass]}
  end



  describe "#update_tx" do
    @hash Support.TX.build_hash(10)
    setup(context) do
      tx = Transaction.insert!(%Transaction{tx_hash: @hash, status: :pending})
      Map.put(context, :tx, tx)
    end


    test "it does nothing when tx confirmations aren't enough", %{bypass: bypass, tx: tx} do
      expect_response(bypass, @hash, 0)

      assert {:error, :unconfirmed} = Tracker.update_tx(tx, false)
      assert tx == Transaction.get_by(tx_hash: @hash)
    end


    test "it marks tx 'complete' for enough confirmations", %{bypass: bypass, tx: tx} do
      expect_response(bypass, @hash, 10)

      assert {:ok, updated_tx} = Tracker.update_tx(tx, false)

      assert updated_tx.id == tx.id
      assert updated_tx.tx_hash == tx.tx_hash
      assert updated_tx.status == :complete
    end
  end




  # Private Helpers
  # ---------------

  defp expect_response(bypass, hash, confirms) do
    code = 200
    path = "/getTxInfo/#{hash}"
    response = ~s({
      "hash": "#{hash}",
      "timestamp": 1535770371,
      "blockNumber": 6250128,
      "confirmations": #{confirms},
      "success": true,
      "from": "0x9a755332d874c893111207b0b220ce2615cd036f",
      "to": "0xb44e6593964ed9d1dfbe08bde9f3bc48fa84f66c",
      "value": 0.495,
      "input":"0x",
      "gasLimit":90000,
      "gasUsed":21000,
      "logs":[]
    })

    Support.Bypass.expect(bypass, :get, path, {code, response})
  end

end
