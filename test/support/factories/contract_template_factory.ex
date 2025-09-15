defmodule Foedus.ContractTemplateFactory do
  alias Foedus.Contracts.ContractTemplate

  defmacro __using__(_opts) do
    quote do
      def contract_template_factory do
        %ContractTemplate{
          title: Faker.Lorem.sentence(2..4),
          content: """
          # #{Faker.Lorem.sentence(3..5)}

          ## Terms and Conditions

          #{Faker.Lorem.paragraph(2..4)}

          ### Payment Terms

          #{Faker.Lorem.paragraph(1..2)}

          **Important:** #{Faker.Lorem.sentence()}

          - #{Faker.Lorem.sentence()}
          - #{Faker.Lorem.sentence()}
          - #{Faker.Lorem.sentence()}

          ---

          #{Faker.Lorem.paragraph()}
          """
        }
      end
    end
  end
end
