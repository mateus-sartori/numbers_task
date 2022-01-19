defmodule CrossCommerceDesafioWeb.NumberController do
  use CrossCommerceDesafioWeb, :controller

  alias CrossCommerceDesafio.Extraction
  alias CrossCommerceDesafio.Sort

  def sorted_numbers(conn, _params) do
    json(conn, %{sorted_numbers: extract_and_sort()})
  end

  defp extract_and_sort(), do: Sort.merge_sort(Extraction.extraction())
end
