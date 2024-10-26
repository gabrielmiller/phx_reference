defmodule Referenceapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ReferenceappWeb.Telemetry,
      Referenceapp.Repo,
      {DNSCluster, query: Application.get_env(:referenceapp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Referenceapp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Referenceapp.Finch},
      # Start a worker by calling: Referenceapp.Worker.start_link(arg)
      # {Referenceapp.Worker, arg},
      # Start to serve requests, typically the last entry
      ReferenceappWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Referenceapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReferenceappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
