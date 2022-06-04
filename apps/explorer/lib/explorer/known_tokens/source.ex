defmodule Explorer.KnownTokens.Source do
  @moduledoc """
  Behaviour for fetching list of known tokens.
  """

  alias Explorer.Chain.Hash
  alias Explorer.ExchangeRates.Source
  alias Explorer.KnownTokens.Source.Database

  @doc """
  Fetches known tokens
  """
  # @spec fetch_known_tokens() :: {:ok, [Hash.Address.t()]} | {:error, any}
  # def fetch_known_tokens(source \\ known_tokens_source()) do
  #   Source.http_request(source.source_url())
  # end

  @spec fetch_known_tokens() :: {:ok, [Hash.Address.t()]} | {:error, any}
  def fetch_known_tokens(source \\ known_tokens_source()) do
    Database.fetch_known_tokens()
  end

  @doc """
  Url for querying the list of known tokens.
  """
  @callback source_url() :: String.t()

  @spec known_tokens_source() :: module()
  defp known_tokens_source do
    config(:source) || Explorer.KnownTokens.Source.Database
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:explorer, __MODULE__, [])[key]
  end
end
