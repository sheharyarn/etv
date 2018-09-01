defmodule Tests.Support.TX do
  @moduledoc """
  Transaction support helpers
  """


  @base    16
  @length  64
  @default "0"
  @prefix  "0x"

  def build_hash(integer) do
    hex =
      integer
      |> Integer.to_string(@base)
      |> String.pad_leading(@length, @default)

    @prefix <> hex
  end


end
