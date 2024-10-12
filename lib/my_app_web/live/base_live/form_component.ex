defmodule MyAppWeb.BaseLive.FormComponent do
  use MyAppWeb, :live_component

  alias MyApp.Core

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage base records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="base-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:type]} type="number" label="Type" />
        <.input field={@form[:text]} type="text" label="Text" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Base</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{base: base} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Core.change_base(base))
     end)}
  end

  @impl true
  def handle_event("validate", %{"base" => base_params}, socket) do
    changeset = Core.change_base(socket.assigns.base, base_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"base" => base_params}, socket) do
    save_base(socket, socket.assigns.action, base_params)
  end

  defp save_base(socket, :edit, base_params) do
    case Core.update_base(socket.assigns.base, base_params) do
      {:ok, base} ->
        notify_parent({:saved, base})

        {:noreply,
         socket
         |> put_flash(:info, "Base updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_base(socket, :new, base_params) do
    case Core.create_base(base_params) do
      {:ok, base} ->
        notify_parent({:saved, base})

        {:noreply,
         socket
         |> put_flash(:info, "Base created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
