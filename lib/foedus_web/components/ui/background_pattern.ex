defmodule FoedusWeb.Components.UI.BackgroundPattern do
  use Phoenix.Component

  attr :class, :string, default: ""
  attr :opacity, :string, default: "opacity-40"
  attr :overlay_color, :string, default: "bg-black/20"

  def background_pattern(assigns) do
    ~H"""
    <div class={[@overlay_color, @class]}>
      <div class="absolute inset-0"></div>
    </div>
    <div class={["absolute inset-0", @opacity]}>
      <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%239C92AC&quot; fill-opacity=&quot;0.05&quot;%3E%3Ccircle cx=&quot;30&quot; cy=&quot;30&quot; r=&quot;2&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    </div>
    """
  end
end
