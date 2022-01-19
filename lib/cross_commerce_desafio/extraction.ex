defmodule CrossCommerceDesafio.Extraction do
  use GenServer

  alias CrossCommerceDesafio.Requests

  def extraction() do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])

    case request_by_fraction(pid) do
      {:error, reason} ->
        {:error, reason}

      :ok ->
        result = GenServer.call(pid, :get_list)
        GenServer.stop(pid)
        result
    end
  end

  @pieces 400
  defp request_by_fraction(pid, current_page \\ 1) do
    current_page..(@pieces + current_page)
    |> Enum.map(fn request_page ->
      Task.async(fn -> do_extract(request_page, pid) end)
    end)
    |> Enum.map(fn task_pid -> Task.await(task_pid) end)
    |> verify_fractioned_request(pid, current_page + @pieces)
  end

  defp do_extract(page, pid), do: check_extraction(Requests.start_request(page), page, pid)

  defp verify_fractioned_request(returned_list, pid, current_page),
    do: if([] in returned_list, do: :ok, else: request_by_fraction(pid, current_page))

  defp check_extraction({:error, "Bad Request" = _reason}, page, pid),
    do: retry_extract(page, pid)

  defp check_extraction({:error, reason}, _page, _pid), do: {:error, reason}
  defp check_extraction(%{"numbers" => []}, _page, _pid), do: []

  defp check_extraction(%{"numbers" => number_list}, _page, pid),
    do: GenServer.cast(pid, {:push, number_list})

  defp retry_extract(page, pid), do: do_extract(page, pid)

  @impl true
  def init(number_list \\ []) do
    {:ok, number_list}
  end

  @impl true
  def handle_cast({:push, number_list}, state) do
    {:noreply, number_list ++ state}
  end

  @impl true
  def handle_call(:get_list, _from, state) do
    {:reply, state, state}
  end
end
