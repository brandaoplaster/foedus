defmodule FoedusWeb.Components.UI.BrandLogo do
  use Phoenix.Component

  attr :title, :string, default: "Foedus"
  attr :class, :string, default: ""
  attr :title_class, :string, default: ""
  attr :underline_class, :string, default: ""

  def brand_logo(assigns) do
    ~H"""
    <div class={["mb-8", @class]}>
      <h1 class={[
        "text-6xl md:text-8xl font-bold bg-gradient-to-r from-white via-purple-200 to-white bg-clip-text text-transparent",
        @title_class
      ]}>
        <%= @title %>
      </h1>
      <div class={[
        "mt-2 w-24 h-1 bg-gradient-to-r from-purple-400 to-pink-400 mx-auto rounded-full",
        @underline_class
      ]}></div>
    </div>
    """
  end
end
