defmodule FoedusWeb.Components.UI.FormBuilder do
  use Phoenix.Component

  attr :for, :any, required: true
  attr :id, :string, required: true
  attr :action, :string, default: nil
  attr :class, :string, default: ""
  attr :rest, :global, include: ~w(phx-change phx-submit phx-target)
  slot :inner_block, required: true

  def form_builder(assigns) do
    ~H"""
    <div class="flex-1 p-8 overflow-y-auto">
      <.form
        for={@for}
        id={@id}
        action={@action}
        class={["space-y-8", @class]}
        {@rest}
      >
        {render_slot(@inner_block)}
      </.form>
    </div>
    """
  end
end
