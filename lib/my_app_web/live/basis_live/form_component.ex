defmodule MyAppWeb.BasisLive.FormComponent do
  use MyAppWeb, :live_component

  alias MyApp.Core

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage basis records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="basis-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:type]} type="number" label="Type" />
        <.input field={@form[:text]} type="text" label="Text" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Basis</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{basis: basis} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Core.change_basis(basis))
     end)}
  end

  @impl true
  def handle_event("validate", %{"basis" => basis_params}, socket) do
    changeset = Core.change_basis(socket.assigns.basis, basis_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"basis" => basis_params}, socket) do
    save_basis(socket, socket.assigns.action, basis_params)
  end

  defp save_basis(socket, :edit, basis_params) do
    case Core.update_basis(socket.assigns.basis, basis_params) do
      {:ok, basis} ->
        notify_parent({:saved, basis})

        {:noreply,
         socket
         |> put_flash(:info, "Basis updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_basis(socket, :new, basis_params) do
    case Core.create_basis(basis_params) do
      {:ok, basis} ->
        notify_parent({:saved, basis})

        {:noreply,
         socket
         |> put_flash(:info, "Basis created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
