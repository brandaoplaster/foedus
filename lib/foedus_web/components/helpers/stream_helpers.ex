defmodule FoedusWeb.Components.Helpers.StreamHelpers do
  @moduledoc """
  Helper functions for working with Phoenix LiveView Streams and regular lists
  """

  def empty?(%Phoenix.LiveView.LiveStream{inserts: inserts}) when map_size(inserts) == 0, do: true
  def empty?(rows) when is_list(rows), do: Enum.empty?(rows)
  def empty?(_), do: false

  def get_update_type(%Phoenix.LiveView.LiveStream{}), do: "stream"
  def get_update_type(_), do: "replace"

  def get_items(%Phoenix.LiveView.LiveStream{} = stream) do
    # Para streams, retornamos as tuplas {dom_id, item} diretamente
    stream
  end

  def get_items(rows) when is_list(rows) do
    # Para listas, criamos tuplas {dom_id, item} compatíveis
    Enum.map(rows, fn item ->
      dom_id = "#{get_item_id(item)}"
      {dom_id, item}
    end)
  end

  def get_item_id(%{id: id}), do: id

  def get_item_id(item) when is_map(item) do
    Map.get(item, :id) || Map.get(item, "id") || :erlang.phash2(item)
  end

  def get_item_id(item), do: :erlang.phash2(item)
end
