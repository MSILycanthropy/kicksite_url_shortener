defmodule KicksiteUrlShortenerWeb.LinkView do
  use KicksiteUrlShortenerWeb, :view
  alias KicksiteUrlShortenerWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{
      id: link.id,
      new_url: "#{System.get_env("WHO_AM_I")}/#{link.hash}",
      expires_at: link.expires_at
    }
  end
end
