defmodule FoedusWeb.SignerLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.Table

  alias Foedus.Contracts
  alias Foedus.Contracts.Signer
  alias FoedusWeb.SignerLive.FormComponent

  @impl true
  def mount(_params, _session, socket) do
    signers = Contracts.list_signers()

    {:ok, stream(socket, :signers, signers)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    signer = Contracts.get_signer!(id)
    {:ok, _} = Contracts.delete_signer(signer)
    socket = stream_delete(socket, :signers, signer)

    {:noreply, put_flash(socket, :info, "Signer deleted successfully")}
  end

  @impl true
  def handle_info({FormComponent, {:saved, signer}}, socket) do
    socket = stream_insert(socket, :signers, signer, at: 0)
    {:noreply, socket}
  end

  @impl true
  def handle_info({FormComponent, {:updated, signer}}, socket) do
    socket = stream_insert(socket, :signers, signer)
    {:noreply, socket}
  end

  @impl true
  def handle_info({FormComponent, {:deleted, signer}}, socket) do
    socket = stream_delete(socket, :signers, signer)
    {:noreply, socket}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Signer")
    |> assign(:signer, %Signer{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Signer")
    |> assign(:signer, Contracts.get_signer!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Signers")
    |> assign(:signer, nil)
  end
end
