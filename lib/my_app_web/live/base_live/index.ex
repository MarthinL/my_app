defmodule MyAppWeb.BaseLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Core
  alias MyApp.Core.Base

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bases, Core.list_bases())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Base")
    |> assign(:base, Core.get_base!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Base")
    |> assign(:base, %Base{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bases")
    |> assign(:base, nil)
  end

  @impl true
  def handle_info({MyAppWeb.BaseLive.FormComponent, {:saved, base}}, socket) do
    {:noreply, stream_insert(socket, :bases, base)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    base = Core.get_base!(id)
    {:ok, _} = Core.delete_base(base)

    {:noreply, stream_delete(socket, :bases, base)}
  end
end
