defmodule FoedusWeb.Components.UI.Table do
  use Phoenix.Component
  alias FoedusWeb.Components.Helpers.{Formatters, StreamHelpers, ActionRenderer}

  @doc """
  Renders a fully customizable data table with Stream support
  """
  attr :id, :string, required: true
  attr :rows, :any, required: true, doc: "Can be a list or a Phoenix.LiveView.Stream"
  attr :columns, :list, required: true
  attr :actions, :list, default: []
  attr :resource_path, :string, required: true
  attr :row_click, :any, default: nil
  attr :class, :string, default: ""
  attr :table_class, :string, default: "min-w-full divide-y divide-gray-200"
  attr :thead_class, :string, default: "bg-gradient-to-r from-gray-50 to-gray-100"
  attr :tbody_class, :string, default: "bg-white divide-y divide-gray-100"

  attr :th_class, :string,
    default: "px-6 py-4 text-left text-sm font-semibold text-gray-800 uppercase tracking-wide"

  attr :td_class, :string, default: "px-6 py-4 whitespace-nowrap text-sm text-gray-900"
  attr :empty_message, :string, default: "No data available"
  attr :striped, :boolean, default: false
  attr :hoverable, :boolean, default: true

  def data_table(assigns) do
    ~H"""
    <div class={["overflow-hidden ring-1 ring-black ring-opacity-5 border-gray-100", @class]} id={@id}>
      <table class={@table_class}>
        <.table_header
          columns={@columns}
          actions={@actions}
          thead_class={@thead_class}
          th_class={@th_class}
        />
        <.table_body {assigns} />
      </table>
    </div>
    """
  end

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
        <.simple_table_header columns={@columns} actions={@actions} />
        <.simple_table_body {assigns} />
      </table>
    </div>
    """
  end

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
      <div class="hidden md:block">
        <.data_table {assigns} />
      </div>
      <div
        class="md:hidden space-y-4"
        phx-update={StreamHelpers.get_update_type(@rows)}
        id={"#{@id}-cards"}
      >
        <.mobile_cards {assigns} />
      </div>
    </div>
    """
  end

  defp table_header(assigns) do
    ~H"""
    <thead class={@thead_class}>
      <tr>
        <th :for={column <- @columns} class={@th_class} scope="col">
          {get_column_label(column)}
        </th>
        <th :if={@actions != []} class={[@th_class, "relative"]} scope="col">
          <span class="sr-only">Actions</span>
        </th>
      </tr>
    </thead>
    """
  end

  defp simple_table_header(assigns) do
    ~H"""
    <thead>
      <tr class="bg-gray-100">
        <th
          :for={column <- @columns}
          class="border border-gray-300 px-4 py-2 text-left font-semibold text-gray-700"
        >
          {get_column_label(column)}
        </th>
        <th
          :if={@actions != []}
          class="border border-gray-300 px-4 py-2 text-center font-semibold text-gray-700"
        >
          Actions
        </th>
      </tr>
    </thead>
    """
  end

  defp table_body(assigns) do
    ~H"""
    <tbody class={@tbody_class} phx-update={StreamHelpers.get_update_type(@rows)} id={"#{@id}-tbody"}>
      <%= if StreamHelpers.empty?(@rows) do %>
        <.empty_row
          id={"#{@id}-empty-row"}
          message={@empty_message}
          columns={@columns}
          actions={@actions}
        />
      <% else %>
        <.table_rows {assigns} />
      <% end %>
    </tbody>
    """
  end

  defp simple_table_body(assigns) do
    ~H"""
    <tbody phx-update={StreamHelpers.get_update_type(@rows)} id={"#{@id}-tbody"}>
      <%= if StreamHelpers.empty?(@rows) do %>
        <.simple_empty_row
          id={"#{@id}-empty-row"}
          message={@empty_message}
          columns={@columns}
          actions={@actions}
        />
      <% else %>
        <.simple_table_rows {assigns} />
      <% end %>
    </tbody>
    """
  end

  defp mobile_cards(assigns) do
    ~H"""
    <%= if StreamHelpers.empty?(@rows) do %>
      <div id={"#{@id}-empty-cards"} class="text-center py-8 text-gray-500">
        {@empty_message}
      </div>
    <% else %>
      <%= for {dom_id, item} <- StreamHelpers.get_items(@rows) do %>
        <.mobile_card
          id={dom_id}
          item={item}
          columns={@columns}
          actions={@actions}
          resource_path={@resource_path}
          row_click={@row_click}
        />
      <% end %>
    <% end %>
    """
  end

  defp table_rows(assigns) do
    ~H"""
    <%= for {dom_id, item} <- StreamHelpers.get_items(@rows), {_, index} <- Enum.with_index([{dom_id, item}]) do %>
      <tr
        id={dom_id}
        class={[
          get_row_classes(@striped, @hoverable, index),
          if(@row_click, do: "cursor-pointer", else: "")
        ]}
        {get_row_attributes(@row_click, item)}
      >
        <td :for={column <- @columns} class={@td_class}>
          {get_column_value(item, column)}
        </td>
        <td :if={@actions != []} class={[@td_class, "text-right font-medium"]}>
          <div class="flex justify-end space-x-4">
            <%= for action <- @actions do %>
              <ActionRenderer.render action={action} item={item} resource_path={@resource_path} />
            <% end %>
          </div>
        </td>
      </tr>
    <% end %>
    """
  end

  defp simple_table_rows(assigns) do
    ~H"""
    <%= for {dom_id, item} <- StreamHelpers.get_items(@rows), {_, index} <- Enum.with_index([{dom_id, item}]) do %>
      <tr
        id={dom_id}
        class={[
          "hover:bg-gray-50",
          if(rem(index, 2) == 0, do: "bg-white", else: "bg-gray-25"),
          if(@row_click, do: "cursor-pointer", else: "")
        ]}
        {get_row_attributes(@row_click, item)}
      >
        <td :for={column <- @columns} class="border border-gray-300 px-4 py-2">
          {get_column_value(item, column)}
        </td>
        <td :if={@actions != []} class="border border-gray-300 px-4 py-2 text-center">
          <div class="flex justify-center space-x-2">
            <%= for action <- @actions do %>
              <ActionRenderer.render action={action} item={item} resource_path={@resource_path} />
            <% end %>
          </div>
        </td>
      </tr>
    <% end %>
    """
  end

  defp mobile_card(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "bg-white shadow rounded-lg p-4 border border-gray-200",
        if(@row_click, do: "cursor-pointer hover:shadow-md", else: "")
      ]}
      {get_row_attributes(@row_click, @item)}
    >
      <div class="space-y-2">
        <div :for={column <- @columns} class="flex justify-between">
          <span class="text-sm font-medium text-gray-500">{get_column_label(column)}:</span>
          <span class="text-sm text-gray-900">{get_column_value(@item, column)}</span>
        </div>
        <div :if={@actions != []} class="pt-2 border-t border-gray-200">
          <div class="flex justify-end space-x-3">
            <%= for action <- @actions do %>
              <ActionRenderer.render action={action} item={@item} resource_path={@resource_path} />
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp empty_row(assigns) do
    ~H"""
    <tr id={@id}>
      <td
        colspan={get_colspan(@columns, @actions)}
        class="px-6 py-12 text-center text-sm text-gray-500"
      >
        {@message}
      </td>
    </tr>
    """
  end

  defp simple_empty_row(assigns) do
    ~H"""
    <tr id={@id}>
      <td
        colspan={get_colspan(@columns, @actions)}
        class="border border-gray-300 px-4 py-8 text-center text-gray-500"
      >
        {@message}
      </td>
    </tr>
    """
  end

  # Helper functions
  defp get_column_value(item, column) when is_map(column) do
    field = Map.get(column, :field) || Map.get(column, "field")
    formatter = Map.get(column, :formatter) || Map.get(column, "formatter")

    item
    |> Map.get(field)
    |> Formatters.format_value(formatter)
  end

  defp get_column_value(item, field) when is_atom(field) do
    item
    |> Map.get(field)
    |> Formatters.format_value(nil)
  end

  defp get_column_label(%{label: label}), do: label
  defp get_column_label(%{"label" => label}), do: label
  defp get_column_label(%{field: field}), do: Formatters.format_label(field)
  defp get_column_label(%{"field" => field}), do: Formatters.format_label(field)
  defp get_column_label(field) when is_atom(field), do: Formatters.format_label(field)

  defp get_row_classes(striped, hoverable, index) do
    [
      if(striped && rem(index, 2) == 1, do: "bg-gray-50/50", else: "bg-white"),
      if(hoverable, do: "hover:bg-blue-50 hover:shadow-md transition-all duration-200", else: ""),
      "border-b border-gray-100 last:border-b-0"
    ]
  end

  defp get_row_attributes(nil, _item), do: []

  defp get_row_attributes(row_click, item) do
    [{"phx-click", row_click}, {"phx-value-id", StreamHelpers.get_item_id(item)}]
  end

  defp get_colspan(columns, actions) do
    length(columns) + if(actions != [], do: 1, else: 0)
  end
end
