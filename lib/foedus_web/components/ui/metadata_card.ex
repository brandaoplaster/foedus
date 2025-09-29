defmodule FoedusWeb.Components.UI.MetadataCard do
  use Phoenix.Component

  @doc """
  Renders a metadata card containing date information items.

  ## Examples

      <.metadata_card>
        <.date_info_item
          icon="plus"
          title="Created"
          date={@contractor.inserted_at}
          color="green"
        />
        <.date_info_item
          icon="refresh"
          title="Last Updated"
          date={@contractor.updated_at}
          color="blue"
        />
      </.metadata_card>

  """
  attr :class, :string, default: "", doc: "Additional CSS classes"
  slot :inner_block, required: true

  def metadata_card(assigns) do
    ~H"""
    <div class={["bg-white rounded-lg", @class]}>
      <div class="px-1 py-2">
        <div class="space-y-4">
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a date information item with icon and formatted date.

  ## Examples

      <.date_info_item
        icon="plus"
        title="Created"
        date={@contractor.inserted_at}
        color="green"
      />

      <.date_info_item
        icon="refresh"
        title="Last Updated"
        date={@contractor.updated_at}
        color="blue"
      />

  """

  attr :icon, :string, required: true, doc: "Icon type: 'plus', 'refresh', 'calendar', etc."
  attr :title, :string, required: true, doc: "Title to display"
  attr :date, :any, required: true, doc: "DateTime to format and display"
  attr :color, :string, default: "gray", doc: "Color theme: 'green', 'blue', 'gray', etc."
  attr :class, :string, default: "", doc: "Additional CSS classes"

  def date_info_item(assigns) do
    ~H"""
    <div class={["flex items-center gap-3 p-3 bg-gray-50 rounded-lg", @class]}>
      <div class={["rounded-full p-2", icon_background_class(@color)]}>
        <svg
          class={["w-4 h-4", icon_color_class(@color)]}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d={icon_path(@icon)}
          />
        </svg>
      </div>
      <div class="flex-1">
        <p class="text-sm font-medium text-gray-900">{@title}</p>
        <p class="text-sm text-gray-500">
          {Calendar.strftime(@date, "%B %d, %Y")}
        </p>
      </div>
    </div>
    """
  end

  defp icon_path("plus"), do: "M12 6v6m0 0v6m0-6h6m-6 0H6"

  defp icon_path("refresh"),
    do:
      "M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"

  defp icon_path("calendar"),
    do: "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"

  defp icon_path("clock"), do: "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"

  defp icon_path(_), do: "M12 6v6m0 0v6m0-6h6m-6 0H6"

  defp icon_background_class("green"), do: "bg-green-100"
  defp icon_background_class("blue"), do: "bg-blue-100"
  defp icon_background_class("red"), do: "bg-red-100"
  defp icon_background_class("yellow"), do: "bg-yellow-100"
  defp icon_background_class(_), do: "bg-gray-100"

  defp icon_color_class("green"), do: "text-green-600"
  defp icon_color_class("blue"), do: "text-blue-600"
  defp icon_color_class("red"), do: "text-red-600"
  defp icon_color_class("yellow"), do: "text-yellow-600"
  defp icon_color_class(_), do: "text-gray-600"
end
