defmodule Foedus.Contractors do
  @moduledoc """
  The Contractors context.
  """

  import Ecto.Query, warn: false
  alias Foedus.Repo

  alias Foedus.Contractors.Contractor

  @doc """
  Returns the list of contractors.

  ## Examples

      iex> list_contractors()
      [%Contractor{}, ...]

  """
  def list_contractors do
    Repo.all(Contractor)
  end

  @doc """
  Gets a single contractor.

  Raises `Ecto.NoResultsError` if the Contractor does not exist.

  ## Examples

      iex> get_contractor!(123)
      %Contractor{}

      iex> get_contractor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contractor!(id), do: Repo.get!(Contractor, id)

  @doc """
  Creates a contractor.

  ## Examples

      iex> create_contractor(%{field: value})
      {:ok, %Contractor{}}

      iex> create_contractor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contractor(attrs \\ %{}) do
    %Contractor{}
    |> Contractor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contractor.

  ## Examples

      iex> update_contractor(contractor, %{field: new_value})
      {:ok, %Contractor{}}

      iex> update_contractor(contractor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contractor(%Contractor{} = contractor, attrs) do
    contractor
    |> Contractor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contractor.

  ## Examples

      iex> delete_contractor(contractor)
      {:ok, %Contractor{}}

      iex> delete_contractor(contractor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contractor(%Contractor{} = contractor) do
    Repo.delete(contractor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contractor changes.

  ## Examples

      iex> change_contractor(contractor)
      %Ecto.Changeset{data: %Contractor{}}

  """
  def change_contractor(%Contractor{} = contractor, attrs \\ %{}) do
    Contractor.changeset(contractor, attrs)
  end
end
