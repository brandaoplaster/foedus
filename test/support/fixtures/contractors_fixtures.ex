defmodule Foedus.ContractorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Foedus.Contractors` context.
  """

  @doc """
  Generate a contractor.
  """
  def contractor_fixture(attrs \\ %{}) do
    {:ok, contractor} =
      attrs
      |> Enum.into(%{
        address_city: "some address_city",
        address_complement: "some address_complement",
        address_country: "some address_country",
        address_neighborhood: "some address_neighborhood",
        address_number: "some address_number",
        address_state: "some address_state",
        address_street: "some address_street",
        address_zipcode: "some address_zipcode",
        authorized_representative_birth_date: ~D[2025-09-08],
        authorized_representative_cpf: "some authorized_representative_cpf",
        authorized_representative_email: "some authorized_representative_email",
        authorized_representative_first_name: "some authorized_representative_first_name",
        authorized_representative_last_name: "some authorized_representative_last_name",
        birth_date: ~D[2025-09-08],
        cnpj: "some cnpj",
        company_name: "some company_name",
        company_type: "some company_type",
        cpf: "some cpf",
        email: "some email",
        entity_type: :individual,
        full_name: "some full_name",
        legal_representative_birth_date: ~D[2025-09-08],
        legal_representative_cpf: "some legal_representative_cpf",
        legal_representative_email: "some legal_representative_email",
        legal_representative_first_name: "some legal_representative_first_name",
        legal_representative_last_name: "some legal_representative_last_name",
        mobile_phone: "some mobile_phone",
        nationality: "some nationality",
        notes: "some notes",
        phone: "some phone",
        trade_name: "some trade_name",
        website: "some website"
      })
      |> Foedus.Contractors.create_contractor()

    contractor
  end
end
