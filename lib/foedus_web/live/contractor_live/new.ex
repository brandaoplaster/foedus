defmodule FoedusWeb.ContractorLive.New do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.WizardForms

  alias Foedus.Contractors
  alias Foedus.Contractors.Contractor
  alias FoedusWeb.ContractorLive.AddressComponent
  alias FoedusWeb.ContractorLive.PersonalInfoComponent
  alias FoedusWeb.ContractorLive.CompanyInfoComponent
  alias FoedusWeb.ContractorLive.AddressComponent
  alias FoedusWeb.ContractorLive.RepresentativesComponent

  @impl true
  def mount(_params, _session, socket) do
    contractor = %Contractor{}
    changeset = Contractors.change_contractor(contractor)

    steps = [
      %{number: 1, title: "Personal", component: PersonalInfoComponent, id: "personal"},
      %{number: 2, title: "Company", component: CompanyInfoComponent, id: "company"},
      %{
        number: 3,
        title: "Representatives",
        component: RepresentativesComponent,
        id: "representatives"
      },
      %{number: 4, title: "Address", component: AddressComponent, id: "address"},
      %{number: 5, title: "Review", type: :review}
    ]

    {:ok,
     socket
     |> assign(:contractor, %Contractor{})
     |> assign(:form, to_form(changeset))
     |> assign(:steps, steps)
     |> assign(:current_step, 1)
     |> assign(:completed_steps, [])
     |> assign(:form_data, %{})
     |> assign(:live_action, :new)}
  end

  @impl true
  def handle_event("next_step", _params, socket) do
    {:noreply, update(socket, :current_step, &(&1 + 1))}
  end

  @impl true
  def handle_event("previous_step", _params, socket) do
    {:noreply, update(socket, :current_step, &max(&1 - 1, 1))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Contractor")
    |> assign(:contractor, %Contractor{})
  end
end
