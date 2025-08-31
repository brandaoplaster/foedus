defmodule FoedusWeb.ContractTemplateLive.FormComponent do
  use FoedusWeb, :live_component
  alias Foedus.Contracts

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full h-full flex flex-col">
      <!-- Header with Gradient -->
      <div class="bg-gradient-to-r from-indigo-600 to-purple-600 px-8 py-6">
        <div class="flex items-center gap-4">
          <div class="bg-white/20 backdrop-blur-sm rounded-xl p-3">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-bold text-white">{@title}</h2>
            <p class="text-indigo-100 mt-1">Create and manage professional contract templates with ease</p>
          </div>
        </div>
      </div>

      <!-- Form Content -->
      <div class="flex-1 p-8 overflow-y-auto">
        <.simple_form
          for={@form}
          id="contract_template-form"
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
          class="space-y-8"
        >
          <!-- Title Field -->
          <div class="space-y-2">
            <div class="flex items-center gap-3 mb-3">
              <div class="bg-blue-50 rounded-lg p-2">
                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z" />
                </svg>
              </div>
              <div>
                <label class="text-lg font-semibold text-gray-900">Template Title</label>
                <p class="text-sm text-gray-500">Give your contract template a descriptive name</p>
              </div>
            </div>
            <.input
              field={@form[:title]}
              type="text"
              placeholder="e.g., Employment Agreement, NDA Template, Service Contract..."
              class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200 text-lg"
            />
          </div>

          <!-- Content Field -->
          <div class="space-y-2">
            <div class="flex items-center gap-3 mb-3">
              <div class="bg-purple-50 rounded-lg p-2">
                <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
              <div class="flex-1">
                <label class="text-lg font-semibold text-gray-900">Template Content</label>
                <p class="text-sm text-gray-500">Write your contract template content with placeholders for customizable fields</p>
              </div>
            </div>

            <!-- Textarea + Preview lado a lado -->
            <div class="grid grid-cols-2 gap-4">
              <!-- Textarea -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Editor</label>
                <.input
                  field={@form[:content]}
                  type="textarea"
                  rows="24"
                  placeholder="Enter your contract template content here..."
                  class="w-full h-[520px] px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200 font-mono text-sm leading-relaxed resize-none"
                  id="template-textarea"
                />
                <div class="mt-1 text-xs text-gray-500">
                  <span id="char-counter">0 characters</span>
                </div>
              </div>

              <!-- Preview -->
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Preview</label>
                <div
                  id="template-preview"
                  class="w-full h-[520px] px-4 py-3 border border-gray-200 rounded-xl bg-gray-50 overflow-auto text-sm leading-relaxed whitespace-pre-wrap"
                >
                  Preview aparecerá aqui conforme você digita...
                </div>
              </div>
            </div>

            <!-- Help Text -->
            <div class="bg-blue-50 rounded-xl p-4 border border-blue-100">
              <div class="flex items-start gap-3">
                <div class="bg-blue-100 rounded-full p-1 mt-0.5">
                  <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <div class="text-sm text-blue-800">
                  <p class="font-medium mb-1">💡 Template Tips:</p>
                  <ul class="space-y-1 text-blue-700">
                    <li>• Use <code class="bg-blue-100 px-1.5 py-0.5 rounded text-xs font-mono">&#123;&#123;VARIABLE_NAME&#125;&#125;</code> for customizable fields</li>
                    <li>• Keep formatting consistent and professional</li>
                    <li>• Include all necessary legal clauses for your jurisdiction</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex items-center justify-between pt-6 border-t border-gray-100">
            <div class="flex items-center gap-3">
              <button type="button" class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-gray-600 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors duration-200">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12" />
                </svg>
                Save as Draft
              </button>
            </div>

            <div class="flex items-center gap-3">
              <button
                type="button"
                phx-click={JS.patch(@patch)}
                class="inline-flex items-center justify-center gap-2 px-6 py-3 text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 rounded-xl border border-gray-200 transition-all duration-200"
              >
                Cancel
              </button>
              <.button
                phx-disable-with="Saving..."
                class="inline-flex items-center justify-center gap-2 bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg transition-all duration-200 transform hover:scale-105"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
                {if @action == :new, do: "Create Template", else: "Update Template"}
              </.button>
            </div>
          </div>
        </.simple_form>
      </div>

      <!-- JavaScript for Character Counter and Preview -->
      <script>
        document.addEventListener('DOMContentLoaded', function() {
          const textarea = document.getElementById('template-textarea');
          const counter = document.getElementById('char-counter');
          const preview = document.getElementById('template-preview');

          if (textarea && counter && preview) {
            function update() {
              // Update counter
              const count = textarea.value.length;
              counter.textContent = `${count.toLocaleString()} characters`;

              // Update preview
              const content = textarea.value || 'Preview aparecerá aqui conforme você digita...';
              preview.textContent = content;
            }

            textarea.addEventListener('input', update);
            update(); // Initial update
          }
        });
      </script>
    </div>
    """
  end

  @impl true
  def update(%{contract_template: contract_template} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Contracts.change_contract_template(contract_template))
     end)}
  end

  @impl true
  def handle_event("validate", %{"contract_template" => contract_template_params}, socket) do
    changeset = Contracts.change_contract_template(socket.assigns.contract_template, contract_template_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"contract_template" => contract_template_params}, socket) do
    save_contract_template(socket, socket.assigns.action, contract_template_params)
  end

  defp save_contract_template(socket, :edit, contract_template_params) do
    case Contracts.update_contract_template(socket.assigns.contract_template, contract_template_params) do
      {:ok, contract_template} ->
        notify_parent({:saved, contract_template})
        {:noreply,
         socket
         |> put_flash(:info, "Contract template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_contract_template(socket, :new, contract_template_params) do
    case Contracts.create_contract_template(contract_template_params) do
      {:ok, contract_template} ->
        notify_parent({:saved, contract_template})
        {:noreply,
         socket
         |> put_flash(:info, "Contract template created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
