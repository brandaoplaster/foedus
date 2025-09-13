defmodule FoedusWeb.ContractorsLive.FormComponent do
  use FoedusWeb, :live_component

  import FoedusWeb.Components.UI.WizardForms

  alias Foedus.Contractors
  alias FoedusWeb.ContractorLive.{
    AddressComponent,
    CompanyInfoComponent,
    PersonalInfoComponent,
    RepresentativesComponent
  }

  def render(assigns) do
    ~H"""
    <div>
      <.wizard_forms
        current_step={@current_step}
        steps={@steps}
        completed_steps={@completed_steps}
        form={@form}
        form_data={@form_data}
        target={@myself}
        title={@title}
        subtitle={@subtitle}
        class="max-w-4xl"
      />
    </div>
    """
  end

  def mount(socket) do
    steps = [
      %{
        number: 1,
        title: "Personal Info",
        component: PersonalInfoComponent,
        id: "personal_info",
        type: :form
      },
      %{
        number: 2,
        title: "Company Info",
        component: CompanyInfoComponent,
        id: "company_info",
        type: :form
      },
      %{number: 3, title: "Address", component: AddressComponent, id: "address", type: :form},
      %{
        number: 4,
        title: "Representatives",
        component: RepresentativesComponent,
        id: "Representatives",
        type: :form
      },
      %{number: 5, title: "Review", component: nil, id: "review", type: :review}
    ]

    socket =
      socket
      |> assign(:current_step, 1)
      |> assign(:steps, steps)
      |> assign(:completed_steps, [])
      |> assign(:form_data, %{})
      |> assign(:title, "Registration Wizard")
      |> assign(:subtitle, "Complete all steps to register")

    {:ok, socket}
  end

  def handle_event("next_step", _params, socket) do
    current_step = socket.assigns.current_step
    total_steps = length(socket.assigns.steps)

    if current_step < total_steps do
      completed_steps = [current_step | socket.assigns.completed_steps] |> Enum.uniq()

      socket =
        socket
        |> assign(:current_step, current_step + 1)
        |> assign(:completed_steps, completed_steps)

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("previous_step", _params, socket) do
    current_step = socket.assigns.current_step

    if current_step > 1 do
      socket = assign(socket, :current_step, current_step - 1)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("validate", form_params, socket) do
    socket =
      socket
      |> assign(:form_data, Map.merge(socket.assigns.form_data, form_params))

    {:noreply, socket}
  end

  def handle_event("save", %{"form_data" => form_params}, socket) do
    case Contractors.create_contractor(form_params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Registration completed successfully!")
         |> push_navigate(to: ~p"/contract")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
