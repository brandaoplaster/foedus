defmodule FoedusWeb.UserAuth.UserLoginLive do
  use FoedusWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <div class="w-full max-w-md bg-white shadow-lg rounded-2xl p-8">
        <.header class="text-center mb-8">
          <span class="block text-3xl font-bold text-gray-900">Log in to account</span>
        </.header>

        <.simple_form
          for={@form}
          id="login_form"
          action={~p"/users/log_in"}
          phx-update="ignore"
          class="space-y-6"
        >
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Password" required />

          <:actions>
            <div class="flex items-center justify-between w-full">
              <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
              <.link
                href={~p"/users/reset_password"}
                class="text-sm font-semibold text-indigo-600 hover:underline"
              >
                Forgot your password?
              </.link>
            </div>
          </:actions>

          <:actions>
            <.button
              phx-disable-with="Logging in..."
              class="w-full bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg"
            >
              Log in <span aria-hidden="true">→</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
