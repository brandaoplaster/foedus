defmodule FoedusWeb.ContractorLive.AddressComponent do
  use FoedusWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-indigo-50 rounded-xl p-6 border border-indigo-100">
      <div class="flex items-center gap-3 mb-6">
        <div class="bg-indigo-100 rounded-lg p-2">
          <svg class="w-5 h-5 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
          </svg>
        </div>
        <div>
          <h3 class="text-lg font-semibold text-gray-900">Address Information</h3>
          <p class="text-sm text-indigo-600">Location and address details</p>
        </div>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-4">
        <div class="lg:col-span-3">
          <label class="block text-sm font-medium text-gray-700 mb-2">Street</label>
          <.input
            field={@form[:address_street]}
            type="text"
            placeholder="Street name"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-1">
          <label class="block text-sm font-medium text-gray-700 mb-2">Number</label>
          <.input
            field={@form[:address_number]}
            type="text"
            placeholder="123"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-2">Complement</label>
          <.input
            field={@form[:address_complement]}
            type="text"
            placeholder="Apt, Suite, Unit"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-2">Neighborhood</label>
          <.input
            field={@form[:address_neighborhood]}
            type="text"
            placeholder="Downtown"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-2">City</label>
          <.input
            field={@form[:address_city]}
            type="text"
            placeholder="São Paulo"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-1">
          <label class="block text-sm font-medium text-gray-700 mb-2">State</label>
          <.input
            field={@form[:address_state]}
            type="text"
            placeholder="SP"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-1">
          <label class="block text-sm font-medium text-gray-700 mb-2">ZIP Code</label>
          <.input
            field={@form[:address_zipcode]}
            type="text"
            placeholder="01234-567"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>

        <div class="lg:col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-2">Country</label>
          <.input
            field={@form[:address_country]}
            type="text"
            placeholder="Brazil"
            value="Brazil"
            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          />
        </div>
      </div>
    </div>
    """
  end
end
