defmodule FoedusWeb.SignerLive.FormComponent do
  use FoedusWeb, :live_component

  import FoedusWeb.Components.UI.{
    FormBuilder,
    FieldInput,
    FormActions,
    FormHeader
  }

  alias Foedus.Contracts
  alias Foedus.Contracts.Signer

  def mount(_params, _session, socket) do
    signers = Contracts.list_signers()
    changeset = Contracts.change_signer(%Signer{}, %{})

    socket =
      socket
      |> assign(:form, to_form(changeset))
      |> stream(:signers, signers)

    {:ok, socket}
  end

  @impl true
  def update(%{signer: signer} = assigns, socket) do
    signer = Map.put(signer, :status, signer.status || true)

    signer =
      Map.update(signer, :status, true, fn
        nil -> true
        val -> val
      end)

    changeset = Contracts.change_signer(signer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:signer, signer)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("validate", %{"signer" => signer_params}, socket) do
    signer_params = normalize_status_param(signer_params)

    changeset =
      socket.assigns.signer
      |> Contracts.change_signer(signer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  @impl true
  def handle_event("save", %{"signer" => signer_params}, socket) do
    company_id = socket.assigns.current_user.company_id
    signer_params = normalize_status_param(signer_params)
    save_signer(socket, socket.assigns.action, signer_params, company_id)
  end

  defp normalize_status_param(params) do
    case Map.get(params, "status") do
      nil -> Map.put(params, "status", false)
      "true" -> Map.put(params, "status", true)
      val when is_boolean(val) -> params
      _ -> Map.put(params, "status", false)
    end
  end

  defp save_signer(socket, :new, signer_params, company_id) do
    signer_params = Map.put(signer_params, "company_id", company_id)

    case Contracts.create_signer(signer_params) do
      {:ok, signer} ->
        notify_parent({:saved, signer})

        {:noreply,
         socket
         |> put_flash(:info, "Signer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp save_signer(socket, :edit, signer_params, _company_id) do
    case Contracts.update_signer(socket.assigns.signer, signer_params) do
      {:ok, signer} ->
        notify_parent({:saved, signer})

        {:noreply,
         socket
         |> put_flash(:info, "Signer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
