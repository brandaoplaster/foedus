defmodule FoedusWeb.DashboardLive.Index do
  use FoedusWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    case socket.assigns.current_user do
      nil ->
        {:ok, push_navigate(socket, to: ~p"/users/log_in")}

      user ->
        stats = load_contract_stats(user)
        activities = load_recent_activities(user)
        pending_contracts = load_pending_contracts(user)

        socket =
          socket
          |> assign(page_title: "Dashboard - Contract Management")
          |> assign(user: user)
          |> assign(stats: stats)
          |> assign(activities: activities)
          |> assign(pending_contracts: pending_contracts)

        {:ok, socket}
    end
  end

  @impl true
  def handle_event("create_template", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecting to template creation...")}
  end

  def handle_event("view_contracts", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecting to contracts list...")}
  end

  def handle_event("analytics", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecting to analytics...")}
  end

  def handle_event("settings", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecting to settings...")}
  end

  def handle_event("refresh_stats", _params, socket) do
    stats = load_contract_stats(socket.assigns.user)
    activities = load_recent_activities(socket.assigns.user)
    pending_contracts = load_pending_contracts(socket.assigns.user)

    socket =
      socket
      |> assign(stats: stats)
      |> assign(activities: activities)
      |> assign(pending_contracts: pending_contracts)
      |> put_flash(:info, "Dashboard updated!")

    {:noreply, socket}
  end

  def handle_event("approve_contract", %{"id" => contract_id}, socket) do
    {:noreply, put_flash(socket, :info, "Contract #{contract_id} approved successfully!")}
  end

  def handle_event("review_contract", %{"id" => contract_id}, socket) do
    {:noreply, put_flash(socket, :info, "Redirecting to contract #{contract_id} review...")}
  end

  # Private functions
  defp load_contract_stats(_user) do
    %{
      total_templates: 12,
      active_contracts: 45,
      pending_approval: 8,
      monthly_revenue: "$24.8K"
    }
  end

  defp load_recent_activities(_user) do
    [
      %{
        type: "success",
        title: "Service Contract approved",
        description: "Client: Tech Solutions Ltd",
        time: "2 hours ago"
      },
      %{
        type: "info",
        title: "New template created",
        description: "Template: Consulting Agreement",
        time: "4 hours ago"
      },
      %{
        type: "warning",
        title: "Contract awaiting signature",
        description: "Client: Innovative Startup",
        time: "6 hours ago"
      },
      %{
        type: "info",
        title: "Client filled out contract",
        description: "Software Contract - Company XYZ",
        time: "8 hours ago"
      }
    ]
  end

  defp load_pending_contracts(_user) do
    [
      %{
        id: 1,
        client: "ABC Company Ltd",
        template: "Development Contract",
        status: "pending_approval",
        value: "$15,000.00",
        created_at: "2025-08-20"
      },
      %{
        id: 2,
        client: "XYZ Consulting",
        template: "Service Agreement",
        status: "under_review",
        value: "$8,500.00",
        created_at: "2025-08-19"
      },
      %{
        id: 3,
        client: "Tech Start",
        template: "Support Contract",
        status: "awaiting_signature",
        value: "$3,200.00",
        created_at: "2025-08-18"
      }
    ]
  end
end
