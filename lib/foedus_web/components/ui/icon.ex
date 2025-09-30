defmodule FoedusWeb.Components.UI.Icon do
  use Phoenix.Component

  @doc """
  Renders a Heroicon icon.

  ## Examples

      <.icon name="bolt" />

      <.icon name="hero-user" class="w-6 h-6" />

      <.icon name="trash" class="w-5 h-5 text-red-500" />

      <.icon name="check-circle" class="w-4 h-4 text-green-500" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: nil

  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end

  def icon(assigns) do
    ~H"""
    <span class={["hero-" <> @name, @class]} />
    """
  end
end
