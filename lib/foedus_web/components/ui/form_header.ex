defmodule FoedusWeb.Components.UI.FormHeader do
  use Phoenix.Component
  alias FoedusWeb.Components.UI.Icon

  @doc """
  Renders a gradient header with icon, title, subtitle and close button for forms.

  ## Examples

      <.form_header
        title="New Signer"
        subtitle="Add signers to your contracts"
        icon="user"
        on_close={JS.patch(~p"/signers")}
      />
  """
  attr :title, :string, required: true
  attr :subtitle, :string, default: nil
  attr :icon, :string, required: true
  attr :on_close, Phoenix.LiveView.JS, required: true
  attr :gradient, :string, default: "from-indigo-600 to-purple-600"

  def form_header(assigns) do
    ~H"""
    <div class={"bg-gradient-to-r #{@gradient} px-8 py-6 relative"}>
      <div class="flex items-center gap-4">
        <div class="bg-white/20 backdrop-blur-sm rounded-xl p-3">
          <Icon.icon name={@icon} class="w-6 h-6 text-white" />
        </div>
        <div>
          <h2 class="text-2xl font-bold text-white">{@title}</h2>
          <p :if={@subtitle} class="text-indigo-100 mt-1">
            {@subtitle}
          </p>
        </div>
      </div>

      <button
        type="button"
        phx-click={@on_close}
        class="absolute top-4 right-4 p-2 rounded-lg bg-white/10 hover:bg-white/20 backdrop-blur-sm transition-colors duration-200 group"
        aria-label="Close"
      >
        <svg
          class="w-5 h-5 text-white group-hover:rotate-90 transition-transform duration-200"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      </button>
    </div>
    """
  end
end
