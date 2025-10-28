defmodule FoedusWeb.Components.UI.AddressesList do
  use Phoenix.Component

  import FoedusWeb.Components.UI.{Card, Icon}

  attr :addresses, :list, required: true
  attr :title, :string, default: "Addresses"
  attr :class, :any, default: ""

  def addresses_list(assigns) do
    ~H"""
    <%= if @addresses != [] do %>
      <.card title={@title} icon="hero-zap" icon_color="red" class={["w-full", @class]}>
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
          <div class="p-6">
            <div class="space-y-4">
              <.address_card
                :for={addr <- @addresses}
                address={addr}
              />
            </div>
          </div>
        </div>
      </.card>
    <% end %>
    """
  end

  attr :address, :map, required: true

  defp address_card(assigns) do
    ~H"""
    <div class="border border-gray-200 rounded-lg p-4 hover:border-gray-300 transition-colors">
      <div class="space-y-3">
        <div class="flex items-start justify-between">
          <div>
            <h3 class="text-gray-900 font-semibold text-lg">
              {address_label(@address)}
            </h3>
            <%= if @address.address_type do %>
              <span class={[
                "inline-block mt-1 px-2 py-1 text-xs font-medium rounded-full",
                address_type_class(@address.address_type)
              ]}>
                {address_type_label(@address.address_type)}
              </span>
            <% end %>
          </div>
        </div>

        <div class="space-y-2">
          <%= if @address.street || @address.number do %>
            <.info_row
              icon="hero-map-pin"
              value={format_street(@address.street, @address.number)}
            />
          <% end %>

          <%= if @address.complement do %>
            <.info_row icon="hero-building-office-2" value={@address.complement} />
          <% end %>

          <%= if @address.neighborhood do %>
            <.info_row icon="hero-building-storefront" value={@address.neighborhood} />
          <% end %>

          <%= if @address.city || @address.state do %>
            <.info_row
              icon="hero-map"
              value={format_city_state(@address.city, @address.state)}
            />
          <% end %>

          <%= if @address.zipcode do %>
            <.info_row icon="hero-envelope" value={format_zipcode(@address.zipcode)} />
          <% end %>

          <%= if @address.country do %>
            <.info_row icon="hero-globe-americas" value={@address.country} />
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
      <span class="text-gray-600">{@value}</span>
    </div>
    """
  end

  defp address_label(address) do
    if address.street || address.city do
      "Address"
    else
      "Address ##{address.id}"
    end
  end

  defp address_type_label(:residential), do: "Residential"
  defp address_type_label(:commercial), do: "Commercial"
  defp address_type_label(:billing), do: "Billing"
  defp address_type_label(_), do: "Address"

  defp address_type_class(:residential), do: "bg-blue-100 text-blue-700"
  defp address_type_class(:commercial), do: "bg-purple-100 text-purple-700"
  defp address_type_class(:billing), do: "bg-green-100 text-green-700"
  defp address_type_class(_), do: "bg-gray-100 text-gray-700"

  defp format_street(street, number) do
    case {street, number} do
      {nil, nil} -> nil
      {street, nil} -> street
      {nil, number} -> "Nº #{number}"
      {street, number} -> "#{street}, #{number}"
    end
  end

  defp format_city_state(city, state) do
    case {city, state} do
      {nil, nil} -> nil
      {city, nil} -> city
      {nil, state} -> state
      {city, state} -> "#{city}, #{state}"
    end
  end

  defp format_zipcode(zipcode) when is_binary(zipcode) do
    zipcode
    |> String.replace(~r/[^\d]/, "")
    |> case do
      <<a::binary-size(5), b::binary-size(3)>> -> "#{a}-#{b}"
      zip -> zip
    end
  end

  defp format_zipcode(nil), do: nil
end
