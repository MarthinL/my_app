defmodule MyApp.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Core.Basis

  @doc """
  Returns the list of bases.

  ## Examples

      iex> list_bases()
      [%Basis{}, ...]

  """
  def list_bases do
    Repo.all(Basis)
  end

  @doc """
  Gets a single basis.

  Raises `Ecto.NoResultsError` if the Basis does not exist.

  ## Examples

      iex> get_basis!(123)
      %Basis{}

      iex> get_basis!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basis!(id), do: Repo.get!(Basis, id)

  @doc """
  Creates a basis.

  ## Examples

      iex> create_basis(%{field: value})
      {:ok, %Basis{}}

      iex> create_basis(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basis(attrs \\ %{}) do
    %Basis{}
    |> Basis.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a basis.

  ## Examples

      iex> update_basis(basis, %{field: new_value})
      {:ok, %Basis{}}

      iex> update_basis(basis, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basis(%Basis{} = basis, attrs) do
    basis
    |> Basis.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basis.

  ## Examples

      iex> delete_basis(basis)
      {:ok, %Basis{}}

      iex> delete_basis(basis)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basis(%Basis{} = basis) do
    Repo.delete(basis)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basis changes.

  ## Examples

      iex> change_basis(basis)
      %Ecto.Changeset{data: %Basis{}}

  """
  def change_basis(%Basis{} = basis, attrs \\ %{}) do
    Basis.changeset(basis, attrs)
  end
end
