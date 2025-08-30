defmodule FoedusWeb.ContractTemplateLive.Index do
  use FoedusWeb, :live_view

  alias Foedus.Contracts
  alias FoedusWeb.ContractTemplateLive.FormComponent

  import FoedusWeb.Ui.Table

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       contract_templates: Contracts.list_contract_templates()
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contract templates")
    |> assign(:contract_template, nil)
  end

  @impl true
  def handle_info({FormComponent, {:saved, contract_template}}, socket) do
    {:noreply, stream_insert(socket, :contract_templates, contract_template)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    contract_template = Contracts.get_contract_template!(id)
    {:ok, _} = Contracts.delete_contract_template(contract_template)

    {:noreply, stream_delete(socket, :contract_templates, contract_template)}
  end
end
