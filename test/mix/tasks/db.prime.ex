defmodule Mix.Tasks.Db.Prime do
  @moduledoc """
  Mix task to prime database with random data in development environment.

  ## Usage

      mix db.prime
      mix db.prime --users 20 --contractors 15 --templates 5
      mix db.prime --clean
  """

  use Mix.Task

  alias Foedus.Repo
  alias Foedus.Factory

  @shortdoc "Prime database with random data for development"

  def run(args) do
    unless Mix.env() == :dev do
      Mix.shell().error("This task can only be run in development environment!")
      System.halt(1)
    end

    Mix.Task.run("app.start")

    {opts, _} =
      OptionParser.parse!(args,
        strict: [
          users: :integer,
          contractors: :integer,
          templates: :integer,
          clean: :boolean
        ]
      )

    users_count = opts[:users] || 10
    contractors_count = opts[:contractors] || 10
    templates_count = opts[:templates] || 5
    should_clean = opts[:clean] || false

    Mix.shell().info("Priming Foedus database with random data...")
    Mix.shell().info("  Users: #{users_count}")
    Mix.shell().info("  Contractors: #{contractors_count}")
    Mix.shell().info("  Contract Templates: #{templates_count}")

    if should_clean or Mix.shell().yes?("Clean existing data before priming?") do
      clean_database()
    end

    prime_users(users_count)
    prime_contractors(contractors_count)
    prime_contract_templates(templates_count)

    Mix.shell().info("Database primed successfully!")
  end

  defp clean_database do
    Mix.shell().info("Cleaning existing data...")

    Repo.delete_all(Foedus.Contracts.ContractTemplate)
    Repo.delete_all(Foedus.Contractors.Contractor)
    Repo.delete_all(Foedus.Accounts.User)

    Mix.shell().info("Data cleaned!")
  end

  defp prime_users(count) do
    Mix.shell().info("Creating #{count + 1} users (1 fixed + #{count} random)...")

    # Create fixed user for development
    Factory.insert(:user, %{
      email: "lucas@nomad.com",
      hashed_password: Bcrypt.hash_pwd_salt("lucas123456789")
    })

    # Create random users
    Factory.insert_list(count, :user)

    Mix.shell().info("Created #{count + 1} users (lucas@nomad.com + #{count} random)")
  end

  defp prime_contractors(count) do
    Mix.shell().info("Creating #{count} contractors...")

    # Split between individual (entity_type: 1) and company (entity_type: 0) contractors
    individual_count = div(count, 2)
    company_count = count - individual_count

    # Create individual contractors
    for _i <- 1..individual_count do
      Factory.insert(:individual_contractor)
    end

    # Create company contractors
    for _i <- 1..company_count do
      Factory.insert(:company_contractor)
    end

    Mix.shell().info(
      "Created #{count} contractors (#{individual_count} individuals, #{company_count} companies)"
    )
  end

  defp prime_contract_templates(count) do
    Mix.shell().info("Creating #{count} contract templates...")

    Factory.insert_list(count, :contract_template)

    Mix.shell().info("Created #{count} contract templates")
  end
end
