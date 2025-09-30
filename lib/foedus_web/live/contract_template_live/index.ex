defmodule FoedusWeb.ContractTemplateLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.Table

  alias Foedus.Contracts
  alias Foedus.Contracts.ContractTemplate

  def mount(_params, _session, socket) do
    contract_templates = Contracts.list_contract_templates()

    socket = stream(socket, :contract_templates, contract_templates)

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contract template")
    |> assign(:contract_template, %ContractTemplate{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contract template")
    |> assign(:contract_template, Contracts.get_contract_template!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contract templates")
    |> assign(:contract_template, nil)
  end

  def handle_event("delete", %{"id" => id}, socket) do
    contract_template = Contracts.get_contract_template!(id)
    {:ok, _} = Contracts.delete_contract_template(contract_template)
    socket = stream_delete(socket, :contract_templates, contract_template)

    {:noreply, put_flash(socket, :info, "Contract template deleted successfully")}
  end

  def handle_info({:contract_template_created, contract_template}, socket) do
    socket = stream_insert(socket, :contract_templates, contract_template, at: 0)
    {:noreply, socket}
  end

  def handle_info({:contract_template_updated, contract_template}, socket) do
    socket = stream_insert(socket, :contract_templates, contract_template)
    {:noreply, socket}
  end

  def handle_info({:contract_template_deleted, contract_template}, socket) do
    socket = stream_delete(socket, :contract_templates, contract_template)
    {:noreply, socket}
  end
end
