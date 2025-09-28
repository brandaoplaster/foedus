defmodule FoedusWeb.Components.UI.ShowHeader do
  use Phoenix.Component

  import FoedusWeb.Components.UI.Icon
  import FoedusWeb.Components.UI.Button
  @doc """
  Renders a show page header with gradient background and back/edit buttons.

  ## Examples

      <.show_header
        title="John Silva"
        subtitle="ID: 123"
        description="Individual contractor profile and information"
        icon="hero-user"
        back_url={~p"/contractors"}
        edit_url={~p"/contractors/123/edit"}
      />

      <.show_header
        title="Company Name"
        subtitle="ID: 456"
        description="Company contractor details and management"
        icon="hero-building-office"
        gradient_from="emerald-600"
        gradient_to="teal-600"
        back_url={~p"/companies"}
        edit_url={~p"/companies/456/edit"}
        back_text="Back to Companies"
        edit_text="Edit Company"
      />
  """
  attr :title, :string, required: true, doc: "Main title of the header"
  attr :subtitle, :string, default: nil, doc: "Subtitle (e.g. ID, code, etc)"
  attr :description, :string, required: true, doc: "Header description"

  attr :icon, :string,
    default: "hero-user",
    doc: "Heroicon name (e.g. hero-user, hero-building-office, etc)"

  attr :gradient_from, :string, default: "indigo-600", doc: "Gradient start color"
  attr :gradient_to, :string, default: "purple-600", doc: "Gradient end color"
  attr :back_url, :string, required: true, doc: "URL for back button"
  attr :edit_url, :string, required: true, doc: "URL for edit button"
  attr :back_text, :string, default: "Back", doc: "Back button text"
  attr :edit_text, :string, default: "Edit", doc: "Edit button text"
  attr :class, :string, default: "", doc: "Additional CSS classes for the header"

  def show_header(assigns) do
    ~H"""
    <div class={["bg-white rounded-2xl shadow-sm border border-gray-100 mb-6 overflow-hidden", @class]}>
      <div class={"bg-gradient-to-r from-#{@gradient_from} to-#{@gradient_to} px-8 py-6"}>
        <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
          <div class="flex-1">
            <div class="flex items-center gap-3 mb-3">
              <div class="bg-white/20 backdrop-blur-sm rounded-xl p-3">
                <.icon name={@icon} class="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 class="text-2xl sm:text-3xl font-bold text-white">
                  {@title}
                </h1>
                <%= if @subtitle do %>
                  <div class="flex items-center gap-4 mt-1">
                    <span class="text-indigo-100 text-sm">{@subtitle}</span>
                  </div>
                <% end %>
              </div>
            </div>
            <p class="text-indigo-100 text-lg max-w-2xl">
              {@description}
            </p>
          </div>

          <div class="flex items-center gap-3 sm:flex-shrink-0">
            <.link
              navigate={@back_url}
              class="inline-flex items-center justify-center gap-2 bg-white/10 hover:bg-white/20 backdrop-blur-sm text-white font-medium px-4 py-2.5 rounded-xl transition-all duration-200 border border-white/20"
            >
              <.icon name="hero-arrow-uturn-left" class="w-4 h-4" />
              {@back_text}
            </.link>

            <.link patch={@edit_url}
            >
              <.button
                variant="cta_secondary"
                full_width
              class="inline-flex items-center justify-center gap-2 bg-white/10 hover:bg-white/20 backdrop-blur-sm text-white font-medium px-4 py-2.5 rounded-xl transition-all duration-200 border border-white/20">
                <.icon name="hero-pencil-square" class="w-4 h-4" />
                {@edit_text}
              </.button>
            </.link>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
