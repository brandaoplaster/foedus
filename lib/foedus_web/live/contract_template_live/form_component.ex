defmodule FoedusWeb.ContractTemplateLive.FormComponent do
  use FoedusWeb, :live_component

  alias Foedus.Contracts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage contract_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="contract_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:content]} type="text" label="Content" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Contract template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{contract_template: contract_template} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Contracts.change_contract_template(contract_template))
     end)}
  end

  @impl true
  def handle_event("validate", %{"contract_template" => contract_template_params}, socket) do
    changeset = Contracts.change_contract_template(socket.assigns.contract_template, contract_template_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"contract_template" => contract_template_params}, socket) do
    save_contract_template(socket, socket.assigns.action, contract_template_params)
  end

  defp save_contract_template(socket, :edit, contract_template_params) do
    case Contracts.update_contract_template(socket.assigns.contract_template, contract_template_params) do
      {:ok, contract_template} ->
        notify_parent({:saved, contract_template})

        {:noreply,
         socket
         |> put_flash(:info, "Contract template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_contract_template(socket, :new, contract_template_params) do
    case Contracts.create_contract_template(contract_template_params) do
      {:ok, contract_template} ->
        notify_parent({:saved, contract_template})

        {:noreply,
         socket
         |> put_flash(:info, "Contract template created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
