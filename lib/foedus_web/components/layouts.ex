defmodule FoedusWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.
  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use FoedusWeb, :controller` and
  `use FoedusWeb, :live_view`.
  """
  use FoedusWeb, :html

  embed_templates "layouts/*"

  attr :current_user, :any, default: nil

  def app_header(assigns) do
    ~H"""
    <header class="fixed top-0 left-0 right-0 z-50 bg-white shadow-sm border-b border-gray-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <.app_logo />
          <.app_navigation current_user={@current_user} />
          <.app_user_menu current_user={@current_user} />
        </div>
        <.app_mobile_menu current_user={@current_user} />
      </div>
    </header>
    """
  end

  def app_logo(assigns) do
    ~H"""
    <div class="flex items-center">
      <.link navigate={~p"/"} class="flex items-center space-x-2">
        <div class="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center">
          <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
            />
          </svg>
        </div>
        <span class="text-xl font-bold text-gray-900">Foedus</span>
      </.link>
    </div>
    """
  end

  attr :current_user, :any, default: nil

  def app_navigation(assigns) do
    ~H"""
    <%= if @current_user do %>
      <nav class="hidden md:flex items-center space-x-8">
        <.nav_link navigate={~p"/dashboard"}>Dashboard</.nav_link>
        <.nav_link navigate={~p"/contract_templates"}>Contract Templates</.nav_link>
        <.nav_link navigate={~p"/contractors"}>Contractors</.nav_link>
        <.nav_link href="#">Relatórios</.nav_link>
      </nav>
    <% end %>
    """
  end

  attr :current_user, :any, default: nil

  def app_user_menu(assigns) do
    ~H"""
    <div class="flex items-center space-x-4">
      <%= if @current_user do %>
        <div class="hidden sm:flex items-center space-x-4">
          <span class="text-sm text-gray-700">
            Olá, <span class="font-medium">{@current_user.email}</span>
          </span>
          <div class="flex items-center space-x-2">
            <.link
              href={~p"/users/settings"}
              class="text-sm text-gray-600 hover:text-indigo-600 font-medium transition-colors"
            >
              Configurações
            </.link>
            <span class="text-gray-300">|</span>
            <.link
              href={~p"/users/log_out"}
              method="delete"
              class="text-sm text-gray-600 hover:text-red-600 font-medium transition-colors"
            >
              Sair
            </.link>
          </div>
        </div>

        <.mobile_menu_button />
      <% else %>
        <.auth_links />
      <% end %>
    </div>
    """
  end

  attr :current_user, :any, default: nil

  def app_mobile_menu(assigns) do
    ~H"""
    <%= if @current_user do %>
      <div id="mobile-menu" class="hidden md:hidden py-4 border-t border-gray-200">
        <div class="space-y-2">
          <.mobile_nav_link navigate={~p"/dashboard"}>Dashboard</.mobile_nav_link>
          <.mobile_nav_link navigate={~p"/contract_templates"}>Templates</.mobile_nav_link>
          <.mobile_nav_link href="#">Contratos</.mobile_nav_link>
          <.mobile_nav_link href="#">Relatórios</.mobile_nav_link>

          <hr class="my-2 border-gray-200" />

          <.mobile_nav_link href={~p"/users/settings"}>Configurações</.mobile_nav_link>
          <.link
            href={~p"/users/log_out"}
            method="delete"
            class="block px-3 py-2 text-red-600 hover:text-red-700 hover:bg-red-50 rounded-md text-sm font-medium transition-colors"
          >
            Sair
          </.link>
        </div>
      </div>
    <% end %>
    """
  end

  def app_footer(assigns) do
    ~H"""
    <footer class="bg-white border-t border-gray-200 mt-auto shrink-0">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
        <div class="text-center text-sm text-gray-500">
          © 2025 Foedus - Sistema de Gestão de Contratos. Todos os direitos reservados.
        </div>
      </div>
    </footer>
    """
  end

  attr :navigate, :string, default: nil
  attr :href, :string, default: nil
  slot :inner_block, required: true

  def nav_link(assigns) do
    ~H"""
    <.link
      navigate={@navigate}
      href={@href}
      class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium transition-colors"
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  attr :navigate, :string, default: nil
  attr :href, :string, default: nil
  slot :inner_block, required: true

  def mobile_nav_link(assigns) do
    ~H"""
    <.link
      navigate={@navigate}
      href={@href}
      class="block px-3 py-2 text-gray-700 hover:text-indigo-600 hover:bg-gray-50 rounded-md text-sm font-medium transition-colors"
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def mobile_menu_button(assigns) do
    ~H"""
    <div class="sm:hidden">
      <button
        type="button"
        class="p-2 rounded-md text-gray-600 hover:text-gray-900 hover:bg-gray-100 transition-colors"
        onclick="document.getElementById('mobile-menu').classList.toggle('hidden')"
      >
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M4 6h16M4 12h16M4 18h16"
          />
        </svg>
      </button>
    </div>
    """
  end

  def auth_links(assigns) do
    ~H"""
    <div class="flex items-center space-x-4">
      <.link
        href={~p"/users/log_in"}
        class="text-sm font-medium text-gray-700 hover:text-indigo-600 transition-colors"
      >
        Entrar
      </.link>
      <.link
        href={~p"/users/register"}
        class="bg-indigo-600 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-indigo-700 transition-colors"
      >
        Cadastrar
      </.link>
    </div>
    """
  end
end
