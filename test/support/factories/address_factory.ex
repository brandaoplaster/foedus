defmodule Foedus.AddressFactory do
  alias Foedus.Contractors.Address

  defmacro __using__(_opts) do
    quote do
      def address_factory do
        %Address{
          address_type: Enum.random([:residential, :commercial, :billing]),
          street: Faker.Address.street_name(),
          number: to_string(Faker.random_between(1, 9999)),
          complement: sequence(:complement, ["Apto 101", "Sala 205", "Bloco A", nil]),
          neighborhood: Faker.Address.secondary_address(),
          city: Faker.Address.city(),
          state: Faker.Address.state(),
          zipcode: Faker.Address.zip_code(),
          country: Faker.Address.country(),
        }
      end
    end
  end
end
