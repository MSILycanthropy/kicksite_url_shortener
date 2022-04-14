defmodule KicksiteUrlShortenerWeb.RedirectController do
  use KicksiteUrlShortenerWeb, :controller

  alias KicksiteUrlShortener.Shortener

  def index(conn, %{"hash" => hash}) do
    try do
      link = Shortener.get_link_by_hash!(hash)
      redirect(conn, external: link.url)
    rescue
      Ecto.NoResultsError -> render(conn, "error.html")
    end
  end
end
