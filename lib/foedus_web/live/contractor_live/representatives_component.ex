defmodule FoedusWeb.ContractorLive.RepresentativesComponent do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <!-- Representante Legal -->
      <div class="bg-amber-50 rounded-xl p-6 border border-amber-100">
        <div class="flex items-center gap-3 mb-6">
          <div class="bg-amber-100 rounded-lg p-2">
            <svg class="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
            </svg>
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-900">Representante Legal</h3>
            <p class="text-sm text-amber-600">Responsável legal pela empresa</p>
          </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Primeiro Nome</label>
            <.input
              field={@form[:legal_representative_first_name]}
              type="text"
              placeholder="Primeiro nome"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Sobrenome</label>
            <.input
              field={@form[:legal_representative_last_name]}
              type="text"
              placeholder="Sobrenome"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">CPF</label>
            <.input
              field={@form[:legal_representative_cpf]}
              type="text"
              placeholder="000.000.000-00"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Data de Nascimento</label>
            <.input
              field={@form[:legal_representative_birth_date]}
              type="date"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">E-mail</label>
            <.input
              field={@form[:legal_representative_email]}
              type="email"
              placeholder="email@exemplo.com"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>
        </div>
      </div>

      <!-- Representante Autorizado -->
      <div class="bg-teal-50 rounded-xl p-6 border border-teal-100">
        <div class="flex items-center gap-3 mb-6">
          <div class="bg-teal-100 rounded-lg p-2">
            <svg class="w-5 h-5 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-900">Representante Autorizado</h3>
            <p class="text-sm text-teal-600">Pessoa autorizada a representar</p>
          </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">
          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">First Name</label>
            <.input
              field={@form[:authorized_representative_first_name]}
              type="text"
              placeholder="First name"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Last Name</label>
            <.input
              field={@form[:authorized_representative_last_name]}
              type="text"
              placeholder="Last name"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-1">
            <label class="block text-sm font-medium text-gray-700 mb-2">Birth Date</label>
            <.input
              field={@form[:authorized_representative_birth_date]}
              type="date"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">CPF</label>
            <.input
              field={@form[:authorized_representative_cpf]}
              type="text"
              placeholder="123.456.789-00"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-3">
            <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
            <.input
              field={@form[:authorized_representative_email]}
              type="email"
              placeholder="email@example.com"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
