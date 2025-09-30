defmodule FoedusWeb.Components.UI.HeroSection do
  use Phoenix.Component

  import FoedusWeb.Components.UI.{
    BackgroundPattern,
    BrandLogo,
    HeroContent,
    FeaturesPreview,
    FloatingElements,
    Button
  }

  attr :brand_title, :string, default: "Foedus"
  attr :hero_title, :string, default: "Your platform for"
  attr :hero_highlight, :string, default: "contract management"

  attr :hero_subtitle, :string,
    default:
      "Generate, manage and streamline your contract templates with intelligent automation and seamless workflow integration."

  attr :primary_button_text, :string, default: "Start Creating"
  attr :secondary_button_text, :string, default: "View Templates"
  attr :primary_action, :string, default: nil
  attr :secondary_action, :string, default: nil
  attr :features, :list, default: []

  def hero_section(assigns) do
    default_features = [
      %{
        icon: "lightning",
        title: "Fast",
        description: "Optimized interface for maximum productivity and efficiency."
      },
      %{
        icon: "check_circle",
        title: "Reliable",
        description: "Robust and secure technology for your important data."
      },
      %{
        icon: "heart",
        title: "Intuitive",
        description: "Design crafted to provide the best user experience."
      }
    ]

    features = if Enum.empty?(assigns.features), do: default_features, else: assigns.features
    assigns = assign(assigns, :features, features)

    ~H"""
    <div class="relative overflow-hidden">
      <.background_pattern />

      <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="py-24 md:py-32 lg:py-40">
          <div class="text-center">
            <.brand_logo title={@brand_title} />

            <.hero_content
              title={@hero_title}
              highlight={@hero_highlight}
              subtitle={@hero_subtitle}
            />

            <.button variant="cta_primary" size="lg" phx-click={@primary_action}>
              {@primary_button_text}
            </.button>

            <.button variant="cta_secondary" size="lg" phx-click={@secondary_action}>
              {@secondary_button_text}
            </.button>

            <.features_preview features={@features} />
          </div>
        </div>
      </div>

      <.floating_elements />
    </div>
    """
  end
end
