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
    Contracts.get_signer!(id) |> IO.inspect(label: "signer")

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

  defp format_document(document) when is_binary(document) do
    document
    |> String.replace(~r/[^\d]/, "")
    |> case do
      <<a::binary-size(3), b::binary-size(3), c::binary-size(3), d::binary-size(2)>> ->
        "#{a}.#{b}.#{c}-#{d}"

      <<a::binary-size(2), b::binary-size(3), c::binary-size(3), d::binary-size(4), e::binary-size(2)>> ->
        "#{a}.#{b}.#{c}/#{d}-#{e}"

      doc ->
        doc
    end
  end

  defp format_document(nil), do: "N/A"

  defp format_date(%Date{} = date), do: Calendar.strftime(date, "%d/%m/%Y")
  defp format_date(nil), do: "N/A"
  defp format_date(_), do: "N/A"
end
