defmodule Foedus.ContractorsTest do
  use Foedus.DataCase

  alias Foedus.Contractors

  describe "contractors" do
    alias Foedus.Contractors.Contractor

    import Foedus.ContractorsFixtures

    @invalid_attrs %{entity_type: nil, full_name: nil, cpf: nil, birth_date: nil, nationality: nil, company_name: nil, trade_name: nil, cnpj: nil, company_type: nil, legal_representative_first_name: nil, legal_representative_last_name: nil, legal_representative_cpf: nil, legal_representative_birth_date: nil, legal_representative_email: nil, authorized_representative_first_name: nil, authorized_representative_last_name: nil, authorized_representative_cpf: nil, authorized_representative_birth_date: nil, authorized_representative_email: nil, email: nil, phone: nil, mobile_phone: nil, website: nil, address_street: nil, address_number: nil, address_complement: nil, address_neighborhood: nil, address_city: nil, address_state: nil, address_zipcode: nil, address_country: nil, notes: nil}

    test "list_contractors/0 returns all contractors" do
      contractor = contractor_fixture()
      assert Contractors.list_contractors() == [contractor]
    end

    test "get_contractor!/1 returns the contractor with given id" do
      contractor = contractor_fixture()
      assert Contractors.get_contractor!(contractor.id) == contractor
    end

    test "create_contractor/1 with valid data creates a contractor" do
      valid_attrs = %{entity_type: :individual, full_name: "some full_name", cpf: "some cpf", birth_date: ~D[2025-09-08], nationality: "some nationality", company_name: "some company_name", trade_name: "some trade_name", cnpj: "some cnpj", company_type: "some company_type", legal_representative_first_name: "some legal_representative_first_name", legal_representative_last_name: "some legal_representative_last_name", legal_representative_cpf: "some legal_representative_cpf", legal_representative_birth_date: ~D[2025-09-08], legal_representative_email: "some legal_representative_email", authorized_representative_first_name: "some authorized_representative_first_name", authorized_representative_last_name: "some authorized_representative_last_name", authorized_representative_cpf: "some authorized_representative_cpf", authorized_representative_birth_date: ~D[2025-09-08], authorized_representative_email: "some authorized_representative_email", email: "some email", phone: "some phone", mobile_phone: "some mobile_phone", website: "some website", address_street: "some address_street", address_number: "some address_number", address_complement: "some address_complement", address_neighborhood: "some address_neighborhood", address_city: "some address_city", address_state: "some address_state", address_zipcode: "some address_zipcode", address_country: "some address_country", notes: "some notes"}

      assert {:ok, %Contractor{} = contractor} = Contractors.create_contractor(valid_attrs)
      assert contractor.entity_type == :individual
      assert contractor.full_name == "some full_name"
      assert contractor.cpf == "some cpf"
      assert contractor.birth_date == ~D[2025-09-08]
      assert contractor.nationality == "some nationality"
      assert contractor.company_name == "some company_name"
      assert contractor.trade_name == "some trade_name"
      assert contractor.cnpj == "some cnpj"
      assert contractor.company_type == "some company_type"
      assert contractor.legal_representative_first_name == "some legal_representative_first_name"
      assert contractor.legal_representative_last_name == "some legal_representative_last_name"
      assert contractor.legal_representative_cpf == "some legal_representative_cpf"
      assert contractor.legal_representative_birth_date == ~D[2025-09-08]
      assert contractor.legal_representative_email == "some legal_representative_email"
      assert contractor.authorized_representative_first_name == "some authorized_representative_first_name"
      assert contractor.authorized_representative_last_name == "some authorized_representative_last_name"
      assert contractor.authorized_representative_cpf == "some authorized_representative_cpf"
      assert contractor.authorized_representative_birth_date == ~D[2025-09-08]
      assert contractor.authorized_representative_email == "some authorized_representative_email"
      assert contractor.email == "some email"
      assert contractor.phone == "some phone"
      assert contractor.mobile_phone == "some mobile_phone"
      assert contractor.website == "some website"
      assert contractor.address_street == "some address_street"
      assert contractor.address_number == "some address_number"
      assert contractor.address_complement == "some address_complement"
      assert contractor.address_neighborhood == "some address_neighborhood"
      assert contractor.address_city == "some address_city"
      assert contractor.address_state == "some address_state"
      assert contractor.address_zipcode == "some address_zipcode"
      assert contractor.address_country == "some address_country"
      assert contractor.notes == "some notes"
    end

    test "create_contractor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contractors.create_contractor(@invalid_attrs)
    end

    test "update_contractor/2 with valid data updates the contractor" do
      contractor = contractor_fixture()
      update_attrs = %{entity_type: :company, full_name: "some updated full_name", cpf: "some updated cpf", birth_date: ~D[2025-09-09], nationality: "some updated nationality", company_name: "some updated company_name", trade_name: "some updated trade_name", cnpj: "some updated cnpj", company_type: "some updated company_type", legal_representative_first_name: "some updated legal_representative_first_name", legal_representative_last_name: "some updated legal_representative_last_name", legal_representative_cpf: "some updated legal_representative_cpf", legal_representative_birth_date: ~D[2025-09-09], legal_representative_email: "some updated legal_representative_email", authorized_representative_first_name: "some updated authorized_representative_first_name", authorized_representative_last_name: "some updated authorized_representative_last_name", authorized_representative_cpf: "some updated authorized_representative_cpf", authorized_representative_birth_date: ~D[2025-09-09], authorized_representative_email: "some updated authorized_representative_email", email: "some updated email", phone: "some updated phone", mobile_phone: "some updated mobile_phone", website: "some updated website", address_street: "some updated address_street", address_number: "some updated address_number", address_complement: "some updated address_complement", address_neighborhood: "some updated address_neighborhood", address_city: "some updated address_city", address_state: "some updated address_state", address_zipcode: "some updated address_zipcode", address_country: "some updated address_country", notes: "some updated notes"}

      assert {:ok, %Contractor{} = contractor} = Contractors.update_contractor(contractor, update_attrs)
      assert contractor.entity_type == :company
      assert contractor.full_name == "some updated full_name"
      assert contractor.cpf == "some updated cpf"
      assert contractor.birth_date == ~D[2025-09-09]
      assert contractor.nationality == "some updated nationality"
      assert contractor.company_name == "some updated company_name"
      assert contractor.trade_name == "some updated trade_name"
      assert contractor.cnpj == "some updated cnpj"
      assert contractor.company_type == "some updated company_type"
      assert contractor.legal_representative_first_name == "some updated legal_representative_first_name"
      assert contractor.legal_representative_last_name == "some updated legal_representative_last_name"
      assert contractor.legal_representative_cpf == "some updated legal_representative_cpf"
      assert contractor.legal_representative_birth_date == ~D[2025-09-09]
      assert contractor.legal_representative_email == "some updated legal_representative_email"
      assert contractor.authorized_representative_first_name == "some updated authorized_representative_first_name"
      assert contractor.authorized_representative_last_name == "some updated authorized_representative_last_name"
      assert contractor.authorized_representative_cpf == "some updated authorized_representative_cpf"
      assert contractor.authorized_representative_birth_date == ~D[2025-09-09]
      assert contractor.authorized_representative_email == "some updated authorized_representative_email"
      assert contractor.email == "some updated email"
      assert contractor.phone == "some updated phone"
      assert contractor.mobile_phone == "some updated mobile_phone"
      assert contractor.website == "some updated website"
      assert contractor.address_street == "some updated address_street"
      assert contractor.address_number == "some updated address_number"
      assert contractor.address_complement == "some updated address_complement"
      assert contractor.address_neighborhood == "some updated address_neighborhood"
      assert contractor.address_city == "some updated address_city"
      assert contractor.address_state == "some updated address_state"
      assert contractor.address_zipcode == "some updated address_zipcode"
      assert contractor.address_country == "some updated address_country"
      assert contractor.notes == "some updated notes"
    end

    test "update_contractor/2 with invalid data returns error changeset" do
      contractor = contractor_fixture()
      assert {:error, %Ecto.Changeset{}} = Contractors.update_contractor(contractor, @invalid_attrs)
      assert contractor == Contractors.get_contractor!(contractor.id)
    end

    test "delete_contractor/1 deletes the contractor" do
      contractor = contractor_fixture()
      assert {:ok, %Contractor{}} = Contractors.delete_contractor(contractor)
      assert_raise Ecto.NoResultsError, fn -> Contractors.get_contractor!(contractor.id) end
    end

    test "change_contractor/1 returns a contractor changeset" do
      contractor = contractor_fixture()
      assert %Ecto.Changeset{} = Contractors.change_contractor(contractor)
    end
  end
end
