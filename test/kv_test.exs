defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "greets the world" do
    assert KV.hello() == :world
    IO.puts Jason.decode!(~s({"name": "Devin Torres", "age": 27}))["name"]
  end
end
