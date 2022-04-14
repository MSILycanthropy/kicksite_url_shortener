defmodule KicksiteUrlShortener.Repo do
  use Ecto.Repo,
    otp_app: :kicksite_url_shortener,
    adapter: Ecto.Adapters.Postgres
end
