defmodule FoedusWeb.Components.UI.Icon do
  use Phoenix.Component

  @icons %{
    "template" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
    ),
    "check" => ~S(
      <path fill-rule="evenodd"
        d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
        clip-rule="evenodd" />
    ),
    "document" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
    ),
    "clock" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
    ),
    "dollar" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1" />
    ),
    "plus" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
    ),
    "chart" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
    ),
    "cog" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
    ),
    "alert" => ~S(
      <path fill-rule="evenodd"
        d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
        clip-rule="evenodd" />
    ),
    "refresh" => ~S(
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
    )
  }

  attr :name, :string, required: true
  attr :class, :string, default: ""

  def icon(assigns) do
    icon_path = Map.get(@icons, assigns.name, @icons["document"])
    assigns = assign(assigns, :icon_path, icon_path)

    ~H"""
    <svg class={@class} fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <%= Phoenix.HTML.raw(@icon_path) %>
    </svg>
    """
  end

  attr :type, :string, required: true
  attr :size, :string, default: "w-8 h-8"

  def activity_icon(assigns) do
    {color_class, icon_name, fill_type} = case assigns.type do
      "success" -> {"bg-green-100 text-green-600", "check", "fill"}
      "info" -> {"bg-blue-100 text-blue-600", "document", "stroke"}
      "warning" -> {"bg-yellow-100 text-yellow-600", "alert", "fill"}
      _ -> {"bg-gray-100 text-gray-600", "document", "stroke"}
    end

    assigns = assign(assigns, color_class: color_class, icon_name: icon_name, fill_type: fill_type)

    ~H"""
    <div class={"#{@size} rounded-full #{@color_class} flex items-center justify-center"}>
      <svg class="h-4 w-4" fill={@fill_type == "fill" && "currentColor" || "none"} stroke="currentColor" viewBox="0 0 20 20">
          <.icon name={@icon_name} class="h-4 w-4" />
      </svg>
    </div>
    """
  end
end
