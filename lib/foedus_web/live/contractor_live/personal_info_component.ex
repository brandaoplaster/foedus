defmodule FoedusWeb.ContractorLive.PersonalInfoComponent do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-purple-50 rounded-xl p-6 border border-purple-100">
      <div class="flex items-center gap-3 mb-6">
        <div class="bg-purple-100 rounded-lg p-2">
          <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
          </svg>
        </div>
        <div>
          <h3 class="text-lg font-semibold text-gray-900">Personal Information</h3>
          <p class="text-sm text-purple-600">Individual details and contact</p>
        </div>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">
        <div class="lg:col-span-3">
          <label class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
          <.input
            field={@form[:full_name]}
            type="text"
            placeholder="John Doe Smith"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-1">
          <label class="block text-sm font-medium text-gray-700 mb-2">CPF</label>
          <.input
            field={@form[:cpf]}
            type="text"
            placeholder="123.456.789-00"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-1">
          <label class="block text-sm font-medium text-gray-700 mb-2">Birth Date</label>
          <.input
            field={@form[:birth_date]}
            type="date"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-2">Nationality</label>
          <.input
            field={@form[:nationality]}
            type="text"
            placeholder="Brazilian"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-3">
          <label class="block text-sm font-medium text-gray-700 mb-2">Mobile Phone</label>
          <.input
            field={@form[:mobile_phone]}
            type="tel"
            placeholder="(11) 91234-5678"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>
      </div>
    </div>
    """
  end
end
