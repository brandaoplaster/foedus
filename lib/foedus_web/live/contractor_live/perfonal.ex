defmodule FoedusWeb.ContractorLive.Perfonal do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-2">
      <div class="flex items-center gap-3 mb-3">
        <div class="bg-purple-50 rounded-lg p-2">
          <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2V9a2 2 0 00-2-2H9V5z" />
          </svg>
        </div>
        <div>
          <label class="text-lg font-semibold text-gray-900">Tipo de Entidade</label>
          <p class="text-sm text-gray-500">Selecione se é pessoa física ou jurídica</p>
        </div>
      </div>
      <.input
        field={@form[:entity_type]}
        type="select"
        options={[
          {"Pessoa Física", 0},
          {"Pessoa Jurídica", 1}
        ]}
        class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
      />
    </div>
    """
  end
end
