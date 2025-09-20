defmodule Foedus.ContractorFactory do
  alias Foedus.Contractors.Contractor

  defmacro __using__(_opts) do
    quote do
      def individual_contractor_factory do
        %Contractor{
          entity_type: 1,
          full_name: Faker.Person.name(),
          document: Faker.format("###.###.###-##"),
          birth_date: Faker.Date.date_of_birth(18..90),
          nationality: "Brasileira",
          mobile_phone: Faker.format("(##) #####-####"),
          email: Faker.Internet.email(),
          phone: Faker.format("(##) #####-####"),
          status: 0,

          notes: Faker.Lorem.paragraph()
        }
      end

      def company_contractor_factory do
        %Contractor{
          entity_type: 0,
          company_name: "#{Faker.Company.name()} LTDA",
          trade_name: Faker.Company.name(),
          cnpj: Faker.format("##.###.###/####-##"),
          company_type: Enum.random(["LTDA", "SA", "EIRELI", "MEI"]),
          email: Faker.Internet.email(),
          phone: Faker.format("(##) #####-####"),
          website: Faker.Internet.url(),
          status: 0,

          notes: Faker.Lorem.paragraph()
        }
      end
    end
  end
end
