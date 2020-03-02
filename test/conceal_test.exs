defmodule ConcealTest do
  use ExUnit.Case

  test "encrypts and decrypts" do
    input = "data"

    {:ok, result} =
      input
      |> Conceal.encrypt("key")
      |> Conceal.decrypt("key")

    assert result == input
  end

  describe "decrypt/2" do
    test "different key" do
      input = "data"

      digest = Conceal.encrypt(input, "key")

      assert Conceal.decrypt(digest, "different_key") == :error
    end

    test "not a encrypted digest" do
      input = Base.encode64("data")

      assert Conceal.decrypt(input, "key") == :error
    end

    test "not base 64" do
      input = "data"

      assert Conceal.decrypt(input, "key") == :error
    end
  end
end
