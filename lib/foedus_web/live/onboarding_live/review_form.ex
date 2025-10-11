defmodule FoedusWeb.OnboardingLive.ReviewForm do
  use FoedusWeb, :live_component

  @impl true
  def update(assigns, socket) do
    form_data = Map.get(assigns, :form_data, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form_data, form_data)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <div class="bg-gray-50 rounded-lg p-6">
        <h3 class="text-lg font-semibold mb-4">Company Information</h3>
        <dl class="space-y-3">
          <div>
            <dt class="text-sm font-medium text-gray-500">Trade Name</dt>
            <dd class="text-base text-gray-900">
              {get_in(@form_data, [:company, "trade_name"]) || "-"}
            </dd>
          </div>
          <div>
            <dt class="text-sm font-medium text-gray-500">CNPJ</dt>
            <dd class="text-base text-gray-900">{get_in(@form_data, [:company, "cnpj"]) || "-"}</dd>
          </div>
        </dl>
      </div>

      <div class="bg-gray-50 rounded-lg p-6">
        <h3 class="text-lg font-semibold mb-4">User Information</h3>
        <dl class="space-y-3">
          <div>
            <dt class="text-sm font-medium text-gray-500">Email</dt>
            <dd class="text-base text-gray-900">{get_in(@form_data, [:user, "email"]) || "-"}</dd>
          </div>
          <div>
            <dt class="text-sm font-medium text-gray-500">Password</dt>
            <dd class="text-base text-gray-900">••••••••</dd>
          </div>
        </dl>
      </div>
    </div>
    """
  end
end
