defmodule FoedusWeb.Components.Helpers.Formatters do
  @moduledoc """
  Value formatting functions for table cells
  """

  def format_value(value, :datetime) when not is_nil(value),
    do: Calendar.strftime(value, "%d/%m/%Y")

  def format_value(value, :date) when not is_nil(value), do: Calendar.strftime(value, "%d/%m/%Y")

  def format_value(value, :currency) when is_number(value),
    do: "R$ #{:erlang.float_to_binary(value / 100, decimals: 2)}"

  def format_value(value, :boolean) when is_boolean(value) do
    if value, do: "Yes", else: "No"
  end

  def format_value(value, :status) do
    case value do
      :active ->
        {:safe,
         ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-green-100 text-green-800">Ativo</span>)}

      :inactive ->
        {:safe,
         ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-800">Inativo</span>)}

      :pending ->
        {:safe,
         ~s(<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800">Pendente</span>)}

      _ ->
        value || "-"
    end
  end

  def format_value(value, _), do: value || "-"

  def format_label(field) when is_atom(field) do
    field
    |> to_string()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
