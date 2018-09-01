defmodule Tests.ETV.Network.Ethplorer do
  use ExUnit.Case, async: true

  alias ETV.Network.Ethplorer
  alias Tests.Support.Bypass


  # Can't test against the actual API, because that will slow
  # down the entire suite, and also cause us to be rate-limited.
  #
  # Using Bypass to test the behaviour.


  setup do
    {:ok, [bypass: Bypass.setup]}
  end


  describe "#tx_info" do
    @code 200
    @hash "0x7338b8fc6f781f3cdf4d80a95c9f633b9555d34d59754b4e82699a92ab31c282"
    @path "/getTxInfo/#{@hash}"
    @response ~s({
      "hash": "#{@hash}",
      "timestamp": 1535770371,
      "blockNumber": 6250128,
      "confirmations": 257,
      "success": true,
      "from": "0x9a755332d874c893111207b0b220ce2615cd036f",
      "to": "0xb44e6593964ed9d1dfbe08bde9f3bc48fa84f66c",
      "value": 0.495,
      "input":"0x",
      "gasLimit":90000,
      "gasUsed":21000,
      "logs":[]
    })


    test "returns transaction information", %{bypass: bypass} do
      Bypass.expect(bypass, :get, @path, {@code, @response})

      assert {:ok, response} = Ethplorer.tx_info(@hash)
      assert response.hash == @hash
      assert response.blockNumber == 6250128
      assert response.confirmations == 257
    end
  end


end
