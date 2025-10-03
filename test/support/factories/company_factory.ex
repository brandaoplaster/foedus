defmodule Foedus.CompanyFactory do
  alias Foedus.Accounts.Company

  defmacro __using__(_opts) do
    quote do
      def company_factory do
        %Company{
          active: true,
          trade_name: Faker.Company.name(),
          cnpj: Faker.format("##.###.###/####-##")
        }
      end
    end
  end
end
