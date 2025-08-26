defmodule FoedusWeb.Components.UI.FeaturesPreview do
  use Phoenix.Component

  import FoedusWeb.Components.UI.FeatureCard

  attr :features, :list, required: true
  attr :class, :string, default: ""
  attr :columns, :string, default: "grid-cols-1 md:grid-cols-3"

  def features_preview(assigns) do
    ~H"""
    <div class={["mt-20 grid gap-8 max-w-4xl mx-auto", @columns, @class]}>
      <.feature_card
        :for={feature <- @features}
        icon={feature.icon}
        title={feature.title}
        description={feature.description}
      />
    </div>
    """
  end
end
