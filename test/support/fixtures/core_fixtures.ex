defmodule MyApp.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Core` context.
  """

  @doc """
  Generate a basis.
  """
  def basis_fixture(attrs \\ %{}) do
    {:ok, basis} =
      attrs
      |> Enum.into(%{
        text: "some text",
        type: 42
      })
      |> MyApp.Core.create_basis()

    basis
  end
end
