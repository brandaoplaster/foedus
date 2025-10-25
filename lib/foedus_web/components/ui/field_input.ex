defmodule FoedusWeb.Components.UI.FieldInput do
  use Phoenix.Component

  attr :field, :any, required: true
  attr :type, :string, default: "text"
  attr :label, :string, required: true
  attr :placeholder, :string, default: nil
  attr :required, :boolean, default: false
  attr :options, :list, default: []
  attr :prompt, :string, default: nil
  attr :class, :string, default: ""

  def field_input(%{type: "select"} = assigns) do
    ~H"""
    <div class={@class}>
      <label for={@field.id} class="block text-sm font-medium text-gray-700 mb-1">
        {@label}<span :if={@required} class="text-red-500">*</span>
      </label>
      <select
        id={@field.id}
        name={@field.name}
        required={@required}
        class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
      >
        <option :if={@prompt} value="">{@prompt}</option>
        <option
          :for={{label, value} <- @options}
          value={value}
          selected={value == @field.value}
        >
          {label}
        </option>
      </select>
      <p :if={@field.errors != []} class="mt-1 text-sm text-red-600">
        {translate_errors(@field.errors)}
      </p>
    </div>
    """
  end

  def field_input(%{type: "checkbox"} = assigns) do
    ~H"""
    <div class={["flex items-center", @class]}>
      <input
        type="checkbox"
        id={@field.id}
        name={@field.name}
        value="true"
        checked={@field.value == true}
        class="h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500"
      />
      <label for={@field.id} class="ml-2 block text-sm text-gray-700">
        {@label}
      </label>
    </div>
    """
  end

  def field_input(%{type: "textarea"} = assigns) do
    ~H"""
    <div class={@class}>
      <label for={@field.id} class="block text-sm font-medium text-gray-700 mb-1">
        {@label}<span :if={@required} class="text-red-500">*</span>
      </label>
      <textarea
        id={@field.id}
        name={@field.name}
        placeholder={@placeholder}
        required={@required}
        rows="4"
        class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
      ><%= @field.value %></textarea>
      <p :if={@field.errors != []} class="mt-1 text-sm text-red-600">
        {translate_errors(@field.errors)}
      </p>
    </div>
    """
  end

  def field_input(assigns) do
    ~H"""
    <div class={@class}>
      <label for={@field.id} class="block text-sm font-medium text-gray-700 mb-1">
        {@label}<span :if={@required} class="text-red-500">*</span>
      </label>
      <input
        type={@type}
        id={@field.id}
        name={@field.name}
        value={@field.value}
        placeholder={@placeholder}
        required={@required}
        class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
      />
      <p :if={@field.errors != []} class="mt-1 text-sm text-red-600">
        {translate_errors(@field.errors)}
      </p>
    </div>
    """
  end

  defp translate_errors(errors) when is_list(errors) do
    Enum.map_join(errors, ", ", fn {msg, _opts} -> msg end)
  end
end
