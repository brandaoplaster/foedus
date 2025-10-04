defmodule FoedusWeb.Components.UI.WizardForms do
  use Phoenix.Component

  attr :current_step, :integer, required: true
  attr :steps, :list, required: true
  attr :completed_steps, :list, default: []
  attr :form, :any, required: true
  attr :form_data, :map, default: %{}
  attr :class, :string, default: ""
  attr :target, :any, default: nil
  attr :title, :string, default: "Registration"
  attr :subtitle, :string, default: "Complete all steps to register"

  @doc """
  Renders a multi-step wizard form component with step indicator, navigation, and dynamic content.

  ## Examples

      <.wizard_forms
        current_step={@current_step}
        steps={@steps}
        completed_steps={@completed_steps}
        form={@form}
        form_data={@form_data}
        target={@myself}
        title="User Registration"
        subtitle="Complete all steps to create your account"
      />

  ## Parameters

  - `current_step` - The current active step number (1-based index)
  - `steps` - List of step configurations with `%{number: integer, title: string, component: module, id: string, type: atom}`
  - `completed_steps` - List of step numbers that have been completed
  - `form` - Phoenix form struct for form handling
  - `form_data` - Map containing form data for review step display
  - `target` - Phoenix LiveView target for handling step navigation events
  - `title` - Main title displayed at the top of the wizard
  - `subtitle` - Subtitle text displayed below the main title
  - `class` - Additional CSS classes for the wizard container

  ## Step Configuration

  Each step in the `steps` list should be a map with:
  - `number` - Step number (integer, 1-based)
  - `title` - Display title for the step
  - `component` - LiveComponent module to render for this step
  - `id` - Unique identifier for the step
  - `type` - Optional type atom, use `:review` for review steps

  ## Events

  The component expects the target to handle these events:
  - `"next_step"` - Move to the next step
  - `"previous_step"` - Move to the previous step
  - Form submission on the final step
  """
  def wizard_forms(assigns) do
    current_step_config = find_current_step(assigns.steps, assigns.current_step)
    total_steps = length(assigns.steps)

    assigns =
      assigns
      |> assign(:current_step_config, current_step_config)
      |> assign(:total_steps, total_steps)

    ~H"""
    <div class={["max-w-full mx-auto p-6", @class]}>
      <.wizard_header title={@title} subtitle={@subtitle} />

      <.step_indicator
        current_step={@current_step}
        total_steps={@total_steps}
        completed_steps={@completed_steps}
        steps={@steps}
      />

      <.step_container>
        <.step_content
          current_step_config={@current_step_config}
          form={@form}
          form_data={@form_data}
        />

        <.step_navigation
          current_step={@current_step}
          total_steps={@total_steps}
          target={@target}
        />
      </.step_container>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :subtitle, :string, required: true

  defp wizard_header(assigns) do
    ~H"""
    <div class="text-center mb-8">
      <h1 class="text-3xl font-bold text-gray-900 mb-2">{@title}</h1>
      <p class="text-gray-600">{@subtitle}</p>
    </div>
    """
  end

  slot :inner_block, required: true

  defp step_container(assigns) do
    ~H"""
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
      <div class="p-8">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  attr :current_step_config, :map
  attr :form, :any, required: true
  attr :form_data, :map, required: true

  defp step_content(assigns) do
    ~H"""
    <div class="min-h-[400px] mb-8">
      <%= if @current_step_config do %>
        <%= if is_review_step?(@current_step_config) do %>
          <%= if Map.has_key?(@current_step_config, :component) do %>
            <.live_component
              module={@current_step_config.component}
              id={@current_step_config.id}
              form={@form}
              form_data={@form_data}
            />
          <% else %>
            <.review_step form_data={@form_data} form={@form} />
          <% end %>
        <% else %>
          <.live_component
            module={@current_step_config.component}
            id={@current_step_config.id}
            form={@form}
          />
        <% end %>
      <% else %>
        <.step_not_found />
      <% end %>
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, required: true
  attr :completed_steps, :list, required: true
  attr :steps, :list, required: true

  defp step_indicator(assigns) do
    ~H"""
    <div class="mb-8">
      <div class="flex items-center justify-between">
        <%= for step <- @steps do %>
          <.step_indicator_item
            step={step}
            current_step={@current_step}
            completed_steps={@completed_steps}
          />

          <%= if step.number < @total_steps do %>
            <.step_connector is_completed={
              step_completed?(step.number, @current_step, @completed_steps)
            } />
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  attr :step, :map, required: true
  attr :current_step, :integer, required: true
  attr :completed_steps, :list, required: true

  defp step_indicator_item(assigns) do
    step_state =
      get_step_state(assigns.step.number, assigns.current_step, assigns.completed_steps)

    assigns = assign(assigns, :step_state, step_state)

    ~H"""
    <div class="flex flex-col items-center flex-1">
      <div class={step_indicator_classes(@step_state)}>
        <%= if @step_state == :completed do %>
          <.check_icon />
        <% else %>
          {@step.number}
        <% end %>
      </div>
      <div class="mt-2 text-xs text-center text-gray-600 font-medium">
        {@step.title}
      </div>
    </div>
    """
  end

  attr :is_completed, :boolean, required: true

  defp step_connector(assigns) do
    ~H"""
    <div class={[
      "flex-1 h-1 mx-2 rounded transition-all duration-200",
      if(@is_completed, do: "bg-green-500", else: "bg-gray-200")
    ]}>
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, required: true
  attr :target, :any, required: true

  defp step_navigation(assigns) do
    ~H"""
    <div class="flex items-center justify-between pt-6 border-t border-gray-100">
      <.previous_button current_step={@current_step} target={@target} />
      <.next_button current_step={@current_step} total_steps={@total_steps} target={@target} />
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :target, :any, required: true

  defp previous_button(assigns) do
    ~H"""
    <div>
      <%= if @current_step > 1 do %>
        <button
          type="button"
          phx-click="previous_step"
          phx-target={@target}
          class={previous_button_classes()}
        >
          <.arrow_left_icon /> Previous
        </button>
      <% end %>
    </div>
    """
  end

  attr :current_step, :integer, required: true
  attr :total_steps, :integer, required: true
  attr :target, :any, required: true

  defp next_button(assigns) do
    ~H"""
    <div class="flex items-center gap-3">
      <%= if @current_step < @total_steps do %>
        <button
          type="button"
          phx-click="next_step"
          phx-target={@target}
          class={next_button_classes()}
        >
          Next <.arrow_right_icon />
        </button>
      <% else %>
        <button
          type="submit"
          phx-target={@target}
          class={submit_button_classes()}
        >
          <.check_icon /> Submit Registration
        </button>
      <% end %>
    </div>
    """
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
        <.review_section title="Personal Information">
          <.review_field label="Name" value="[Review data here]" />
          <.review_field label="CPF" value="[Review data here]" />
          <.review_field label="Birth Date" value="[Review data here]" />
        </.review_section>

        <.review_section title="Company Information">
          <.review_field label="Company" value="[Review data here]" />
          <.review_field label="CNPJ" value="[Review data here]" />
          <.review_field label="Email" value="[Review data here]" />
        </.review_section>
      </div>
    </div>
    """
  end

  attr :title, :string, required: true
  slot :inner_block, required: true

  defp review_section(assigns) do
    ~H"""
    <div class="bg-gray-50 rounded-xl p-6">
      <h4 class="font-semibold text-gray-900 mb-4">{@title}</h4>
      <div class="space-y-2 text-sm text-gray-600">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  attr :label, :string, required: true
  attr :value, :string, required: true

  defp review_field(assigns) do
    ~H"""
    <p>
      <span class="font-medium">{@label}:</span>
      {@value}
    </p>
    """
  end

  defp step_not_found(assigns) do
    ~H"""
    <div class="text-center py-12">
      <div class="text-gray-400 mb-4">
        <svg class="w-16 h-16 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="1"
            d="M9.172 16.172a4 4 0 015.656 0M9 12h6m-6-4h6m2 5.291A7.962 7.962 0 0112 15c-2.34 0-4.469.795-6.172 2.127M12 3v12"
          />
        </svg>
      </div>
      <h3 class="text-lg font-medium text-gray-900 mb-2">Step Not Found</h3>
      <p class="text-gray-600">The requested step could not be loaded.</p>
    </div>
    """
  end

  defp check_icon(assigns) do
    ~H"""
    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
      <path
        fill-rule="evenodd"
        d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
        clip-rule="evenodd"
      />
    </svg>
    """
  end

  defp arrow_left_icon(assigns) do
    ~H"""
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
    </svg>
    """
  end

  defp arrow_right_icon(assigns) do
    ~H"""
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
    </svg>
    """
  end

  defp find_current_step(steps, current_step) do
    Enum.find(steps, &(&1.number == current_step))
  end

  defp is_review_step?(%{type: :review}), do: true
  defp is_review_step?(_), do: false

  defp get_step_state(step_number, current_step, completed_steps) do
    cond do
      step_number < current_step or step_number in completed_steps -> :completed
      step_number == current_step -> :current
      true -> :pending
    end
  end

  defp step_completed?(step_number, current_step, completed_steps) do
    step_number < current_step or step_number in completed_steps
  end

  defp step_indicator_classes(step_state) do
    base_classes =
      "w-10 h-10 rounded-full flex items-center justify-center text-sm font-medium transition-all duration-200"

    state_classes =
      case step_state do
        :completed -> "bg-green-500 text-white shadow-green-200 shadow-lg"
        :current -> "bg-blue-500 text-white shadow-blue-200 shadow-lg"
        :pending -> "bg-gray-200 text-gray-600"
      end

    [base_classes, state_classes]
  end

  defp previous_button_classes do
    "inline-flex items-center gap-2 px-6 py-3 text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 rounded-xl border border-gray-200 transition-all duration-200 hover:shadow-sm"
  end

  defp next_button_classes do
    "inline-flex items-center gap-2 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg transition-all duration-200 transform hover:scale-105"
  end

  defp submit_button_classes do
    "inline-flex items-center gap-2 bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg transition-all duration-200 transform hover:scale-105"
  end
end
