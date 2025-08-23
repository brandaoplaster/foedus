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
          |> assign(page_title: "Dashboard - Gestão de Contratos")
          |> assign(user: user)
          |> assign(stats: stats)
          |> assign(activities: activities)
          |> assign(pending_contracts: pending_contracts)

        {:ok, socket}
    end
  end

  @impl true
  def handle_event("criar_template", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecionando para criação de template...")}
  end

  def handle_event("ver_contratos", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecionando para lista de contratos...")}
  end

  def handle_event("analises", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecionando para análises...")}
  end

  def handle_event("configuracoes", _params, socket) do
    {:noreply, put_flash(socket, :info, "Redirecionando para configurações...")}
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
      |> put_flash(:info, "Dashboard atualizado!")

    {:noreply, socket}
  end

  def handle_event("aprovar_contrato", %{"id" => contract_id}, socket) do
    {:noreply, put_flash(socket, :info, "Contrato #{contract_id} aprovado com sucesso!")}
  end

  def handle_event("revisar_contrato", %{"id" => contract_id}, socket) do
    {:noreply, put_flash(socket, :info, "Redirecionando para revisão do contrato #{contract_id}...")}
  end

  defp load_contract_stats(_user) do
    %{
      total_templates: 12,
      contratos_ativos: 45,
      pendentes_aprovacao: 8,
      receita_mensal: "R$ 24.8K"
    }
  end

  defp load_recent_activities(_user) do
    [
      %{
        tipo: "success",
        icone: "check",
        titulo: "Contrato de Prestação de Serviços aprovado",
        descricao: "Cliente: Tech Solutions LTDA",
        tempo: "2 horas atrás"
      },
      %{
        tipo: "info",
        icone: "document",
        titulo: "Novo template criado",
        descricao: "Template: Contrato de Consultoria",
        tempo: "4 horas atrás"
      },
      %{
        tipo: "warning",
        icone: "clock",
        titulo: "Contrato aguardando assinatura",
        descricao: "Cliente: Startup Inovadora",
        tempo: "6 horas atrás"
      },
      %{
        tipo: "info",
        icone: "user",
        titulo: "Cliente preencheu contrato",
        descricao: "Contrato de Software - Empresa XYZ",
        tempo: "8 horas atrás"
      }
    ]
  end

  defp load_pending_contracts(_user) do
    [
      %{
        id: 1,
        cliente: "Empresa ABC LTDA",
        template: "Contrato de Desenvolvimento",
        status: "Aguardando Aprovação",
        valor: "R$ 15.000,00",
        data_criacao: "2025-08-20"
      },
      %{
        id: 2,
        cliente: "Consultoria XYZ",
        template: "Prestação de Serviços",
        status: "Em Revisão",
        valor: "R$ 8.500,00",
        data_criacao: "2025-08-19"
      },
      %{
        id: 3,
        cliente: "Tech Start",
        template: "Contrato de Suporte",
        status: "Aguardando Assinatura",
        valor: "R$ 3.200,00",
        data_criacao: "2025-08-18"
      }
    ]
  end
end
