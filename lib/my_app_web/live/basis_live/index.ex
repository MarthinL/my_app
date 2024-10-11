defmodule MyAppWeb.BasisLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Core
  alias MyApp.Core.Basis

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
    |> assign(:page_title, "Edit Basis")
    |> assign(:basis, Core.get_basis!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Basis")
    |> assign(:basis, %Basis{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bases")
    |> assign(:basis, nil)
  end

  @impl true
  def handle_info({MyAppWeb.BasisLive.FormComponent, {:saved, basis}}, socket) do
    {:noreply, stream_insert(socket, :bases, basis)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    basis = Core.get_basis!(id)
    {:ok, _} = Core.delete_basis(basis)

    {:noreply, stream_delete(socket, :bases, basis)}
  end
end
