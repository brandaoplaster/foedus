defmodule FoedusWeb.Components.Helpers.ActionRenderer do
  @moduledoc """
  Renders table action buttons
  """
  use Phoenix.Component
  alias FoedusWeb.Components.Helpers.StreamHelpers

  def render(assigns) do
    ~H"""
    <%= case @action do %>
      <% :show -> %>
        <.link navigate={"#{@resource_path}/#{StreamHelpers.get_item_id(@item)}"} class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-blue-100 text-blue-800 hover:bg-blue-200 transition-colors duration-150">
          View
        </.link>
      <% :edit -> %>
        <.link navigate={"#{@resource_path}/#{StreamHelpers.get_item_id(@item)}/edit"} class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-indigo-100 text-indigo-800 hover:bg-indigo-200 transition-colors duration-150">
          Edit
        </.link>
      <% :delete -> %>
        <.link
          phx-click="delete"
          phx-value-id={StreamHelpers.get_item_id(@item)}
          data-confirm="Are you sure you want to delete this item?"
          class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-red-100 text-red-800 hover:bg-red-200 transition-colors duration-150"
        >
          Delete
        </.link>
      <% custom_action when is_map(custom_action) -> %>
        <.link
          {Map.get(custom_action, :attrs, [])}
          class={Map.get(custom_action, :class, "inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-gray-100 text-gray-800 hover:bg-gray-200 transition-colors duration-150")}
        >
          <%= Map.get(custom_action, :label, "Action") %>
        </.link>
    <% end %>
    """
  end
end
