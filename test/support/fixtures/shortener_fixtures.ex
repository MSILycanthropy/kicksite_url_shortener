defmodule KicksiteUrlShortener.ShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KicksiteUrlShortener.Shortener` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        expires_at: ~N[2022-04-13 04:37:00],
        hash: "some hash",
        url: "some url"
      })
      |> KicksiteUrlShortener.Shortener.create_link

    link
  end
end
