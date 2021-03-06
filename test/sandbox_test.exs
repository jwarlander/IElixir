defmodule SandboxTest do
  use ExUnit.Case, async: false
  alias IElixir.Sandbox
  require Logger
  doctest IElixir.Sandbox

  setup do
    Sandbox.clean()
  end

  test "lambdas" do
    {:ok, _result, output, line_number} = Sandbox.execute_code(prepare_request("function = fn x -> 2*x end"))
    assert {"", 1} == {output, line_number}
    assert {:ok, "4", "", 2} == Sandbox.execute_code(prepare_request("function.(2)"))
  end

  test "IEx.Helpers methods in console" do
    {:ok, result, _output, line_number} = Sandbox.execute_code(prepare_request("h()"))
    assert {"", 1} == {result, line_number}
  end

  defp prepare_request(code) do
    %{
      "allow_stdin" => true,
      "code" => code,
      "silent" => false,
      "stop_on_error" => true,
      "store_history" => true,
      "user_expressions" => %{}
    }
  end
end
