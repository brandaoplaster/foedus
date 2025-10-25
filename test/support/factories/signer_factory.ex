defmodule Foedus.SignerFactory do
  alias Foedus.Contracts.Signer

  defmacro __using__(_opts) do
    quote do
      def signer_factory do
        %Signer{
          role: Enum.random(["witness", "contractee"]),
          name: Faker.Person.first_name(),
          status: Enum.random([true, false]),
          lastname: Faker.Person.last_name(),
          document: Faker.format("###.###.###-##"),
          birthdate: Faker.Date.date_of_birth(18..80),
          email: Faker.Internet.email(),
          company: build(:company)
        }
      end
    end
  end
end
