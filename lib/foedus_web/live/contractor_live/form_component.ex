defmodule FoedusWeb.ContractorsLive.FormComponent do
  use FoedusWeb, :live_component
  alias Foedus.Contractors
  import FoedusWeb.Components.UI.WizardForms

  @impl true
  def render(assigns) do
    ~H"""
    <div >
      <.wizard_forms
        current_step={@current_step}
        total_steps={5}
        completed_steps={@completed_steps}
        form={@form}
        form_data={@form_data}
        target={@myself}
      />
    </div>
    """
  end

  @impl true
  def update(%{contractor: contractor} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Contractors.change_contractor(contractor))
     end)
     |> assign_new(:current_step, fn -> 1 end)
     |> assign_new(:completed_steps, fn -> [] end)
     |> assign_new(:form_data, fn -> %{} end)}
  end

  @impl true
  def handle_event("validate_step", %{"contractor" => contractor_params}, socket) do
    changeset = Contractors.change_contractor(socket.assigns.contractor, contractor_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("next_step", _params, socket) do
    current = socket.assigns.current_step
    completed = socket.assigns.completed_steps
    new_completed = if current not in completed, do: [current | completed], else: completed

    {:noreply,
     socket
     |> assign(current_step: min(current + 1, 5))
     |> assign(completed_steps: new_completed)}
  end

  def handle_event("previous_step", _params, socket) do
    current = socket.assigns.current_step
    {:noreply, assign(socket, current_step: max(current - 1, 1))}
  end

  def handle_event("save_step", %{"contractor" => contractor_params}, socket) do
    # Se está na última etapa, salva definitivamente
    if socket.assigns.current_step == 5 do
      save_contractor(socket, socket.assigns.action, contractor_params)
    else
      # Apenas valida e vai para próxima etapa
      changeset = Contractors.change_contractor(socket.assigns.contractor, contractor_params)

      if changeset.valid? do
        current = socket.assigns.current_step
        completed = socket.assigns.completed_steps
        new_completed = if current not in completed, do: [current | completed], else: completed

        {:noreply,
         socket
         |> assign(current_step: min(current + 1, 5))
         |> assign(completed_steps: new_completed)
         |> assign(form: to_form(changeset))}
      else
        {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
      end
    end
  end

  defp save_contractor(socket, :edit, contractor_params) do
    case Contractors.update_contractor(socket.assigns.contractor, contractor_params) do
      {:ok, contractor} ->
        notify_parent({:saved, contractor})

        {:noreply,
         socket
         |> put_flash(:info, "Contractor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_contractor(socket, :new, contractor_params) do
    case Contractors.create_contractor(contractor_params) do
      {:ok, contractor} ->
        notify_parent({:saved, contractor})

        {:noreply,
         socket
         |> put_flash(:info, "Contractor created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
