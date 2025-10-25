defmodule FoedusWeb.SignerLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.Table

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

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    signer = Contracts.get_signer!(id)
    {:ok, _} = Contracts.delete_signer(signer)
    socket = stream_delete(socket, :signer, signer)

    {:noreply, put_flash(socket, :info, "Signer deleted successfully")}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Signer")
    |> assign(:signer, %Signer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Signers")
    |> assign(:signer, nil)
  end

  def handle_info({:signer_created, signer}, socket) do
    socket = stream_insert(socket, :signer, signer, at: 0)
    {:noreply, socket}
  end

  def handle_info({:signer_updated, signer}, socket) do
    socket = stream_insert(socket, :signer, signer)
    {:noreply, socket}
  end

  def handle_info({:signer_deleted, signer}, socket) do
    socket = stream_delete(socket, :signer, signer)
    {:noreply, socket}
  end
end
