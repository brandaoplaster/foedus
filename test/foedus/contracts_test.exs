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
end
