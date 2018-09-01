defmodule Tests.Support.Bypass do
  @moduledoc """
  Bypass Support Helpers to mock Web API requests
  """


  def setup do
    port = Application.get_env(:bypass, :port)
    Bypass.open(port: port)
  end


  def expect(bypass, :get, path, fun) when is_function(fun) do
    Bypass.expect_once(bypass, "GET", path, fun)
  end


  def expect(bypass, method, request, {code, response}) do
    expect(bypass, method, request, fn conn ->
      Plug.Conn.resp(conn, code, response)
    end)
  end

end

