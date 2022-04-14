defmodule KicksiteUrlShortener.ShortenerTest do
  use KicksiteUrlShortener.DataCase

  alias KicksiteUrlShortener.Shortener

  describe "links" do
    alias KicksiteUrlShortener.Shortener.Link

    import KicksiteUrlShortener.ShortenerFixtures

    @invalid_attrs %{expires_at: nil, hash: nil, url: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Shortener.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Shortener.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{expires_at: ~N[2022-04-13 04:37:00], hash: "some hash", url: "some url"}

      assert {:ok, %Link{} = link} = Shortener.create_link(valid_attrs)
      assert link.expires_at == ~N[2022-04-13 04:37:00]
      assert link.hash == "some hash"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{expires_at: ~N[2022-04-14 04:37:00], hash: "some updated hash", url: "some updated url"}

      assert {:ok, %Link{} = link} = Shortener.update_link(link, update_attrs)
      assert link.expires_at == ~N[2022-04-14 04:37:00]
      assert link.hash == "some updated hash"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_link(link, @invalid_attrs)
      assert link == Shortener.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Shortener.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Shortener.change_link(link)
    end
  end
end
