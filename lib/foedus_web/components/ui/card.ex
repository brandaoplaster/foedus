defmodule FoedusWeb.Components.UI.Card do
  use Phoenix.Component

  import FoedusWeb.Components.UI.Icon

  attr :class, :string, default: ""
  attr :title, :string, default: nil
  attr :icon, :string, default: nil
  attr :icon_color, :string, default: "gray"

  slot :header
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <div class={["bg-white shadow-sm rounded-lg border border-gray-200", @class]}>
      <%= cond do %>
        <% @header != [] -> %>
          <div class="px-6 py-5 border-b border-gray-200">
            {render_slot(@header)}
          </div>
        <% @title -> %>
          <div class="px-6 py-5 border-b border-gray-200">
            <div class="flex items-center gap-3">
              <%= if @icon do %>
                <div class={["rounded-lg p-2", icon_bg_class(@icon_color)]}>
                  <.icon name={@icon} class={["w-5 h-5", icon_text_class(@icon_color)]} />
                </div>
              <% end %>
              <h3 class="text-lg font-semibold text-gray-900">{@title}</h3>
            </div>
          </div>
        <% true -> %>
      <% end %>

      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :title, :string, required: true
  attr :value, :any, required: true
  attr :icon, :string, required: true
  attr :color, :string, default: "blue"

  def stat_card(assigns) do
    ~H"""
    <.card class="hover:shadow-md transition-shadow">
      <div class="p-6">
        <div class="flex items-center">
          <div class="flex-shrink-0">
            <div class={"w-10 h-10 bg-#{@color}-500 rounded-lg flex items-center justify-center"}>
              <.icon name={@icon} class="w-6 h-6 text-white" />
            </div>
          </div>
          <div class="ml-4">
            <div class="text-sm font-medium text-gray-600">
              {@title}
            </div>
            <div class="text-2xl font-bold text-gray-900">
              {@value}
            </div>
          </div>
        </div>
      </div>
    </.card>
    """
  end

  defp icon_bg_class("blue"), do: "bg-blue-50"
  defp icon_bg_class("green"), do: "bg-green-50"
  defp icon_bg_class("purple"), do: "bg-purple-50"
  defp icon_bg_class("red"), do: "bg-red-50"
  defp icon_bg_class("yellow"), do: "bg-yellow-50"
  defp icon_bg_class("indigo"), do: "bg-indigo-50"
  defp icon_bg_class(_), do: "bg-gray-50"

  defp icon_text_class("blue"), do: "text-blue-600"
  defp icon_text_class("green"), do: "text-green-600"
  defp icon_text_class("purple"), do: "text-purple-600"
  defp icon_text_class("red"), do: "text-red-600"
  defp icon_text_class("yellow"), do: "text-yellow-600"
  defp icon_text_class("indigo"), do: "text-indigo-600"
  defp icon_text_class(_), do: "text-gray-600"

  defp stat_bg_class("blue"), do: "bg-blue-500"
  defp stat_bg_class("green"), do: "bg-green-500"
  defp stat_bg_class("purple"), do: "bg-purple-500"
  defp stat_bg_class("red"), do: "bg-red-500"
  defp stat_bg_class("yellow"), do: "bg-yellow-500"
  defp stat_bg_class("indigo"), do: "bg-indigo-500"
  defp stat_bg_class(_), do: "bg-gray-500"
end
