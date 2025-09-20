defmodule Foedus.RepresentativeFactory do
  alias Foedus.Contractors.Representative

  defmacro __using__(_opts) do
    quote do
      def representative_factory do
        %Representative{
          role: Enum.random([:legal, :autorizado]),
          first_name: Faker.Person.first_name(),
          last_name: Faker.Person.last_name(),
          document: Faker.format("###.###.###-##"),
          birth_date: Faker.Date.date_of_birth(18..80),
          email: Faker.Internet.email(),
          phone: Faker.format("(##) #####-####"),
        }
      end
    end
  end
end
