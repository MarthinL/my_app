defmodule MyApp.CoreTest do
  use MyApp.DataCase

  alias MyApp.Core

  describe "bases" do
    alias MyApp.Core.Base

    import MyApp.CoreFixtures

    @invalid_attrs %{type: nil, text: nil}

    test "list_bases/0 returns all bases" do
      base = base_fixture()
      assert Core.list_bases() == [base]
    end

    test "get_base!/1 returns the base with given id" do
      base = base_fixture()
      assert Core.get_base!(base.id) == base
    end

    test "create_base/1 with valid data creates a base" do
      valid_attrs = %{type: 42, text: "some text"}

      assert {:ok, %Base{} = base} = Core.create_base(valid_attrs)
      assert base.type == 42
      assert base.text == "some text"
    end

    test "create_base/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_base(@invalid_attrs)
    end

    test "update_base/2 with valid data updates the base" do
      base = base_fixture()
      update_attrs = %{type: 43, text: "some updated text"}

      assert {:ok, %Base{} = base} = Core.update_base(base, update_attrs)
      assert base.type == 43
      assert base.text == "some updated text"
    end

    test "update_base/2 with invalid data returns error changeset" do
      base = base_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_base(base, @invalid_attrs)
      assert base == Core.get_base!(base.id)
    end

    test "delete_base/1 deletes the base" do
      base = base_fixture()
      assert {:ok, %Base{}} = Core.delete_base(base)
      assert_raise Ecto.NoResultsError, fn -> Core.get_base!(base.id) end
    end

    test "change_base/1 returns a base changeset" do
      base = base_fixture()
      assert %Ecto.Changeset{} = Core.change_base(base)
    end
  end
end
