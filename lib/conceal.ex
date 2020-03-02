defmodule Conceal do
  @moduledoc """
  Provides an easy way to encrypt and decrypt a string using the AES-CBC-256 algorithm.

  It runs roughly this functions in order to return a encrypt base64-encoded string:
  `base64(iv + aes_cbc256(sha256(key), iv, data))`

  ## Usage

  ```elixir
  key = "my_secret_key"
  data = "my secret data"
  digest = Conceal.encrypt(data, key)

  case Conceal.decrypt(digest, key) do
    {:ok, decrypted_data} -> decrypted_data
    :error -> :error
  end
  ```
  """

  @doc """
  Encrypts the given `data` string with the given `key` using AES-CBC-256.
  """
  @spec encrypt(data :: String.t(), key :: String.t()) :: String.t()
  def encrypt(data, key) when is_binary(data) and is_binary(key) do
    iv = :crypto.strong_rand_bytes(16)
    cipher = :crypto.block_encrypt(:aes_cbc256, sha256(key), iv, pad(data))

    Base.encode64("#{iv}#{cipher}")
  end

  @doc """
  Decrypts the given `digest` string with the given `key` using AES-CBC-256.
  """
  @spec encrypt(digest :: String.t(), key :: String.t()) :: {:ok, String.t()} | :error
  def decrypt(digest, key) when is_binary(digest) and is_binary(key) do
    case Base.decode64(digest) do
      {:ok, text} ->
        if byte_size(digest) < 32 do
          :error
        else
          iv = Kernel.binary_part(text, 0, 16)
          cypher = Kernel.binary_part(text, 16, 16)

          :aes_cbc256
          |> :crypto.block_decrypt(sha256(key), iv, cypher)
          |> unpad()
        end

      :error ->
        :error
    end
  end

  defp sha256(key) do
    :crypto.hash(:sha256, key)
  end

  # pad data using PKCS#5
  defp pad(msg) do
    bytes_remaining = rem(byte_size(msg), 16)
    padding_size = 16 - bytes_remaining
    msg <> :binary.copy(<<padding_size>>, padding_size)
  end

  defp unpad(msg) do
    padding_size = :binary.last(msg)

    if padding_size <= 16 do
      msg_size = byte_size(msg)

      if binary_part(msg, msg_size, -padding_size) == :binary.copy(<<padding_size>>, padding_size) do
        {:ok, binary_part(msg, 0, msg_size - padding_size)}
      else
        :error
      end
    else
      :error
    end
  end
end
