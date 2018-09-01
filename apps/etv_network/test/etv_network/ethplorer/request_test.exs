defmodule Tests.ETV.Network.Ethplorer.Request do
  use ExUnit.Case, async: true
  alias ETV.Network.Ethplorer.Request



  describe "#build_url" do
    @path "/abc/def/ghi"
    test "builds the absolute URL and appends the API key" do
      assert url = Request.build_url(@path)
      assert uri = %URI{} = URI.parse(url)

      assert uri.host
      assert uri.port
      assert uri.path   == @path
      assert uri.query  =~ ~r/apiKey=[\w\-]{5,30}/
      assert uri.scheme =~ ~r/http/
    end


    test "builds the URL and appends the params" do
      params = %{num: 123, phrase: "a b c"}

      assert url = Request.build_url(@path, params)
      assert uri = %URI{} = URI.parse(url)
      assert query = URI.decode_query(uri.query)

      assert query["apiKey"] =~ ~r/[\w\-]{5,30}/
      assert query["phrase"] == to_string(params.phrase)
      assert query["num"]    == to_string(params.num)
    end
  end



  describe "#handle_response" do
    @reason "some_reason"
    test "returns error tuple on request errors" do
      response = {:error, %{reason: @reason}}
      assert {:error, {:request, @reason}} = Request.handle_response(response)
    end


    @code 401
    @body "some response"
    test "returns error tuple if response status code is not between 200-300" do
      response = {:ok, %{status_code: @code, body: @body}}
      assert {:error, {:status_code, @code}} = Request.handle_response(response)
    end


    @code 203
    @body ~s({"status": "success", "message": "something happened"})
    test "returns ok with parsed json response if status code is between 200-300" do
      response = {:ok, %{status_code: @code, body: @body}}
      assert {:ok, result} = Request.handle_response(response)

      assert result.status == "success"
      assert result.message == "something happened"
    end


    @code 200
    @body ~s({"error": {"code": "102", "message": "something happened"}})
    test "returns error if ethplorer gives an error message despite correct http code" do
      response = {:ok, %{status_code: @code, body: @body}}
      expected = {:error, {:ethplorer, "something happened"}}

      assert expected == Request.handle_response(response)
    end
  end


end
