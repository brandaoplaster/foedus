defmodule Foedus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoedusWeb.Telemetry,
      Foedus.Repo,
      {DNSCluster, query: Application.get_env(:foedus, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Foedus.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Foedus.Finch},
      # Start a worker by calling: Foedus.Worker.start_link(arg)
      # {Foedus.Worker, arg},
      # Start to serve requests, typically the last entry
      FoedusWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foedus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoedusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
