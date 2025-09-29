defmodule FoedusWeb.Components.UI.RepresentativesList do
  use Phoenix.Component

  import FoedusWeb.Components.UI.{Card, Icon}

  attr :representatives, :list, required: true
  attr :title, :string, default: "Representatives"
  attr :class, :string, default: ""

  def representatives_list(assigns) do
    ~H"""
    <%= if @representatives != [] do %>
      <.card title={@title} icon="zap" icon_color="red" class={["w-full", @class]}>
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
          <div class="p-6">
            <div class="space-y-4">
              <.representative_card
                :for={rep <- @representatives}
                representative={rep}
              />
            </div>
          </div>
        </div>
      </.card>
    <% end %>
    """
  end

  attr :representative, :map, required: true

  defp representative_card(assigns) do
    ~H"""
    <div class="border border-gray-200 rounded-lg p-4 hover:border-gray-300 transition-colors">
      <div class="space-y-3">
        <div class="flex items-start justify-between">
          <div>
            <h3 class="text-gray-900 font-semibold text-lg">
              <%= full_name(@representative) %>
            </h3>
            <%= if @representative.role do %>
              <span class={[
                "inline-block mt-1 px-2 py-1 text-xs font-medium rounded-full",
                role_badge_class(@representative.role)
              ]}>
                <%= role_label(@representative.role) %>
              </span>
            <% end %>
          </div>
        </div>

        <div class="space-y-2">
          <%= if @representative.email do %>
            <.info_row icon="hero-envelope" value={@representative.email} />
          <% end %>

          <%= if @representative.phone do %>
            <.info_row icon="hero-phone" value={@representative.phone} />
          <% end %>

          <%= if @representative.document do %>
            <.info_row icon="hero-identification" value={format_document(@representative.document)} />
          <% end %>

          <%= if @representative.birth_date do %>
            <.info_row icon="hero-cake" value={format_date(@representative.birth_date)} />
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  attr :icon, :string, required: true
  attr :value, :string, required: true

  defp info_row(assigns) do
    ~H"""
    <div class="flex items-center gap-2 text-sm">
      <.icon name={@icon} class="w-4 h-4 text-gray-400 flex-shrink-0" />
      <span class="text-gray-600"><%= @value %></span>
    </div>
    """
  end

  defp full_name(representative) do
    first = representative.first_name || ""
    last = representative.last_name || ""
    name = String.trim("#{first} #{last}")

    if name == "", do: "Representative ##{representative.id}", else: name
  end

  defp role_label(:legal), do: "Legal Representative"
  defp role_label(:autorizado), do: "Authorized Representative"
  defp role_label(:other), do: "Other"
  defp role_label(_), do: "Representative"

  defp role_badge_class(:legal), do: "bg-blue-100 text-blue-700"
  defp role_badge_class(:autorizado), do: "bg-green-100 text-green-700"
  defp role_badge_class(:other), do: "bg-gray-100 text-gray-700"
  defp role_badge_class(_), do: "bg-gray-100 text-gray-700"

  defp format_document(document) when is_binary(document) do
    document
    |> String.replace(~r/[^\d]/, "")
    |> case do
      <<a::binary-size(3), b::binary-size(3), c::binary-size(3), d::binary-size(2)>> ->
        "#{a}.#{b}.#{c}-#{d}"
      <<a::binary-size(2), b::binary-size(3), c::binary-size(3), d::binary-size(4), e::binary-size(2)>> ->
        "#{a}.#{b}.#{c}/#{d}-#{e}"
      doc -> doc
    end
  end
  defp format_document(nil), do: nil

  defp format_date(%Date{} = date), do: Calendar.strftime(date, "%d/%m/%Y")
  defp format_date(_), do: nil
end
