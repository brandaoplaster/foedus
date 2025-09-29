defmodule FoedusWeb.Components.UI.ContractorInfo do
  use Phoenix.Component

  import FoedusWeb.Components.UI.Card
  alias FoedusWeb.Helpers.ContractorHelper

  @doc """
  Renders contractor information section

  ## Example
      <.contractor_information contractor={@contractor} />
  """
  attr :contractor, :map, required: true

  def contractor_information(assigns) do
    ~H"""
    <div class="bg-white rounded-2xl shadow-sm border border-gray-100">
      <div class="p-6">
        <.card
          title={ContractorHelper.information_section_title(@contractor)}
          icon="user-circle"
          icon_color="blue"
          class="w-full"
        >
          <%= if @contractor.entity_type == :company do %>
            <.company_details contractor={@contractor} />
          <% else %>
            <.individual_details contractor={@contractor} />
          <% end %>

          <.notes_section notes={@contractor.notes} />
        </.card>
      </div>
    </div>
    """
  end

  @doc """
  Renders company information with proper validation

  ## Example
      <.company_details contractor={@contractor} />
  """
  attr :contractor, :map, required: true

  def company_details(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="space-y-4">
        <.info_field
          label="Company Name"
          value={@contractor.company_name}
          class="font-semibold text-gray-900"
          required
        />

        <.info_field
          label="Trade Name"
          value={@contractor.trade_name}
        />

        <.info_field
          label="CNPJ"
          value={ContractorHelper.format_cnpj(@contractor.cnpj)}
          class="font-mono text-sm"
        />

        <.info_field
          label="Company Type"
          value={ContractorHelper.humanize_company_type(@contractor.company_type)}
        />
      </div>

      <div class="space-y-4">
        <.email_field
          label="Email"
          value={@contractor.email}
        />

        <.phone_field
          label="Phone"
          value={ContractorHelper.format_phone(@contractor.phone)}
        />

        <.website_field
          label="Website"
          url={@contractor.website}
        />
      </div>
    </div>
    """
  end

  @doc """
  Renders individual information with proper validation

  ## Example
      <.individual_details contractor={@contractor} />
  """
  attr :contractor, :map, required: true

  def individual_details(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="space-y-4">
        <.info_field
          label="Full Name"
          value={@contractor.full_name}
          class="font-semibold text-gray-900"
          required
        />

        <.info_field
          label="Document"
          value={ContractorHelper.format_document(@contractor.document)}
          class="font-mono text-sm"
        />

        <.date_field
          label="Birth Date"
          date={@contractor.birth_date}
        />

        <.info_field
          label="Nationality"
          value={@contractor.nationality}
        />
      </div>

      <div class="space-y-4">
        <.email_field
          label="Email"
          value={@contractor.email}
        />

        <.phone_field
          label="Mobile Phone"
          value={ContractorHelper.format_phone(@contractor.mobile_phone)}
        />

        <.phone_field
          label="Phone"
          value={ContractorHelper.format_phone(@contractor.phone)}
        />
      </div>
    </div>
    """
  end

  @doc """
  Renders a basic information field with better validation

  ## Example
      <.info_field label="Company Name" value={@company_name} required />
      <.info_field label="CNPJ" value={@cnpj} class="font-mono" />
  """
  attr :label, :string, required: true
  attr :value, :any, default: nil
  attr :class, :string, default: ""
  attr :required, :boolean, default: false

  def info_field(assigns) do
    ~H"""
    <div class="space-y-1">
      <label class="text-sm font-medium text-gray-600 uppercase tracking-wide flex items-center gap-1">
        {@label}
        <%= if @required and ContractorHelper.is_blank?(@value) do %>
          <span class="text-red-500 text-xs">*</span>
        <% end %>
      </label>

      <p class={"text-gray-900 #{@class} #{if ContractorHelper.is_blank?(@value), do: "text-gray-400 italic"}"}>
        {ContractorHelper.display_value(@value)}
      </p>
    </div>
    """
  end

  @doc """
  Renders an email field with mailto link

  ## Example
      <.email_field label="Email" value="user@example.com" />
  """
  attr :label, :string, required: true
  attr :value, :string, default: nil

  def email_field(assigns) do
    ~H"""
    <div class="space-y-1">
      <label class="text-sm font-medium text-gray-600 uppercase tracking-wide">
        {@label}
      </label>

      <%= if ContractorHelper.is_blank?(@value) do %>
        <p class="text-gray-400 italic">-</p>
      <% else %>
        <a
          href={"mailto:#{@value}"}
          class="text-indigo-600 hover:text-indigo-800 transition-colors duration-200"
        >
          {@value}
        </a>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a phone field with tel link

  ## Example
      <.phone_field label="Phone" value="+55 11 99999-9999" />
  """
  attr :label, :string, required: true
  attr :value, :string, default: nil

  def phone_field(assigns) do
    ~H"""
    <div class="space-y-1">
      <label class="text-sm font-medium text-gray-600 uppercase tracking-wide">
        {@label}
      </label>

      <%= if ContractorHelper.is_blank?(@value) do %>
        <p class="text-gray-400 italic">-</p>
      <% else %>
        <a
          href={"tel:#{String.replace(@value, ~r/[^\d+]/, "")}"}
          class="text-indigo-600 hover:text-indigo-800 transition-colors duration-200"
        >
          {@value}
        </a>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a website field with link

  ## Example
      <.website_field label="Website" url="https://example.com" />
  """
  attr :label, :string, required: true
  attr :url, :string, default: nil

  def website_field(assigns) do
    ~H"""
    <div class="space-y-1">
      <label class="text-sm font-medium text-gray-600 uppercase tracking-wide">
        {@label}
      </label>

      <%= if ContractorHelper.is_blank?(@url) do %>
        <p class="text-gray-400 italic">-</p>
      <% else %>
        <a
          href={@url}
          target="_blank"
          rel="noopener noreferrer"
          class="text-indigo-600 hover:text-indigo-800 transition-colors duration-200"
        >
          {@url}
        </a>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a date field with proper formatting

  ## Example
      <.date_field label="Birth Date" date={~D[1990-01-15]} />
  """
  attr :label, :string, required: true
  attr :date, :any, default: nil

  def date_field(assigns) do
    ~H"""
    <div class="space-y-1">
      <label class="text-sm font-medium text-gray-600 uppercase tracking-wide">
        {@label}
      </label>

      <p class="text-gray-900">
        {ContractorHelper.format_date(@date)}
      </p>
    </div>
    """
  end

  @doc """
  Renders notes section with better formatting

  ## Example
      <.notes_section notes="Some important notes here" />
  """
  attr :notes, :string, default: nil

  def notes_section(assigns) do
    ~H"""
    <%= if not ContractorHelper.is_blank?(@notes) do %>
      <div class="mt-6 pt-6 border-t border-gray-200">
        <label class="text-sm font-medium text-gray-600 uppercase tracking-wide">
          Notes
        </label>
        <div class="mt-2 p-3 bg-gray-50 rounded-lg">
          <p class="text-gray-900 whitespace-pre-wrap text-sm leading-relaxed">
            {@notes}
          </p>
        </div>
      </div>
    <% end %>
    """
  end
end
