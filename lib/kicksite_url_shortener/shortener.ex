defmodule KicksiteUrlShortener.Shortener do
  @moduledoc """
  The Shortener context.
  """
  import Ecto.Query, warn: false
  alias KicksiteUrlShortener.Repo

  alias KicksiteUrlShortener.Shortener.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Gets a single link by hash

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link_by_hash("123")
      %Link{}

      iex> get_link_by_hash("456")
      ** (Ecto.NoResultsError)
  """
  def get_link_by_hash!(hash), do: Repo.get_by!(Link, hash: hash)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(url, expires_at)
      {:ok, %Link{}}

      iex> create_link(bad_url, expires_at)
      {:error, %Ecto.Changeset{}}

  """
  def create_link(url, expires_in \\ "") do
    hash = Link.generate_hash(url)
    expires_at = Link.generate_expiration(expires_in)

    %Link{}
    |> Link.changeset(%{ url: url, hash: hash, expires_at: expires_at })
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end
end
