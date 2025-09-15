defmodule Foedus.ContractorFactory do
  alias Foedus.Contractors.Contractor

  defmacro __using__(_opts) do
    quote do
      def individual_contractor_factory do
        %Contractor{
          entity_type: 1,
          full_name: Faker.Person.name(),
          cpf: Faker.format("###.###.###-##"),
          birth_date: Faker.Date.date_of_birth(18..65),
          nationality: "Brasileira",
          mobile_phone: Faker.format("(##) #####-####"),
          email: Faker.Internet.email(),
          phone: Faker.format("(##) #####-####"),
          legal_representative_first_name: Faker.Person.first_name(),
          legal_representative_last_name: Faker.Person.last_name(),
          legal_representative_cpf: Faker.format("###.###.###-##"),
          legal_representative_birth_date: Faker.Date.date_of_birth(25..70),
          legal_representative_email: Faker.Internet.email(),
          authorized_representative_first_name: Faker.Person.first_name(),
          authorized_representative_last_name: Faker.Person.last_name(),
          authorized_representative_cpf: Faker.format("###.###.###-##"),
          authorized_representative_birth_date: Faker.Date.date_of_birth(25..70),
          authorized_representative_email: Faker.Internet.email(),
          address_street: Faker.Address.street_name(),
          address_number: to_string(Faker.random_between(1, 9999)),
          address_complement: Faker.Address.secondary_address(),
          address_neighborhood: Faker.Address.city(),
          address_city: Faker.Address.city(),
          address_state: Faker.Address.state(),
          address_zipcode: Faker.Address.zip_code(),
          address_country: "Brasil",
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
          legal_representative_first_name: Faker.Person.first_name(),
          legal_representative_last_name: Faker.Person.last_name(),
          legal_representative_cpf: Faker.format("###.###.###-##"),
          legal_representative_birth_date: Faker.Date.date_of_birth(25..70),
          legal_representative_email: Faker.Internet.email(),
          authorized_representative_first_name: Faker.Person.first_name(),
          authorized_representative_last_name: Faker.Person.last_name(),
          authorized_representative_cpf: Faker.format("###.###.###-##"),
          authorized_representative_birth_date: Faker.Date.date_of_birth(25..70),
          authorized_representative_email: Faker.Internet.email(),
          address_street: Faker.Address.street_name(),
          address_number: to_string(Faker.random_between(1, 9999)),
          address_complement: Faker.Address.secondary_address(),
          address_neighborhood: Faker.Address.city(),
          address_city: Faker.Address.city(),
          address_state: Faker.Address.state(),
          address_zipcode: Faker.Address.zip_code(),
          address_country: "Brasil",
          notes: Faker.Lorem.paragraph()
        }
      end
    end
  end
end
