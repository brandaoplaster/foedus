defmodule FoedusWeb.ContractorLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.Table

  alias Foedus.Contractors

  def mount(_params, _session, socket) do
    contractors = Contractors.list_contractors()

    socket =
      socket
      |> stream(:contractors, contractors)

    {:ok, socket}
  end

  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end
end
