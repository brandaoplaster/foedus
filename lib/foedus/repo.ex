defmodule Foedus.Repo do
  use Ecto.Repo,
    otp_app: :foedus,
    adapter: Ecto.Adapters.Postgres
end
