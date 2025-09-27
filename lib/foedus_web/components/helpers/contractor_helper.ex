defmodule FoedusWeb.Helpers.ContractorHelper do
  @moduledoc """
  Helper module for contractor-related formatting and utility functions.
  """

  @doc """
  Returns the appropriate title for the information section based on contractor type.
  """
  def information_section_title(contractor) do
    case contractor.entity_type do
      :company -> "Company Information"
      :individual -> "Personal Information"
      _ -> "Contractor Information"
    end
  end

  @doc """
  Checks if a value is blank (nil or empty string).
  """
  def is_blank?(value) when is_nil(value) or value == "", do: true
  def is_blank?(_), do: false

  @doc """
  Returns a formatted display value, showing "-" for blank values.
  """
  def display_value(value) when is_nil(value) or value == "", do: "-"
  def display_value(value), do: value

  @doc """
  Formats a date to a human-readable string.

  ## Examples
      iex> format_date(~D[2024-01-15])
      "January 15, 2024"

      iex> format_date(nil)
      "-"
  """
  def format_date(nil), do: "-"

  def format_date(date) do
    case Date.from_iso8601(to_string(date)) do
      {:ok, parsed_date} -> Calendar.strftime(parsed_date, "%B %d, %Y")
      _ -> Calendar.strftime(date, "%B %d, %Y")
    end
  rescue
    _ -> "-"
  end

  @doc """
  Formats a CNPJ string with proper Brazilian formatting.

  ## Examples
      iex> format_cnpj("12345678000195")
      "12.345.678/0001-95"

      iex> format_cnpj(nil)
      "-"
  """
  def format_cnpj(nil), do: "-"

  def format_cnpj(cnpj) when is_binary(cnpj) and byte_size(cnpj) == 14 do
    "#{String.slice(cnpj, 0, 2)}.#{String.slice(cnpj, 2, 3)}.#{String.slice(cnpj, 5, 3)}/#{String.slice(cnpj, 8, 4)}-#{String.slice(cnpj, 12, 2)}"
  end

  def format_cnpj(cnpj), do: cnpj || "-"

  @doc """
  Formats a CPF document string with proper Brazilian formatting.

  ## Examples
      iex> format_document("12345678901")
      "123.456.789-01"

      iex> format_document(nil)
      "-"
  """
  def format_document(nil), do: "-"

  def format_document(doc) when is_binary(doc) and byte_size(doc) == 11 do
    "#{String.slice(doc, 0, 3)}.#{String.slice(doc, 3, 3)}.#{String.slice(doc, 6, 3)}-#{String.slice(doc, 9, 2)}"
  end

  def format_document(doc), do: doc || "-"

  @doc """
  Formats a phone number with Brazilian formatting.

  ## Examples
      iex> format_phone("11999999999")
      "(11) 99999-9999"

      iex> format_phone("1199999999")
      "(11) 9999-9999"

      iex> format_phone(nil)
      "-"
  """
  def format_phone(nil), do: "-"

  def format_phone(phone) when is_binary(phone) do
    cleaned = String.replace(phone, ~r/[^\d]/, "")

    case String.length(cleaned) do
      11 ->
        "(#{String.slice(cleaned, 0, 2)}) #{String.slice(cleaned, 2, 5)}-#{String.slice(cleaned, 7, 4)}"

      10 ->
        "(#{String.slice(cleaned, 0, 2)}) #{String.slice(cleaned, 2, 4)}-#{String.slice(cleaned, 6, 4)}"

      _ ->
        phone
    end
  end

  def format_phone(phone), do: phone || "-"

  @doc """
  Converts company type atoms to human-readable strings.

  ## Examples
      iex> humanize_company_type(:ltda)
      "Ltda"

      iex> humanize_company_type(:sa)
      "S/A"

      iex> humanize_company_type(nil)
      "-"
  """
  def humanize_company_type(nil), do: "-"

  def humanize_company_type(type) do
    case type do
      :ltda -> "Ltda"
      :sa -> "S/A"
      :mei -> "MEI"
      :eireli -> "EIRELI"
      _ -> type |> to_string() |> String.upcase()
    end
  end
end
