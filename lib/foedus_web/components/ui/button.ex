defmodule FoedusWeb.Components.UI.Button do
  use Phoenix.Component

  @base_class "inline-flex items-center justify-center gap-2 border font-medium rounded-lg transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

  @variants %{
    "primary" => "border-transparent text-white bg-indigo-600 hover:bg-indigo-700",
    "secondary" => "border-gray-300 text-gray-700 bg-white hover:bg-gray-50",
    "success" => "border-transparent text-white bg-green-600 hover:bg-green-700",
    "danger" => "border-transparent text-white bg-red-600 hover:bg-red-700",
    "cta_primary" =>
      "group relative border-transparent text-white bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 transform hover:scale-105 transition-all duration-200 shadow-xl hover:shadow-2xl",
    "cta_secondary" =>
      "border-white/20 text-white bg-white/10 backdrop-blur-sm hover:bg-white/20",
    "soft_indigo" => "border-indigo-50 text-indigo-700 bg-indigo-50 hover:bg-indigo-100",
    "soft_gray" => "border-gray-50 text-gray-700 bg-gray-50 hover:bg-gray-100",
    "soft_red" => "border-red-50 text-red-600 bg-red-50 hover:bg-red-100",
    "soft_green" => "border-green-50 text-green-600 bg-green-50 hover:bg-green-100",
    "soft_blue" => "border-blue-50 text-blue-600 bg-blue-50 hover:bg-blue-100",
    "soft_purple" => "border-purple-50 text-purple-600 bg-purple-50 hover:bg-purple-100",
    "soft_yellow" => "border-yellow-50 text-yellow-600 bg-yellow-50 hover:bg-yellow-100"
  }

  @sizes %{
    "sm" => "px-3 py-1.5 text-xs",
    "md" => "px-4 py-2 text-sm",
    "lg" => "px-4 py-3 text-sm"
  }

  @cached_classes %{
    {"primary", "md", false} => "#{@base_class} #{@variants["primary"]} #{@sizes["md"]}",
    {"secondary", "md", false} => "#{@base_class} #{@variants["secondary"]} #{@sizes["md"]}",
    {"primary", "md", true} => "#{@base_class} #{@variants["primary"]} #{@sizes["md"]} w-full",
    {"secondary", "md", true} =>
      "#{@base_class} #{@variants["secondary"]} #{@sizes["md"]} w-full",
    {"danger", "md", false} => "#{@base_class} #{@variants["danger"]} #{@sizes["md"]}",
    {"success", "md", false} => "#{@base_class} #{@variants["success"]} #{@sizes["md"]}"
  }

  @doc """
  Renders a button with various styling options.

  ## Examples
      <.button variant="primary" size="md">
        Click me
      </.button>

      <.button variant="danger" icon="trash" full_width>
        Delete
      </.button>

      <.button variant="soft_blue" size="lg" phx-click="save">
        Save Changes
      </.button>
  """
  attr :variant, :string, default: "primary"
  attr :size, :string, default: "md"
  attr :icon, :string, default: nil
  attr :full_width, :boolean, default: false
  attr :rest, :global, include: ~w(phx-click phx-value-id disabled type class)

  slot :inner_block, required: true

  def button(assigns) do
    button_class = get_cached_class_or_build(assigns.variant, assigns.size, assigns.full_width)

    assigns = assign(assigns, button_class: button_class)

    ~H"""
    <button class={@button_class} {@rest}>
      <%= if @icon do %>
        <%!-- <Icon.icon name={@icon} class="w-4 h-4" /> --%>
      <% end %>
      {render_slot(@inner_block)}
    </button>
    """
  end

  defp get_cached_class_or_build(variant, size, full_width) do
    cache_key = {variant, size, full_width}

    case Map.get(@cached_classes, cache_key) do
      nil -> build_button_class_dynamic(variant, size, full_width)
      cached_class -> cached_class
    end
  end

  defp build_button_class_dynamic(variant, size, full_width) do
    variant_class = Map.get(@variants, variant, @variants["primary"])
    size_class = Map.get(@sizes, size, @sizes["md"])

    case full_width do
      true -> "#{@base_class} #{variant_class} #{size_class} w-full"
      _ -> "#{@base_class} #{variant_class} #{size_class}"
    end
  end
end
