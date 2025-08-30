defmodule FoedusWeb.Ui.Table do
  use Phoenix.Component
  import FoedusWeb.CoreComponents

  @doc """
  Renders a fully customizable data table
  """
  attr :id, :string, required: true
  attr :rows, :any, required: true
  attr :columns, :list, required: true
  attr :actions, :list, default: []
  attr :resource_path, :string, required: true
  attr :row_click, :any, default: nil
  attr :class, :string, default: ""
  attr :table_class, :string, default: "min-w-full divide-y divide-gray-200"
  attr :thead_class, :string, default: "bg-gradient-to-r from-gray-50 to-gray-100"
  attr :tbody_class, :string, default: "bg-white divide-y divide-gray-100"
  attr :th_class, :string, default: "px-6 py-4 text-left text-sm font-semibold text-gray-800 uppercase tracking-wide"
  attr :td_class, :string, default: "px-6 py-4 whitespace-nowrap text-sm text-gray-900"
  attr :empty_message, :string, default: "No data available"
  attr :striped, :boolean, default: false
  attr :hoverable, :boolean, default: true

  def data_table(assigns) do
    ~H"""
    <div class={["overflow-hidden ring-1 ring-black ring-opacity-5 border-gray-100", @class]} id={@id}>
      <table class={@table_class}>
        <thead class={@thead_class}>
          <tr>
            <th :for={column <- @columns} class={@th_class} scope="col">
              <%= get_label(column) %>
            </th>
            <th :if={@actions != []} class={[@th_class, "relative"]} scope="col">
              <span class="sr-only">Actions</span>
            </th>
          </tr>
        </thead>
        <tbody class={@tbody_class}>
          <%= if Enum.empty?(@rows) do %>
            <tr>
              <td colspan={length(@columns) + if(@actions != [], do: 1, else: 0)} class="px-6 py-12 text-center text-sm text-gray-500">
                <%= @empty_message %>
              </td>
            </tr>
          <% else %>
            <tr
              :for={{item, index} <- Enum.with_index(@rows)}
              class={[
                get_row_classes(@striped, @hoverable, index),
                if(@row_click, do: "cursor-pointer", else: "")
              ]}
              {if @row_click, do: [{"phx-click", @row_click}, {"phx-value-id", item.id}], else: []}
            >
              <td :for={column <- @columns} class={@td_class}>
                <%= get_value(item, column) %>
              </td>
              <td :if={@actions != []} class={[@td_class, "text-right font-medium"]}>
                <div class="flex justify-end space-x-4">
                  <%= for action <- @actions do %>
                    <%= render_action(%{
                      item: item,
                      resource_path: @resource_path,
                      type: action
                    }) %>
                  <% end %>
                </div>
              </td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  # Versão mais compacta da tabela
  attr :id, :string, required: true
  attr :rows, :any, required: true
  attr :columns, :list, required: true
  attr :actions, :list, default: []
  attr :resource_path, :string, required: true
  attr :row_click, :any, default: nil
  attr :class, :string, default: ""
  attr :empty_message, :string, default: "No data available"

  def simple_table(assigns) do
    ~H"""
    <div class={["overflow-x-auto", @class]} id={@id}>
      <table class="w-full border-collapse border border-gray-300">
        <thead>
          <tr class="bg-gray-100">
            <th :for={column <- @columns} class="border border-gray-300 px-4 py-2 text-left font-semibold text-gray-700">
              <%= get_label(column) %>
            </th>
            <th :if={@actions != []} class="border border-gray-300 px-4 py-2 text-center font-semibold text-gray-700">
              Actions
            </th>
          </tr>
        </thead>
        <tbody>
          <%= if Enum.empty?(@rows) do %>
            <tr>
              <td colspan={length(@columns) + if(@actions != [], do: 1, else: 0)} class="border border-gray-300 px-4 py-8 text-center text-gray-500">
                <%= @empty_message %>
              </td>
            </tr>
          <% else %>
            <tr
              :for={{item, index} <- Enum.with_index(@rows)}
              class={[
                "hover:bg-gray-50",
                if(rem(index, 2) == 0, do: "bg-white", else: "bg-gray-25"),
                if(@row_click, do: "cursor-pointer", else: "")
              ]}
              {if @row_click, do: [{"phx-click", @row_click}, {"phx-value-id", item.id}], else: []}
            >
              <td :for={column <- @columns} class="border border-gray-300 px-4 py-2">
                <%= get_value(item, column) %>
              </td>
              <td :if={@actions != []} class="border border-gray-300 px-4 py-2 text-center">
                <div class="flex justify-center space-x-2">
                  <%= for action <- @actions do %>
                    <%= render_action(%{
                      item: item,
                      resource_path: @resource_path,
                      type: action
                    }) %>
                  <% end %>
                </div>
              </td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  # Versão com cards para mobile
  attr :id, :string, required: true
  attr :rows, :any, required: true
  attr :columns, :list, required: true
  attr :actions, :list, default: []
  attr :resource_path, :string, required: true
  attr :row_click, :any, default: nil
  attr :class, :string, default: ""
  attr :empty_message, :string, default: "No data available"

  def card_table(assigns) do
    ~H"""
    <div class={@class} id={@id}>
      <!-- Desktop Table -->
      <div class="hidden md:block">
        <.data_table {assigns} />
      </div>

      <!-- Mobile Cards -->
      <div class="md:hidden space-y-4">
        <%= if Enum.empty?(@rows) do %>
          <div class="text-center py-8 text-gray-500">
            <%= @empty_message %>
          </div>
        <% else %>
          <div
            :for={item <- @rows}
            class={[
              "bg-white shadow rounded-lg p-4 border border-gray-200",
              if(@row_click, do: "cursor-pointer hover:shadow-md", else: "")
            ]}
            {if @row_click, do: [{"phx-click", @row_click}, {"phx-value-id", item.id}], else: []}
          >
            <div class="space-y-2">
              <div :for={column <- @columns} class="flex justify-between">
                <span class="text-sm font-medium text-gray-500"><%= get_label(column) %>:</span>
                <span class="text-sm text-gray-900"><%= get_value(item, column) %></span>
              </div>
              <div :if={@actions != []} class="pt-2 border-t border-gray-200">
                <div class="flex justify-end space-x-3">
                  <%= for action <- @actions do %>
                    <%= render_action(%{
                      item: item,
                      resource_path: @resource_path,
                      type: action
                    }) %>
                  <% end %>
                </div>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  # Funções privadas (mantém as suas existentes)
  defp get_value(item, column) when is_map(column) do
    field = Map.get(column, :field) || Map.get(column, "field")
    format_value(Map.get(item, field), Map.get(column, :formatter) || Map.get(column, "formatter"))
  end

  defp get_value(item, field) when is_atom(field) do
    format_value(Map.get(item, field), nil)
  end

  defp format_value(value, :datetime) when not is_nil(value), do: Calendar.strftime(value, "%d/%m/%Y")
  defp format_value(value, :date) when not is_nil(value), do: Calendar.strftime(value, "%d/%m/%Y")
  defp format_value(value, :currency) when is_number(value), do: "R$ #{:erlang.float_to_binary(value / 100, decimals: 2)}"
  defp format_value(value, :boolean) when is_boolean(value) do
    if value, do: "Sim", else: "Não"
  end
  defp format_value(value, :status) do
    case value do
      :active -> {:safe, ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-green-100 text-green-800">Ativo</span>)}
      :inactive -> {:safe, ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-800">Inativo</span>)}
      :pending -> {:safe, ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800">Pendente</span>)}
      _ -> value || "-"
    end
  end
  defp format_value(value, _), do: value || "-"

  defp get_label(%{label: label}), do: label
  defp get_label(%{"label" => label}), do: label
  defp get_label(%{field: field}), do: format_label(field)
  defp get_label(%{"field" => field}), do: format_label(field)
  defp get_label(field) when is_atom(field), do: format_label(field)

  defp format_label(field) when is_atom(field) do
    field
    |> to_string()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  defp get_row_classes(striped, hoverable, index) do
    [
      if(striped && rem(index, 2) == 1, do: "bg-gray-50/50", else: "bg-white"),
      if(hoverable, do: "hover:bg-blue-50 hover:shadow-md transition-all duration-200", else: ""),
      "border-b border-gray-100 last:border-b-0"
    ]
  end

  defp render_action(assigns) do
    ~H"""
    <%= case @type do %>
      <% :show -> %>
        <.link navigate={"#{@resource_path}/#{@item.id}"} class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-blue-100 text-blue-800 hover:bg-blue-200 transition-colors duration-150">
          View
        </.link>
      <% :edit -> %>
        <.link navigate={"#{@resource_path}/#{@item.id}/edit"} class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-indigo-100 text-indigo-800 hover:bg-indigo-200 transition-colors duration-150">
          Edit
        </.link>
      <% :delete -> %>
        <.link
          phx-click="delete"
          phx-value-id={@item.id}
          data-confirm="Are you sure you want to delete this item?"
          class="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-red-100 text-red-800 hover:bg-red-200 transition-colors duration-150"
        >
          Delete
        </.link>
      <% custom_action when is_map(custom_action) -> %>
        <.link
          {Map.get(custom_action, :attrs, [])}
          class={Map.get(custom_action, :class, "inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-gray-100 text-gray-800 hover:bg-gray-200 transition-colors duration-150")}
        >
          <%= Map.get(custom_action, :label, "Action") %>
        </.link>
    <% end %>
    """
  end
end
