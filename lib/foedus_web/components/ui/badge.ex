defmodule FoedusWeb.Components.UI.Badge do
  use Phoenix.Component

  @status_config %{
    :pending_approval => %{
      colors: "bg-yellow-100 text-yellow-800 border-yellow-200",
      label: "Pending Approval"
    },
    :under_review => %{
      colors: "bg-blue-100 text-blue-800 border-blue-200",
      label: "Under Review"
    },
    :awaiting_signature => %{
      colors: "bg-purple-100 text-purple-800 border-purple-200",
      label: "Awaiting Signature"
    },
    :approved => %{
      colors: "bg-green-100 text-green-800 border-green-200",
      label: "Approved"
    },
    :rejected => %{
      colors: "bg-red-100 text-red-800 border-red-200",
      label: "Rejected"
    },
    :active => %{
      colors: "bg-green-100 text-green-800 border-green-200",
      label: "Rejected"
    }
  }

  @default_config %{
    colors: "bg-gray-100 text-gray-800 border-gray-200",
    label: nil
  }

  attr :status, :atom, required: true, doc: "Badge status (e.g: :pending_approval, :approved)"
  attr :label, :string, default: nil, doc: "Custom label to override the default"
  attr :class, :string, default: "", doc: "Additional CSS classes"

  attr :variant, :atom,
    default: :default,
    values: [:default, :outline, :solid],
    doc: "Badge visual variant"

  attr :size, :atom, default: :md, values: [:sm, :md, :lg], doc: "Badge size"
  attr :rest, :global, doc: "Additional HTML attributes"

  @doc """
  Renders a status badge with appropriate colors and labels.

  ## Examples

      <.status_badge status={:approved} />
      <.status_badge status={:pending_approval} label="Custom Label" />
      <.status_badge status={:rejected} variant={:outline} size={:lg} />
  """
  def status_badge(assigns) do
    {color_class, display_label} = get_status_info(assigns.status, assigns.label)
    size_class = get_size_class(assigns.size)
    variant_class = get_variant_class(assigns.variant)

    assigns =
      assign(assigns,
        color_class: color_class,
        display_label: display_label,
        size_class: size_class,
        variant_class: variant_class
      )

    ~H"""
    <span
      class={"inline-flex items-center rounded-full font-medium #{@color_class} #{@size_class} #{@variant_class} #{@class}"}
      {@rest}
    >
      {@display_label}
    </span>
    """
  end

  defp get_status_info(status, custom_label) do
    case Map.get(@status_config, status) do
      %{colors: colors, label: default_label} ->
        label = custom_label || default_label
        {colors, label}

      _ ->
        label = custom_label || format_status(status)
        {@default_config.colors, label}
    end
  end

  defp get_size_class(:sm), do: "px-2 py-0.5 text-xs"
  defp get_size_class(:md), do: "px-2.5 py-0.5 text-xs"
  defp get_size_class(:lg), do: "px-3 py-1 text-sm"

  defp get_variant_class(:default), do: "border"
  defp get_variant_class(:outline), do: "border-2 bg-transparent"
  defp get_variant_class(:solid), do: "border-0"

  defp format_status(status) do
    status
    |> Atom.to_string()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
