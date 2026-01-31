defmodule FoedusWeb.Router do
  use FoedusWeb, :router
  import FoedusWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FoedusWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  if Application.compile_env(:foedus, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FoedusWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", FoedusWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FoedusWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/", HomeLive.Index, :index
      live "/users/log_in", UserAuth.UserLoginLive, :new
      live "/onboarding", OnboardingLive.Index, :index

      live "/users/reset_password", UserAuth.UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserAuth.UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FoedusWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FoedusWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserAuth.UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserAuth.UserSettingsLive, :confirm_email

      live "/dashboard", DashboardLive.Index

      live "/contractors", ContractorLive.Index, :index
      live "/contractors/:id/edit", ContractorLive.Index, :edit
      live "/contractors/:id", ContractorLive.Show, :show

      live "/contract_templates", ContractTemplateLive.Index, :index
      live "/contract_templates/new", ContractTemplateLive.Index, :new
      live "/contract_templates/:id/edit", ContractTemplateLive.Index, :edit
      live "/contract_templates/:id", ContractTemplateLive.Show, :show

      live "/signers", SignerLive.Index, :index
      live "/signers/new", SignerLive.Index, :new
      live "/signers/:id/edit", SignerLive.Index, :edit
      live "/signers/:id", SignerLive.Show, :show
    end
  end

  scope "/", FoedusWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live "/contract", ContractorLive.New, :new

    live_session :current_user,
      on_mount: [{FoedusWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserAuth.UserConfirmationLive, :edit
      live "/users/confirm", UserAuth.UserConfirmationInstructionsLive, :new
    end
  end
end
