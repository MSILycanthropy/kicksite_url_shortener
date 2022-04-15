defmodule KicksiteUrlShortener.Shortener.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :expires_at, :naive_datetime
    field :hash, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:hash, :url, :expires_at])
    |> validate_required([:hash, :url])
    |> validate_url(:url)
  end

  @doc false
  def generate_hash(url) do
    salt = DateTime.utc_now |> DateTime.to_unix(:millisecond)

    :crypto.hash(:md5, "#{url}#{salt}}")
    |> Base.url_encode64
    |> String.slice(0,12)
    |> String.downcase
  end

  @spec generate_expiration(nil | binary) :: nil | NaiveDateTime.t()
  @doc false
  def generate_expiration(expires_in) do
    handle_result = fn
      {result, _} -> NaiveDateTime.utc_now |> NaiveDateTime.add(result * 60, :second)
      :error -> nil
    end

    case expires_in do
      nil -> nil
      _ -> expires_in
          |> Integer.parse
          |> handle_result.()
    end
  end

  @doc false
  def validate_url(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, url ->
      uri = URI.parse(url)
      valid? = uri.scheme != nil && uri.host =~ "."
      case valid? do
        true -> []
        false -> [{field, options[:message] || "URL is invalid"}]
      end
    end)
  end
end
