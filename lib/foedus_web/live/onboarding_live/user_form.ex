defmodule FoedusWeb.OnboardingLive.UserForm do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} id="user-form" phx-change="validate" phx-submit="next_step">
        <div class="space-y-6">
          <div>
            <.input
              field={@form[:email]}
              type="email"
              label="Email"
              placeholder="user@example.com"
              name="user[email]"
              required
            />
          </div>

          <div>
            <.input
              field={@form[:password]}
              type="password"
              label="Password"
              placeholder="Enter your password"
              name="user[password]"
              required
            />
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
