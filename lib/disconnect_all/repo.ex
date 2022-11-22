defmodule DisconnectAll.Repo do
  use Ecto.Repo,
    otp_app: :disconnect_all,
    adapter: Ecto.Adapters.Postgres
end
