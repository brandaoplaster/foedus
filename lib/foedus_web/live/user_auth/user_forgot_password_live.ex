defmodule FoedusWeb.UserAuth.UserForgotPasswordLive do
  use FoedusWeb, :live_view

  alias Foedus.Accounts

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <div class="w-full max-w-md bg-white shadow-lg rounded-2xl p-8">
        <.header class="text-center mb-8">
          <span class="block text-3xl font-bold text-gray-900">Forgot your password?</span>
          <:subtitle>
            <span class="text-sm text-gray-500">
              We'll send a password reset link to your inbox
            </span>
          </:subtitle>
        </.header>

        <.simple_form for={@form} id="reset_password_form" phx-submit="send_email" class="space-y-6">
          <.input field={@form[:email]} type="email" placeholder="Email" required />
          <:actions>
            <.button
              phx-disable-with="Sending..."
              class="w-full bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg"
            >
              Send password reset instructions
            </.button>
          </:actions>
        </.simple_form>

        <p class="text-center text-sm mt-6 text-gray-600">
          <span class="mx-2">|</span>
          <.link href={~p"/users/log_in"} class="font-semibold text-indigo-600 hover:underline">
            Log in
          </.link>
        </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
