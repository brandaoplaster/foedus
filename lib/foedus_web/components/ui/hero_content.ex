defmodule FoedusWeb.Components.UI.HeroContent do
  use Phoenix.Component

  attr :title, :string, required: true
  attr :highlight, :string, required: true
  attr :subtitle, :string, required: true
  attr :class, :string, default: ""
  attr :title_class, :string, default: ""
  attr :subtitle_class, :string, default: ""

  def hero_content(assigns) do
    ~H"""
    <div class={@class}>
      <h2 class={[
        "text-3xl md:text-5xl lg:text-6xl font-bold text-white mb-6 leading-tight",
        @title_class
      ]}>
        <%= @title %>
        <span class="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
          <%= @highlight %>
        </span>
      </h2>

      <p class={[
        "text-xl md:text-2xl text-gray-300 mb-10 max-w-3xl mx-auto leading-relaxed",
        @subtitle_class
      ]}>
        <%= @subtitle %>
      </p>
    </div>
    """
  end
end
