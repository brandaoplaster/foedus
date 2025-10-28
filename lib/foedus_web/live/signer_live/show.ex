defmodule FoedusWeb.SignerLive.Show do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.{
    Breadcrumb,
    MetadataCard,
    Card,
    ShowHeader,
    SignerDetails,
    Icon
  }

  alias Foedus.Contracts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:signer, Contracts.get_signer!(id))}
  end

  defp page_title(:show), do: "Show Signer"
  defp page_title(:edit), do: "Edit Signer"

  defp full_name(signer) do
    first = signer.name || ""
    last = signer.lastname || ""
    name = String.trim("#{first} #{last}")
    if name == "", do: "Signer ##{signer.id}", else: name
  end
end
