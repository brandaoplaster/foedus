defmodule FoedusWeb.HomeLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.HeroSection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <.hero_section />
    </div>
    """
  end
end
