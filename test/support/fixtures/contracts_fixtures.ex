defmodule Foedus.ContractsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Foedus.Contracts` context.
  """

  @doc """
  Generate a contract_template.
  """
  def contract_template_fixture(attrs \\ %{}) do
    {:ok, contract_template} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> Foedus.Contracts.create_contract_template()

    contract_template
  end
end
