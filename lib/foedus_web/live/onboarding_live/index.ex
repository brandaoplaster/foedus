defmodule FoedusWeb.OnboardingLive.Index do
  use FoedusWeb, :live_view

  import FoedusWeb.Components.UI.WizardForms

  alias Foedus.Accounts
  alias FoedusWeb.OnboardingLive.{CompanyForm, ReviewForm, UserForm}

  @impl true
  def mount(_params, _session, socket) do
    steps = build_steps()

    socket =
      socket
      |> assign(:current_step, 1)
      |> assign(:steps, steps)
      |> assign(:completed_steps, [])
      |> assign(:form_data, %{})
      |> assign(:form, to_form(%{}))
      |> assign(:live_action, :index)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", params, socket) do
    step_data = extract_step_data(params, socket.assigns.current_step)
    socket = update_form_data(socket, socket.assigns.current_step, step_data)

    {:noreply, socket}
  end

  @impl true
  def handle_event("next_step", _params, socket) do
    new_step = socket.assigns.current_step + 1

    socket =
      socket
      |> mark_step_completed(socket.assigns.current_step)
      |> assign(:current_step, new_step)
      |> assign_form_for_step(new_step)

    {:noreply, socket}
  end

  @impl true
  def handle_event("previous_step", _params, socket) do
    new_step = max(socket.assigns.current_step - 1, 1)

    socket =
      socket
      |> assign(:current_step, new_step)
      |> assign_form_for_step(new_step)

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", _params, socket) do
    case Accounts.create_onboarding(socket.assigns.form_data) do
      {:ok, %{company: _company, user: _user, platform_access: _platform_access}} ->
        socket =
          socket
          |> put_flash(:info, "Account created successfully!")
          |> redirect(to: ~p"/users/log_in")

        {:noreply, socket}

      {:error, failed_operation, _failed_value, _changes} ->
        socket =
          socket
          |> put_flash(:error, "Failed to create account. Please check your information.")
          |> assign(:current_step, get_failed_step(failed_operation))

        {:noreply, socket}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.wizard_forms
        current_step={@current_step}
        steps={@steps}
        completed_steps={@completed_steps}
        form={@form}
        form_data={@form_data}
      />
    </div>
    """
  end

  defp get_failed_step(:company), do: 1
  defp get_failed_step(:user), do: 2
  defp get_failed_step(:platform_access), do: 2
  defp get_failed_step(_), do: 1

  defp build_steps do
    [
      %{
        number: 1,
        title: "Company",
        component: CompanyForm,
        id: "company"
      },
      %{
        number: 2,
        title: "User",
        component: UserForm,
        id: "user"
      },
      %{
        number: 3,
        title: "Review",
        component: ReviewForm,
        id: "review",
        type: :review
      }
    ]
  end

  defp extract_step_data(params, 1), do: params["company"] || %{}
  defp extract_step_data(params, 2), do: params["user"] || %{}
  defp extract_step_data(_params, _step), do: %{}

  defp update_form_data(socket, 1, data) do
    form_data = Map.put(socket.assigns.form_data, :company, data)
    assign(socket, :form_data, form_data)
  end

  defp update_form_data(socket, 2, data) do
    form_data = Map.put(socket.assigns.form_data, :user, data)
    assign(socket, :form_data, form_data)
  end

  defp update_form_data(socket, _step, _data), do: socket

  defp mark_step_completed(socket, step) do
    completed = Enum.uniq([step | socket.assigns.completed_steps])
    assign(socket, :completed_steps, completed)
  end

  defp assign_form_for_step(socket, step) do
    form_data = socket.assigns.form_data

    data =
      case step do
        1 -> Map.get(form_data, :company, %{})
        2 -> Map.get(form_data, :user, %{})
        _ -> %{}
      end

    assign(socket, :form, to_form(data))
  end
end
