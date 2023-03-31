defmodule Meriazard.Repo do
  use Ecto.Repo,
    otp_app: :meriazard,
    adapter: Ecto.Adapters.SQLite3
end
