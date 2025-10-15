defmodule FoedusWeb.Components.UI.SignerDetails do
  use Phoenix.Component
  import FoedusWeb.Components.UI.Icon

  attr :signer, :map, required: true

  def signer_details(assigns) do
    ~H"""
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
      <div class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <.detail_field label="First Name" value={@signer.name} />
          <.detail_field label="Last Name" value={@signer.lastname} />

          <div>
            <label class="text-xs font-medium text-gray-500 uppercase tracking-wide block mb-2">
              Email Address
            </label>
            <div class="flex items-center gap-2">
              <.icon name="hero-envelope" class="w-4 h-4 text-gray-400" />
              <a
                href={"mailto:#{@signer.email}"}
                class="text-blue-600 hover:text-blue-700 font-medium"
              >
                {@signer.email}
              </a>
            </div>
          </div>

          <.detail_field_with_icon
            label="Birth Date"
            icon="hero-cake"
            value={format_date(@signer.birthdate)}
          />

          <.detail_field_with_icon
            label="Document"
            icon="hero-identification"
            value={format_document(@signer.document)}
          />

          <div>
            <label class="text-xs font-medium text-gray-500 uppercase tracking-wide block mb-2">
              Role
            </label>
            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-700">
              {@signer.role}
            </span>
          </div>

          <div>
            <label class="text-xs font-medium text-gray-500 uppercase tracking-wide block mb-2">
              Status
            </label>
            <span class={[
              "inline-flex items-center px-3 py-1 rounded-full text-sm font-medium",
              status_badge_class(@signer.status)
            ]}>
              {status_label(@signer.status)}
            </span>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr :label, :string, required: true
  attr :value, :string, required: true

  defp detail_field(assigns) do
    ~H"""
    <div>
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wide block mb-2">
        {@label}
      </label>
      <p class="text-gray-900 font-medium">{@value}</p>
    </div>
    """
  end

  attr :label, :string, required: true
  attr :icon, :string, required: true
  attr :value, :string, required: true

  defp detail_field_with_icon(assigns) do
    ~H"""
    <div>
      <label class="text-xs font-medium text-gray-500 uppercase tracking-wide block mb-2">
        {@label}
      </label>
      <div class="flex items-center gap-2">
        <.icon name={@icon} class="w-4 h-4 text-gray-400" />
        <p class="text-gray-900 font-medium">{@value}</p>
      </div>
    </div>
    """
  end

  defp status_label(true), do: "Active"
  defp status_label(false), do: "Inactive"
  defp status_label(_), do: "Inactive"

  defp status_badge_class(true), do: "bg-green-100 text-green-700"
  defp status_badge_class(false), do: "bg-gray-100 text-gray-700"
  defp status_badge_class(_), do: "bg-gray-100 text-gray-700"

  defp format_document(document) when is_binary(document) do
    document
    |> String.replace(~r/[^\d]/, "")
    |> case do
      <<a::binary-size(3), b::binary-size(3), c::binary-size(3), d::binary-size(2)>> ->
        "#{a}.#{b}.#{c}-#{d}"

      <<a::binary-size(2), b::binary-size(3), c::binary-size(3), d::binary-size(4),
        e::binary-size(2)>> ->
        "#{a}.#{b}.#{c}/#{d}-#{e}"

      doc ->
        doc
    end
  end

  defp format_document(nil), do: "N/A"

  defp format_date(%Date{} = date), do: Calendar.strftime(date, "%d/%m/%Y")
  defp format_date(nil), do: "N/A"
  defp format_date(_), do: "N/A"
end
