defmodule Foedus.ContractsTest do
  use Foedus.DataCase

  alias Foedus.Contracts

  describe "contract_templates" do
    alias Foedus.Contracts.ContractTemplate

    import Foedus.ContractsFixtures

    @invalid_attrs %{title: nil, content: nil}

    test "list_contract_templates/0 returns all contract_templates" do
      contract_template = contract_template_fixture()
      assert Contracts.list_contract_templates() == [contract_template]
    end

    test "get_contract_template!/1 returns the contract_template with given id" do
      contract_template = contract_template_fixture()
      assert Contracts.get_contract_template!(contract_template.id) == contract_template
    end

    test "create_contract_template/1 with valid data creates a contract_template" do
      valid_attrs = %{title: "some title", content: "some content"}

      assert {:ok, %ContractTemplate{} = contract_template} =
               Contracts.create_contract_template(valid_attrs)

      assert contract_template.title == "some title"
      assert contract_template.content == "some content"
    end

    test "create_contract_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contracts.create_contract_template(@invalid_attrs)
    end

    test "update_contract_template/2 with valid data updates the contract_template" do
      contract_template = contract_template_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content"}

      result = Contracts.update_contract_template(contract_template, update_attrs)
      assert {:ok, %ContractTemplate{} = contract_template} = result
      assert contract_template.title == "some updated title"
      assert contract_template.content == "some updated content"
    end

    test "update_contract_template/2 with invalid data returns error changeset" do
      contract_template = contract_template_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Contracts.update_contract_template(contract_template, @invalid_attrs)

      assert contract_template == Contracts.get_contract_template!(contract_template.id)
    end

    test "delete_contract_template/1 deletes the contract_template" do
      contract_template = contract_template_fixture()
      assert {:ok, %ContractTemplate{}} = Contracts.delete_contract_template(contract_template)

      assert_raise Ecto.NoResultsError, fn ->
        Contracts.get_contract_template!(contract_template.id)
      end
    end

    test "change_contract_template/1 returns a contract_template changeset" do
      contract_template = contract_template_fixture()
      assert %Ecto.Changeset{} = Contracts.change_contract_template(contract_template)
    end
  end

  describe "signers" do
    alias Foedus.Contracts.Signer

    import Foedus.ContractsFixtures

    @invalid_attrs %{name: nil, status: nil, role: nil, lastname: nil, email: nil, document: nil, birthdate: nil}

    test "list_signers/0 returns all signers" do
      signer = signer_fixture()
      assert Contracts.list_signers() == [signer]
    end

    test "get_signer!/1 returns the signer with given id" do
      signer = signer_fixture()
      assert Contracts.get_signer!(signer.id) == signer
    end

    test "create_signer/1 with valid data creates a signer" do
      valid_attrs = %{name: "some name", status: true, role: "some role", lastname: "some lastname", email: "some email", document: "some document", birthdate: ~D[2025-10-13]}

      assert {:ok, %Signer{} = signer} = Contracts.create_signer(valid_attrs)
      assert signer.name == "some name"
      assert signer.status == true
      assert signer.role == "some role"
      assert signer.lastname == "some lastname"
      assert signer.email == "some email"
      assert signer.document == "some document"
      assert signer.birthdate == ~D[2025-10-13]
    end

    test "create_signer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contracts.create_signer(@invalid_attrs)
    end

    test "update_signer/2 with valid data updates the signer" do
      signer = signer_fixture()
      update_attrs = %{name: "some updated name", status: false, role: "some updated role", lastname: "some updated lastname", email: "some updated email", document: "some updated document", birthdate: ~D[2025-10-14]}

      assert {:ok, %Signer{} = signer} = Contracts.update_signer(signer, update_attrs)
      assert signer.name == "some updated name"
      assert signer.status == false
      assert signer.role == "some updated role"
      assert signer.lastname == "some updated lastname"
      assert signer.email == "some updated email"
      assert signer.document == "some updated document"
      assert signer.birthdate == ~D[2025-10-14]
    end

    test "update_signer/2 with invalid data returns error changeset" do
      signer = signer_fixture()
      assert {:error, %Ecto.Changeset{}} = Contracts.update_signer(signer, @invalid_attrs)
      assert signer == Contracts.get_signer!(signer.id)
    end

    test "delete_signer/1 deletes the signer" do
      signer = signer_fixture()
      assert {:ok, %Signer{}} = Contracts.delete_signer(signer)
      assert_raise Ecto.NoResultsError, fn -> Contracts.get_signer!(signer.id) end
    end

    test "change_signer/1 returns a signer changeset" do
      signer = signer_fixture()
      assert %Ecto.Changeset{} = Contracts.change_signer(signer)
    end
  end
end
