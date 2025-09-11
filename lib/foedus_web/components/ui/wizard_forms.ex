defmodule FoedusWeb.Components.UI.WizardForms do
  use Phoenix.Component

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, default: 5
  attr :completed_steps, :list, default: []
  attr :form, :any, required: true
  attr :form_data, :map, default: %{}
  attr :class, :string, default: ""
  attr :target, :any, default: nil

  def wizard_forms(assigns) do
    ~H"""
    <div class={["max-w-full mx-auto p-6", @class]}>
      <!-- Header -->
      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-gray-900 mb-2">Contractor Registration</h1>
        <p class="text-gray-600">Complete all steps to register as a contractor</p>
      </div>

    <!-- Progress Indicator -->
      <.step_indicator
        current_step={@current_step}
        total_steps={@total_steps}
        completed_steps={@completed_steps}
      />

    <!-- Form Container -->
      <div class="bg-white rounded-2xl overflow-hidden">
        <div class="p-8">
          <!-- Step Content -->
          <div class="min-h-[400px]">
            <%= case @current_step do %>
              <% 1 -> %>
                <.live_component
                  module={FoedusWeb.ContractorLive.PersonalInfoComponent}
                  id="personal-info"
                  form={@form}
                />
              <% 2 -> %>
                <.live_component
                  module={FoedusWeb.ContractorLive.CompanyInfoComponent}
                  id="company-info"
                  form={@form}
                />
              <% 3 -> %>
                <.live_component
                  module={FoedusWeb.ContractorLive.RepresentativesComponent}
                  id="representatives"
                  form={@form}
                />
              <% 4 -> %>
                <.live_component
                  module={FoedusWeb.ContractorLive.AddressComponent}
                  id="address"
                  form={@form}
                />
              <% 5 -> %>
                <.review_step form_data={@form_data} form={@form} />
            <% end %>
          </div>

    <!-- Navigation -->
          <.step_navigation
            current_step={@current_step}
            total_steps={@total_steps}
            completed_steps={@completed_steps}
            target={@target}
          />
        </div>
      </div>
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, required: true
  attr :completed_steps, :list, default: []

  defp step_indicator(assigns) do
    ~H"""
    <div class="mb-8">
      <div class="flex items-center justify-between">
        <%= for step <- 1..@total_steps do %>
          <div class="flex flex-col items-center flex-1">
            <div class={[
              "w-10 h-10 rounded-full flex items-center justify-center text-sm font-medium transition-all duration-200",
              cond do
                step < @current_step or step in @completed_steps -> "bg-green-500 text-white"
                step == @current_step -> "bg-blue-500 text-white"
                true -> "bg-gray-200 text-gray-600"
              end
            ]}>
              <%= if step < @current_step or step in @completed_steps do %>
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                  <path
                    fill-rule="evenodd"
                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                    clip-rule="evenodd"
                  />
                </svg>
              <% else %>
                {step}
              <% end %>
            </div>
            <div class="mt-2 text-xs text-center text-gray-600">
              {step_name(step)}
            </div>
          </div>
          <%= if step < @total_steps do %>
            <div class={[
              "flex-1 h-1 mx-2 rounded transition-all duration-200",
              if(step < @current_step or step in @completed_steps,
                do: "bg-green-500",
                else: "bg-gray-200"
              )
            ]}>
            </div>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, required: true
  attr :completed_steps, :list, default: []
  attr :target, :any, default: nil

  defp step_navigation(assigns) do
    ~H"""
    <div class="flex items-center justify-between pt-6 border-t border-gray-100 mt-8">
      <div>
        <%= if @current_step > 1 do %>
          <button
            type="button"
            phx-click="previous_step"
            phx-target={@target}
            class="inline-flex items-center gap-2 px-6 py-3 text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 rounded-xl border border-gray-200 transition-all duration-200"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M15 19l-7-7 7-7"
              />
            </svg>
            Previous
          </button>
        <% end %>
      </div>

      <div class="flex items-center gap-3">
        <%= if @current_step < @total_steps do %>
          <button
            type="button"
            phx-click="next_step"
            phx-target={@target}
            class="inline-flex items-center gap-2 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg transition-all duration-200 transform hover:scale-105"
          >
            Next
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        <% else %>
          <button
            type="submit"
            phx-target={@target}
            class="inline-flex items-center gap-2 bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg transition-all duration-200 transform hover:scale-105"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 13l4 4L19 7"
              />
            </svg>
            Submit Registration
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  defp step_name(step) do
    case step do
      1 -> "Personal"
      2 -> "Company"
      3 -> "Representatives"
      4 -> "Address"
      5 -> "Review"
    end
  end

  attr :form_data, :map, required: true
  attr :form, :any, required: true

  defp review_step(assigns) do
    ~H"""
    <div class="space-y-6">
      <div class="text-center">
        <h3 class="text-2xl font-bold text-gray-900 mb-2">Review Your Information</h3>
        <p class="text-gray-600">Please review all information before submitting</p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="bg-gray-50 rounded-xl p-6">
          <h4 class="font-semibold text-gray-900 mb-4">Personal Information</h4>
          <div class="space-y-2 text-sm text-gray-600">
            <p><span class="font-medium">Name:</span> [Review data here]</p>
            <p><span class="font-medium">CPF:</span> [Review data here]</p>
            <p><span class="font-medium">Birth Date:</span> [Review data here]</p>
          </div>
        </div>

        <div class="bg-gray-50 rounded-xl p-6">
          <h4 class="font-semibold text-gray-900 mb-4">Company Information</h4>
          <div class="space-y-2 text-sm text-gray-600">
            <p><span class="font-medium">Company:</span> [Review data here]</p>
            <p><span class="font-medium">CNPJ:</span> [Review data here]</p>
            <p><span class="font-medium">Email:</span> [Review data here]</p>
          </div>
        </div>

        <div class="bg-gray-50 rounded-xl p-6">
          <h4 class="font-semibold text-gray-900 mb-4">Representatives</h4>
          <div class="space-y-2 text-sm text-gray-600">
            <p><span class="font-medium">Legal Rep:</span> [Review data here]</p>
            <p><span class="font-medium">Authorized Rep:</span> [Review data here]</p>
          </div>
        </div>

        <div class="bg-gray-50 rounded-xl p-6">
          <h4 class="font-semibold text-gray-900 mb-4">Address</h4>
          <div class="space-y-2 text-sm text-gray-600">
            <p><span class="font-medium">Street:</span> [Review data here]</p>
            <p><span class="font-medium">City:</span> [Review data here]</p>
            <p><span class="font-medium">State:</span> [Review data here]</p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
