defmodule FoedusWeb.Components.UI.Breadcrumb do
  @moduledoc """
  Breadcrumb component for navigation hierarchy display.

  Provides a flexible breadcrumb navigation system with customizable styling
  and support for multiple levels of navigation.

  ## Example

      <.breadcrumb>
        <.breadcrumb_link navigate={~p"/"}>
          Home
        </.breadcrumb_link>
        <.breadcrumb_separator />
        <.breadcrumb_link navigate={~p"/contract_templates"}>
          Contract Templates
        </.breadcrumb_link>
        <.breadcrumb_separator />
        <.breadcrumb_current>
          Template #123
        </.breadcrumb_current>
      </.breadcrumb>

  ## Custom styling

      <.breadcrumb class="flex items-center space-x-3 text-base mb-4">
        <!-- breadcrumb content -->
      </.breadcrumb>

  ## Using patch instead of navigate

      <.breadcrumb_link patch={~p"/contract_templates/123/edit"}>
        Edit Template
      </.breadcrumb_link>
  """
  use Phoenix.Component

  @doc """
  Renders a breadcrumb navigation container.

  ## Attributes

    * `class` - CSS classes for the nav element.
      Defaults to "flex items-center space-x-2 text-sm text-gray-500 mb-6"

  ## Slots

    * `inner_block` - The breadcrumb items (links, separators, current item)
  """
  attr :class, :string, default: "flex items-center space-x-2 text-sm text-gray-500 mb-6"
  slot :inner_block, required: true

  def breadcrumb(assigns) do
    ~H"""
    <nav class={@class}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  @doc """
  Renders a clickable breadcrumb link.

  ## Attributes

    * `navigate` - Path for navigation (uses Phoenix.LiveView.JS.navigate)
    * `patch` - Path for patching (uses Phoenix.LiveView.JS.patch)
    * `class` - CSS classes for the link. Defaults to "hover:text-indigo-600 transition-colors"

  Note: Use either `navigate` or `patch`, not both.

  ## Example

      <.breadcrumb_link navigate={~p"/users"}>
        Users
      </.breadcrumb_link>

      <.breadcrumb_link patch={~p"/users/123/edit"}>
        Edit User
      </.breadcrumb_link>
  """
  attr :navigate, :string, default: nil
  attr :patch, :string, default: nil
  attr :class, :string, default: "hover:text-indigo-600 transition-colors"
  slot :inner_block, required: true

  def breadcrumb_link(assigns) do
    ~H"""
    <.link navigate={@navigate} patch={@patch} class={@class}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  @doc """
  Renders a breadcrumb separator (chevron right icon).

  No attributes needed, displays a simple right-pointing arrow.

  ## Example

      <.breadcrumb_separator />
  """
  def breadcrumb_separator(assigns) do
    ~H"""
    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
      <path
        fill-rule="evenodd"
        d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  @doc """
  Renders the current breadcrumb item (non-clickable).

  Used to indicate the current page in the breadcrumb trail.

  ## Attributes

    * `class` - CSS classes for the span element. Defaults to "text-gray-900 font-medium"

  ## Example

      <.breadcrumb_current>
        Current Page
      </.breadcrumb_current>

      <.breadcrumb_current class="text-indigo-900 font-bold">
        Important Page
      </.breadcrumb_current>
  """
  attr :class, :string, default: "text-gray-900 font-medium"
  slot :inner_block, required: true

  def breadcrumb_current(assigns) do
    ~H"""
    <span class={@class}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end
