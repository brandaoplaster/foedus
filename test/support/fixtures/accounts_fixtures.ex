defmodule Foedus.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Foedus.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Foedus.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        active: true,
        cnpj: "some cnpj",
        trade_name: "some trade_name"
      })
      |> Foedus.Accounts.create_company()

    company
  end

  @doc """
  Generate a platform_access.
  """
  def platform_access_fixture(attrs \\ %{}) do
    {:ok, platform_access} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2025-09-30 07:30:00Z],
        login: "some login",
        password: "some password",
        status: true
      })
      |> Foedus.Accounts.create_platform_access()

    platform_access
  end
end
