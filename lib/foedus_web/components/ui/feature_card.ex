defmodule FoedusWeb.Components.UI.FeatureCard do
  use Phoenix.Component
  import FoedusWeb.Components.UI.{Card, Icon}

  attr :icon, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :class, :string, default: ""
  attr :icon_class, :string, default: ""
  attr :title_class, :string, default: ""
  attr :description_class, :string, default: ""

  def feature_card(assigns) do
    ~H"""
    <.card class={"group p-6 bg-white/5 backdrop-blur-sm rounded-2xl border border-white/10 hover:bg-white/10 transition-all duration-300 #{@class}"}>
      <div class={"w-12 h-12 bg-gradient-to-r from-purple-400 to-pink-400 rounded-xl flex items-center justify-center mb-4 mx-auto group-hover:scale-110 transition-transform duration-300 #{@icon_class}"}>
        <.icon name={@icon} class="w-6 h-6 text-white" />
      </div>
      <h3 class={"text-xl font-semibold text-white mb-2 #{@title_class}"}>
        <%= @title %>
      </h3>
      <p class={"text-gray-300 #{@description_class}"}>
        <%= @description %>
      </p>
    </.card>
    """
  end
end
