defmodule MyAppWeb.BasisLiveTest do
  use MyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import MyApp.CoreFixtures

  @create_attrs %{type: 42, text: "some text"}
  @update_attrs %{type: 43, text: "some updated text"}
  @invalid_attrs %{type: nil, text: nil}

  defp create_basis(_) do
    basis = basis_fixture()
    %{basis: basis}
  end

  describe "Index" do
    setup [:create_basis]

    test "lists all bases", %{conn: conn, basis: basis} do
      {:ok, _index_live, html} = live(conn, ~p"/bases")

      assert html =~ "Listing Bases"
      assert html =~ basis.text
    end

    test "saves new basis", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("a", "New Basis") |> render_click() =~
               "New Basis"

      assert_patch(index_live, ~p"/bases/new")

      assert index_live
             |> form("#basis-form", basis: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#basis-form", basis: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bases")

      html = render(index_live)
      assert html =~ "Basis created successfully"
      assert html =~ "some text"
    end

    test "updates basis in listing", %{conn: conn, basis: basis} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("#bases-#{basis.id} a", "Edit") |> render_click() =~
               "Edit Basis"

      assert_patch(index_live, ~p"/bases/#{basis}/edit")

      assert index_live
             |> form("#basis-form", basis: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#basis-form", basis: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bases")

      html = render(index_live)
      assert html =~ "Basis updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes basis in listing", %{conn: conn, basis: basis} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("#bases-#{basis.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bases-#{basis.id}")
    end
  end

  describe "Show" do
    setup [:create_basis]

    test "displays basis", %{conn: conn, basis: basis} do
      {:ok, _show_live, html} = live(conn, ~p"/bases/#{basis}")

      assert html =~ "Show Basis"
      assert html =~ basis.text
    end

    test "updates basis within modal", %{conn: conn, basis: basis} do
      {:ok, show_live, _html} = live(conn, ~p"/bases/#{basis}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Basis"

      assert_patch(show_live, ~p"/bases/#{basis}/show/edit")

      assert show_live
             |> form("#basis-form", basis: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#basis-form", basis: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bases/#{basis}")

      html = render(show_live)
      assert html =~ "Basis updated successfully"
      assert html =~ "some updated text"
    end
  end
end
