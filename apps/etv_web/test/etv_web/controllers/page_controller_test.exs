defmodule Tests.ETV.Web.PageController do
  use Tests.Support.ConnCase

  alias ETV.Data.Transaction
  alias Tests.Support



  describe "GET /" do
    setup do
      txs = [
        %Transaction{tx_hash: Support.TX.build_hash(1), status: :pending},
        %Transaction{tx_hash: Support.TX.build_hash(2), status: :pending},
        %Transaction{tx_hash: Support.TX.build_hash(3), status: :complete},
      ]

      %{txs: Enum.map(txs, &Transaction.insert!/1)}
    end


    test "it displays currently stored transactions", %{conn: conn, txs: txs} do
      response =
        conn
        |> get(page_path(conn, :index))
        |> html_response(200)

      assert response =~ "All Stored Transactions"
      Enum.each(txs, fn tx ->
        assert response =~ tx.tx_hash
      end)
    end
  end




  describe "POST /tx" do
    @invalid_hash "asdasdasd"
    test "renders errors for invalid hashes", %{conn: conn} do
      conn = post(conn, page_path(conn, :create), hash: @invalid_hash)

      assert new_path = redirected_to(conn, 302)
      assert new_path == page_path(conn, :index)

      response =
        conn
        |> recycle
        |> get(new_path)
        |> html_response(200)

      assert response =~ "hash has invalid format"
    end


    @valid_hash Support.TX.build_hash(1000)
    test "it creates a new transaction record with pending status", %{conn: conn} do
      conn = post(conn, page_path(conn, :create), hash: @valid_hash)

      assert new_path = redirected_to(conn, 302)
      assert new_path == page_path(conn, :index)

      response =
        conn
        |> recycle
        |> get(new_path)
        |> html_response(200)

      assert response =~ ~r/transaction status is.*pending/i
      assert response =~ @valid_hash

      assert [tx] = Transaction.all
      assert tx.tx_hash == @valid_hash
      assert tx.status == :pending
    end
  end

end
