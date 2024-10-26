defmodule Referenceapp.Repo do
  use Ecto.Repo,
    otp_app: :referenceapp,
    adapter: Ecto.Adapters.Postgres
end
