defmodule PandaTest do
  use ExUnit.Case
  doctest Panda

  test "greets the world" do
    assert Panda.hello() == :world
  end
end
