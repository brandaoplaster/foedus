defmodule FoedusWeb.Components.UI.Card do
  use Phoenix.Component

  import FoedusWeb.Components.UI.Icon

  attr :class, :string, default: ""
  slot :header
  slot :inner_block, required: true

   def card(assigns) do
    ~H"""
    <div class={"bg-white shadow-sm rounded-lg border border-gray-200 #{@class}"}>
      <%= if @header != [] do %>
        <div class="px-6 py-5 border-b border-gray-200">
          <%= render_slot(@header) %>
        </div>
      <% end %>
      <%= render_slot(@inner_block) %>
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
              <%= @title %>
            </div>
            <div class="text-2xl font-bold text-gray-900">
              <%= @value %>
            </div>
          </div>
        </div>
      </div>
    </.card>
    """
  end
end
