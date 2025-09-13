defmodule FoedusWeb.ContractorLive.CompanyInfoComponent do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <!-- Company Data -->
      <div class="bg-blue-50 rounded-xl p-6 border border-blue-100">
        <div class="flex items-center gap-3 mb-6">
          <div class="bg-blue-100 rounded-lg p-2">
            <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
            </svg>
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-900">Company Information</h3>
            <p class="text-sm text-blue-600">Business details and registration</p>
          </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Company Name</label>
            <.input
              field={@form[:company_name]}
              type="text"
              placeholder="Legal company name"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Trade Name</label>
            <.input
              field={@form[:trade_name]}
              type="text"
              placeholder="Doing business as"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">CNPJ</label>
            <.input
              field={@form[:cnpj]}
              type="text"
              placeholder="12.345.678/0001-90"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Company Type</label>
            <.input
              field={@form[:company_type]}
              type="text"
              placeholder="LLC, Corporation, Partnership"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>
        </div>
      </div>

      <!-- Contact Information -->
      <div class="bg-green-50 rounded-xl p-6 border border-green-100">
        <div class="flex items-center gap-3 mb-6">
          <div class="bg-green-100 rounded-lg p-2">
            <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
            </svg>
          </div>
          <div>
            <h3 class="text-lg font-semibold text-gray-900">Contact Information</h3>
            <p class="text-sm text-green-600">Communication details</p>
          </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <div class="lg:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
            <.input
              field={@form[:email]}
              type="email"
              placeholder="contact@company.com"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-1">
            <label class="block text-sm font-medium text-gray-700 mb-2">Phone</label>
            <.input
              field={@form[:phone]}
              type="tel"
              placeholder="(11) 1234-5678"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-1">
            <label class="block text-sm font-medium text-gray-700 mb-2">Mobile</label>
            <.input
              field={@form[:mobile_phone]}
              type="tel"
              placeholder="(11) 91234-5678"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>

          <div class="lg:col-span-4">
            <label class="block text-sm font-medium text-gray-700 mb-2">Website</label>
            <.input
              field={@form[:website]}
              type="url"
              placeholder="https://www.company.com"
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
