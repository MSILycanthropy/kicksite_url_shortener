defmodule KicksiteUrlShortenerWeb.RedirectController do
  use KicksiteUrlShortenerWeb, :controller

  alias KicksiteUrlShortener.Shortener
  def index(conn, %{"hash" => hash}) do
    hash
    |> Shortener.get_link_by_hash
    |> case do
      {:error, error} -> render(conn, "error", error: error)
      link -> render_success(link, conn)
    end
  end

  defp render_success(link, conn) do
    link.expires_at
    |> case do
      nil -> :gt
      result -> NaiveDateTime.compare(result, NaiveDateTime.utc_now)
    end
    |> case do
      :gt -> redirect(conn, external: link.url)
      _ -> render(conn, "error.html", error: "Link has expired")
    end
  end
end
