defmodule Foedus.Contracts do
  @moduledoc """
  The Contracts context.
  """

  import Ecto.Query, warn: false
  alias Foedus.Repo

  alias Foedus.Contracts.ContractTemplate

  @doc """
  Returns the list of contract_templates.

  ## Examples

      iex> list_contract_templates()
      [%ContractTemplate{}, ...]

  """
  def list_contract_templates do
    Repo.all(ContractTemplate)
  end

  @doc """
  Gets a single contract_template.

  Raises `Ecto.NoResultsError` if the Contract template does not exist.

  ## Examples

      iex> get_contract_template!(123)
      %ContractTemplate{}

      iex> get_contract_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contract_template!(id), do: Repo.get!(ContractTemplate, id)

  @doc """
  Creates a contract_template.

  ## Examples

      iex> create_contract_template(%{field: value})
      {:ok, %ContractTemplate{}}

      iex> create_contract_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contract_template(attrs \\ %{}) do
    %ContractTemplate{}
    |> ContractTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contract_template.

  ## Examples

      iex> update_contract_template(contract_template, %{field: new_value})
      {:ok, %ContractTemplate{}}

      iex> update_contract_template(contract_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contract_template(%ContractTemplate{} = contract_template, attrs) do
    contract_template
    |> ContractTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contract_template.

  ## Examples

      iex> delete_contract_template(contract_template)
      {:ok, %ContractTemplate{}}

      iex> delete_contract_template(contract_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contract_template(%ContractTemplate{} = contract_template) do
    Repo.delete(contract_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contract_template changes.

  ## Examples

      iex> change_contract_template(contract_template)
      %Ecto.Changeset{data: %ContractTemplate{}}

  """
  def change_contract_template(%ContractTemplate{} = contract_template, attrs \\ %{}) do
    ContractTemplate.changeset(contract_template, attrs)
  end

  alias Foedus.Contracts.Signer

  @doc """
  Returns the list of signers.

  ## Examples

      iex> list_signers()
      [%Signer{}, ...]

  """
  def list_signers do
    Repo.all(Signer)
  end

  @doc """
  Gets a single signer.

  Raises `Ecto.NoResultsError` if the Signer does not exist.

  ## Examples

      iex> get_signer!(123)
      %Signer{}

      iex> get_signer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_signer!(id), do: Repo.get!(Signer, id)

  @doc """
  Creates a signer.

  ## Examples

      iex> create_signer(%{field: value})
      {:ok, %Signer{}}

      iex> create_signer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signer(attrs \\ %{}) do
    %Signer{}
    |> Signer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signer.

  ## Examples

      iex> update_signer(signer, %{field: new_value})
      {:ok, %Signer{}}

      iex> update_signer(signer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signer(%Signer{} = signer, attrs) do
    signer
    |> Signer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a signer.

  ## Examples

      iex> delete_signer(signer)
      {:ok, %Signer{}}

      iex> delete_signer(signer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signer(%Signer{} = signer) do
    Repo.delete(signer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signer changes.

  ## Examples

      iex> change_signer(signer)
      %Ecto.Changeset{data: %Signer{}}

  """
  def change_signer(%Signer{} = signer, attrs \\ %{}) do
    Signer.changeset(signer, attrs)
  end
end
