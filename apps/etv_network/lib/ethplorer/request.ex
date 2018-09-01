defmodule ETV.Network.Ethplorer.Request do
  @moduledoc """
  Helper module to build requests and parse their responses
  for the Ethplorer API
  """




  # Public API
  # ----------


  @doc """
  Build the URL from a request atom and params enum

  Automatically adds the `:api_key` specified in `config.exs`
  as one of the params. Raises error if the request atom does
  not correspond to a valid path.
  """
  def build_url(path, params \\ []) do
    host   = config(:host)
    params = put_in(params, [:apiKey], config(:api_key))

    Path.join(host, path) <> "?" <> URI.encode_query(params)
  end



  @doc """
  Handle a HTTPoison request response

  Returns the parsed JSON response if the status code is between
  200 & 300, otherwise an error tuple. Will also return error if
  an error message is returned from the Ethplorer API.
  """
  def handle_response({:ok, %{status_code: code, body: body}})
  when code >= 200 and code < 300 do
    case parse_body(body) do
      %{error: %{message: message}} ->
        {:error, {:ethplorer, message}}

      body ->
        {:ok, body}
    end
  end

  def handle_response({:ok, %{status_code: code}}) do
    {:error, {:status_code, code}}
  end

  def handle_response({:error, %{reason: reason}}) do
    {:error, {:request, reason}}
  end





  # Private Helpers
  # ---------------


  # Get Configs
  defp config,        do: Application.get_env(:etv_network, :ethplorer)
  defp config(key),   do: config()[key]


  # Parse a JSON response body
  defp parse_body(binary) do
    binary
    |> Jason.decode!
    |> symbolize
  end


  # Note: This is a potential DoS attack vector. Should
  # explicitly specify which fields should be atomized.
  defp symbolize({k, v}),                  do: {String.to_atom(k), symbolize(v)}
  defp symbolize(list) when is_list(list), do: Enum.map(list, &symbolize/1)
  defp symbolize(map)  when is_map(map),   do: Map.new(map, &symbolize/1)
  defp symbolize(term),                    do: term

end

