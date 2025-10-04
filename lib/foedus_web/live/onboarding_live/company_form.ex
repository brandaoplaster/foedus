defmodule FoedusWeb.OnboardingLive.CompanyForm do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} id="company-form" phx-change="validate" phx-submit="next_step">
        <div class="space-y-6">
          <div>
            <.input
              field={@form[:trade_name]}
              type="text"
              label="Trade Name"
              placeholder="Enter company trade name"
              name="company[trade_name]"
              required
            />
          </div>

          <div>
            <.input
              field={@form[:cnpj]}
              type="text"
              label="CNPJ"
              placeholder="00.000.000/0000-00"
              name="company[cnpj]"
              required
            />
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
