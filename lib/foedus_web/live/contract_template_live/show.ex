defmodule FoedusWeb.ContractTemplateLive.Show do
  use FoedusWeb, :live_view

  alias Foedus.Contracts
    import FoedusWeb.Ui.Breadcrumb

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:contract_template, Contracts.get_contract_template!(id))}
  end

  defp page_title(:show), do: "Show Contract template"
  defp page_title(:edit), do: "Edit Contract template"
end
