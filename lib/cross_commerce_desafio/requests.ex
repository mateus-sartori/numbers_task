defmodule CrossCommerceDesafio.Requests do
  use Tesla, only: [:get], docs: false

  require Logger

  plug Tesla.Middleware.BaseUrl, "http://challenge.dienekes.com.br/api"
  plug Tesla.Middleware.JSON
  plug CrossCommerceDesafio.Requests.Case

  @spec start_request(integer) :: {:error, any} | {:ok, Tesla.Env.t()}
  def start_request(page), do: request_numbers(page)

  defp request_numbers(page) do
    Logger.warn("Pesquisando, página: #{page}")
    {:ok, response} = get("/numbers", query: [page: page])

    case {response.status, response.body} do
      {200, body} ->
        body

      {404, _} ->
        Logger.info("Not Found route")
        {:error, "Route not found"}

      {500, _} ->
        Logger.info("Bad request")
        {:error, "Bad Request"}
    end
  end
end
