defmodule FoedusWeb.Components.UI.FloatingElements do
  use Phoenix.Component

  attr :class, :string, default: ""

  def floating_elements(assigns) do
    ~H"""
    <div class={@class}>
      <div class="absolute top-20 left-10 w-20 h-20 bg-purple-400/20 rounded-full blur-xl animate-pulse"></div>
      <div class="absolute bottom-20 right-10 w-32 h-32 bg-pink-400/20 rounded-full blur-xl animate-pulse delay-1000"></div>
      <div class="absolute top-1/2 right-1/4 w-16 h-16 bg-blue-400/20 rounded-full blur-xl animate-pulse delay-500"></div>
    </div>
    """
  end
end
