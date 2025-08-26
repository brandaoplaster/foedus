defmodule FoedusWeb.Components.UI.Button do
  use Phoenix.Component
  alias FoedusWeb.Components.UI.Icon

  # Button variants
  @variants %{
    "primary" => "border-transparent text-white bg-indigo-600 hover:bg-indigo-700",
    "secondary" => "border-gray-300 text-gray-700 bg-white hover:bg-gray-50",
    "success" => "border-transparent text-white bg-green-600 hover:bg-green-700",
    "danger" => "border-transparent text-white bg-red-600 hover:bg-red-700",
    "cta_primary" => "group relative border-transparent text-white bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 transform hover:scale-105 transition-all duration-200 shadow-xl hover:shadow-2xl",
    "cta_secondary" => "border-white/20 text-white bg-white/10 backdrop-blur-sm hover:bg-white/20"
  }

  attr :variant, :string, default: "primary"
  attr :size, :string, default: "md"
  attr :icon, :string, default: nil
  attr :full_width, :boolean, default: false
  attr :rest, :global, include: ~w(phx-click phx-value-id disabled type class)
  slot :inner_block, required: true

  def button(assigns) do
    variant_class = Map.get(@variants, assigns.variant, @variants["primary"])

    size_class = case assigns.size do
      "sm" -> "px-3 py-1.5 text-xs"
      "md" -> "px-4 py-2 text-sm"
      "lg" -> "px-4 py-3 text-sm"
      _ -> "px-4 py-2 text-sm"
    end

    width_class = if assigns.full_width, do: "w-full", else: ""

    base_class = "inline-flex items-center justify-center border font-medium rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

    assigns = assign(assigns,
      button_class: "#{base_class} #{variant_class} #{size_class} #{width_class}"
    )

    ~H"""
    <button class={@button_class} {@rest}>
      <%= if @icon do %>
        <Icon.icon name={@icon} class="w-5 h-5 mr-2" />
      <% end %>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
