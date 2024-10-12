
defmodule MyAppWeb.BaseLiveTest do
  use MyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import MyApp.CoreFixtures

  @create_attrs %{type: 42, text: "some text"}
  @update_attrs %{type: 43, text: "some updated text"}
  @invalid_attrs %{type: nil, text: nil}

  defp create_base(_) do
    base = base_fixture()
    %{base: base}
  end

  describe "Index" do
    setup [:create_base]

    test "lists all bases", %{conn: conn, base: base} do
      {:ok, _index_live, html} = live(conn, ~p"/bases")

      assert html =~ "Listing Bases"
      assert html =~ base.text
    end

    test "saves new base", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("a", "New Base") |> render_click() =~
               "New Base"

      assert_patch(index_live, ~p"/bases/new")

      assert index_live
             |> form("#base-form", base: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#base-form", base: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bases")

      html = render(index_live)
      assert html =~ "Base created successfully"
      assert html =~ "some text"
    end

    test "updates base in listing", %{conn: conn, base: base} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("#bases-#{base.id} a", "Edit") |> render_click() =~
               "Edit Base"

      assert_patch(index_live, ~p"/bases/#{base}/edit")

      assert index_live
             |> form("#base-form", base: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#base-form", base: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bases")

      html = render(index_live)
      assert html =~ "Base updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes base in listing", %{conn: conn, base: base} do
      {:ok, index_live, _html} = live(conn, ~p"/bases")

      assert index_live |> element("#bases-#{base.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bases-#{base.id}")
    end
  end

  describe "Show" do
    setup [:create_base]

    test "displays base", %{conn: conn, base: base} do
      {:ok, _show_live, html} = live(conn, ~p"/bases/#{base}")

      assert html =~ "Show Base"
      assert html =~ base.text
    end

    test "updates base within modal", %{conn: conn, base: base} do
      {:ok, show_live, _html} = live(conn, ~p"/bases/#{base}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Base"

      assert_patch(show_live, ~p"/bases/#{base}/show/edit")

      assert show_live
             |> form("#base-form", base: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#base-form", base: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bases/#{base}")

      html = render(show_live)
      assert html =~ "Base updated successfully"
      assert html =~ "some updated text"
    end
  end
end
