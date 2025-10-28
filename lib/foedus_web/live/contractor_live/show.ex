defmodule FoedusWeb.ContractorLive.Show do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.{
    Breadcrumb,
    MetadataCard,
    Card,
    ShowHeader,
    ContractorInfo,
    RepresentativesList,
    AddressesList
  }

  alias Foedus.Contractors

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contractor, Contractors.get_contractor_with_associations!(id))}
  end

  defp page_title(:show), do: "Show Contractor"
  defp page_title(:edit), do: "Edit Contractor"
end
