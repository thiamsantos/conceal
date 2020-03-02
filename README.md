# Conceal

[![Build Status](https://github.com/thiamsantos/health_check_plug/workflows/CI/badge.svg)](https://github.com/thiamsantos/health_check_plug/actions)

Provides an easy way to encrypt and decrypt a string using the AES-CBC-256 algorithm.

It runs roughly this functions in order to return a encrypt base64-encoded string:
`base64(iv + aes_cbc256(sha256(key), iv, data))`

## Installation

The package can be installed
by adding `conceal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:conceal, "~> 0.1.0"}
  ]
end
```

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

The docs can be found at [https://hexdocs.pm/conceal](https://hexdocs.pm/conceal).

## License

[Apache License, Version 2.0](LICENSE) © [Thiago Santos](https://github.com/thiamsantos)
