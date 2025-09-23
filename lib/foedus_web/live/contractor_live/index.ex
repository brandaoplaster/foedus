defmodule FoedusWeb.ContractorLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.Table

  alias Foedus.Contractors
  alias Foedus.Contractors.Contractor

  def mount(_params, _session, socket) do
    contractors = Contractors.list_contractors()

    changeset = Contractor.changeset(%Contractor{}, %{})

    socket =
      socket
      |> assign(:form, to_form(changeset))
      |> stream(:contractors, contractors)

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    contractor = Contractors.get_contractor!(id)
    {:ok, _} = Contractors.delete_contractor(contractor)

    socket = stream_delete(socket, :contractors, contractor)

    {:noreply, put_flash(socket, :info, "Contractor deleted successfully")}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contractor")
    |> assign(:contractor, %Contractor{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Contractor")
    |> assign(:contractor, Contractors.get_contractor!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Contractor")
    |> assign(:contractor, nil)
  end

  def handle_info({:contract_template_created, contractor}, socket) do
    socket = stream_insert(socket, :contractor, contractor, at: 0)
    {:noreply, socket}
  end

  def handle_info({:contract_template_updated, contractor}, socket) do
    socket = stream_insert(socket, :contractor, contractor)
    {:noreply, socket}
  end

  def handle_info({:contract_template_deleted, contractor}, socket) do
    socket = stream_delete(socket, :contractor, contractor)
    {:noreply, socket}
  end
end
