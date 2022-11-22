defmodule DisconnectAll.Test do
  alias DisconnectAll.Repo
  require Logger

  @pool_size 2
  @query_time 500

  def go(interval) do
    checkout_all(1)

    Logger.info("Calling disconnect_all...")
    Repo.disconnect_all(interval)

    for i <- 2..10 do
      checkout_all(i)
      Process.sleep(2 * @query_time)
    end

    :ok
  end

  defp checkout_all(iteration) do
    Logger.info("Checking out all connections (iteration #{iteration})...")

    for _ <- 1..@pool_size do
      Task.async(fn ->
        Repo.checkout(fn ->
          [[pid]] = Repo.query!("SELECT pg_backend_pid()").rows
          Logger.info("#{iteration}) #{inspect(self())} checking out: #{inspect(pid)}")
          Process.sleep(@query_time)
          Logger.info("#{iteration}) #{inspect(self())} checking back in: #{inspect(pid)}")
        end)
      end)
    end
  end
end
