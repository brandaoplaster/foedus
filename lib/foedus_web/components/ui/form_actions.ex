defmodule FoedusWeb.Components.UI.FormActions do
  use Phoenix.Component

  import FoedusWeb.Components.UI.Button

  @doc """
  Renders form action buttons (Cancel and Submit).

  ## Examples

      <.form_actions
        on_cancel={JS.patch(~p"/signers")}
        submit_text="Create Signer"
      />
  """
  attr :on_cancel, Phoenix.LiveView.JS, required: true
  attr :submit_text, :string, required: true
  attr :show_icon, :boolean, default: true

  def form_actions(assigns) do
    ~H"""
    <div class="flex items-center justify-end gap-3 pt-6 border-t border-gray-100">
      <.button
        variant="secondary"
        size="lg"
        type="button"
        phx-click={@on_cancel}
      >
        Cancel
      </.button>

      <.button
        variant="cta_primary"
        size="lg"
        type="submit"
      >
        <svg :if={@show_icon} class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M5 13l4 4L19 7"
          />
        </svg>
        {@submit_text}
      </.button>
    </div>
    """
  end
end
