defmodule Foedus.PlatformAccessFactory do
  alias Foedus.Accounts.PlatformAccess

  defmacro __using__(_opts) do
    quote do
      def platform_access_factory do
        %PlatformAccess{
          company: build(:company),
          user: build(:user),
          deleted_at: nil
        }
      end
    end
  end
end
