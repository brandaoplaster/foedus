defmodule FoedusWeb.Components.UI.Badge do
  use Phoenix.Component

  # Status color mapping
  @status_colors %{
    "pending_approval" => "bg-yellow-100 text-yellow-800",
    "under_review" => "bg-blue-100 text-blue-800",
    "awaiting_signature" => "bg-purple-100 text-purple-800",
    "approved" => "bg-green-100 text-green-800",
    "rejected" => "bg-red-100 text-red-800"
  }

  attr :status, :string, required: true
  attr :label, :string, default: nil
  attr :class, :string, default: ""

  def status_badge(assigns) do
    color_class = Map.get(@status_colors, assigns.status, "bg-gray-100 text-gray-800")
    label = assigns.label || format_status(assigns.status)

    assigns = assign(assigns, color_class: color_class, label: label)

    ~H"""
    <span class={"inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium #{@color_class} #{@class}"}>
      <%= @label %>
    </span>
    """
  end

  # Convert snake_case to readable format
  defp format_status(status) do
    status
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
