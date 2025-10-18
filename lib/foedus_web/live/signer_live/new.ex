defmodule FoedusWeb.SignerLive.New do
  use FoedusWeb, :live_component

  import FoedusWeb.Components.UI.{
    FormBuilder,
    FieldInput
  }

  alias Foedus.Contracts

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{signer: signer} = assigns, socket) do
    signer = Map.put(signer, :status, signer.status || true)

    changeset = Contracts.change_signer(signer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:signer, signer)
     |> assign(:form, to_form(changeset))}
  end

  @impl true
  def handle_event("validate", %{"signer" => signer_params}, socket) do
    changeset =
      socket.assigns.signer
      |> Contracts.change_signer(signer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
