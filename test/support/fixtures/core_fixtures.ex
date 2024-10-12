defmodule MyApp.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Core` context.
  """

  @doc """
  Generate a base.
  """
  def base_fixture(attrs \\ %{}) do
    {:ok, base} =
      attrs
      |> Enum.into(%{
        text: "some text",
        type: 42
      })
      |> MyApp.Core.create_base()

    base
  end
end
