defmodule MyApp.CoreTest do
  use MyApp.DataCase

  alias MyApp.Core

  describe "bases" do
    alias MyApp.Core.Basis

    import MyApp.CoreFixtures

    @invalid_attrs %{type: nil, text: nil}

    test "list_bases/0 returns all bases" do
      basis = basis_fixture()
      assert Core.list_bases() == [basis]
    end

    test "get_basis!/1 returns the basis with given id" do
      basis = basis_fixture()
      assert Core.get_basis!(basis.id) == basis
    end

    test "create_basis/1 with valid data creates a basis" do
      valid_attrs = %{type: 42, text: "some text"}

      assert {:ok, %Basis{} = basis} = Core.create_basis(valid_attrs)
      assert basis.type == 42
      assert basis.text == "some text"
    end

    test "create_basis/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_basis(@invalid_attrs)
    end

    test "update_basis/2 with valid data updates the basis" do
      basis = basis_fixture()
      update_attrs = %{type: 43, text: "some updated text"}

      assert {:ok, %Basis{} = basis} = Core.update_basis(basis, update_attrs)
      assert basis.type == 43
      assert basis.text == "some updated text"
    end

    test "update_basis/2 with invalid data returns error changeset" do
      basis = basis_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_basis(basis, @invalid_attrs)
      assert basis == Core.get_basis!(basis.id)
    end

    test "delete_basis/1 deletes the basis" do
      basis = basis_fixture()
      assert {:ok, %Basis{}} = Core.delete_basis(basis)
      assert_raise Ecto.NoResultsError, fn -> Core.get_basis!(basis.id) end
    end

    test "change_basis/1 returns a basis changeset" do
      basis = basis_fixture()
      assert %Ecto.Changeset{} = Core.change_basis(basis)
    end
  end
end
