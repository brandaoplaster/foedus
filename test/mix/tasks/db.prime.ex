defmodule Mix.Tasks.Db.Prime do
  @moduledoc """
  Mix task to prime database with random data in development environment.

  ## Usage
      mix db.prime
      mix db.prime --users 20 --contractors 15 --templates 5
      mix db.prime --clean --verbose

  ## Options
      --users N              Number of random users to create (default: 10)
      --contractors N        Number of contractors to create (default: 10)
      --templates N          Number of contract templates to create (default: 5)
      --clean               Clean existing data before priming
      --verbose             Show detailed progress information

  ## Business Rules
      - Each contractor gets exactly 2 addresses (different types)
      - Company contractors get 2-3 representatives with different roles
      - Individual contractors don't have representatives
  """

  use Mix.Task

  alias Foedus.Accounts.User
  alias Foedus.Contractors.{Contractor, Address, Representative}
  alias Foedus.Contracts.ContractTemplate
  alias Foedus.Factory
  alias Foedus.Repo

  @shortdoc "Prime database with random data for development"

  # Constants
  @batch_size 100
  @default_users 10
  @default_contractors 10
  @default_templates 5
  @address_types [:residential, :commercial, :billing]
  @representative_roles %{
    two: [:legal, :autorizado],
    three: [:legal, :autorizado, :autorizado]
  }

  # Configuration struct
  defmodule Config do
    @enforce_keys [:users_count, :contractors_count, :templates_count]
    defstruct [
      :users_count,
      :contractors_count,
      :templates_count,
      should_clean: false,
      verbose: false
    ]
  end

  def run(args) do
    validate_environment!()
    Mix.Task.run("app.start")

    config = parse_arguments(args)
    print_banner(config)

    if should_clean_database?(config) do
      clean_database(config.verbose)
    end

    prime_database(config)
  end

  # Validation
  defp validate_environment! do
    unless Mix.env() == :dev do
      Mix.shell().error("❌ This task can only be run in development environment!")
      System.halt(1)
    end
  end

  # Configuration parsing
  defp parse_arguments(args) do
    {opts, _} =
      OptionParser.parse!(args,
        strict: [
          users: :integer,
          contractors: :integer,
          templates: :integer,
          clean: :boolean,
          verbose: :boolean
        ]
      )

    %Config{
      users_count: opts[:users] || @default_users,
      contractors_count: opts[:contractors] || @default_contractors,
      templates_count: opts[:templates] || @default_templates,
      should_clean: opts[:clean] || false,
      verbose: opts[:verbose] || false
    }
  end

  defp should_clean_database?(%Config{should_clean: true}), do: true

  defp should_clean_database?(_config) do
    Mix.shell().yes?("🗑️  Clean existing data before priming?")
  end

  # Main orchestration
  defp prime_database(config) do
    with {:ok, user_ids} <- prime_users(config),
         :ok <- prime_contractors(config),
         :ok <- prime_contract_templates(config, user_ids) do
      print_summary()
      Mix.shell().info("✅ Database primed successfully!")
    else
      {:error, reason} ->
        Mix.shell().error("❌ Error during database priming: #{inspect(reason)}")
        System.halt(1)
    end
  end

  # Display functions
  defp print_banner(config) do
    Mix.shell().info("🚀 Priming Foedus database with random data...")
    Mix.shell().info("   Users: #{config.users_count}")
    Mix.shell().info("   Contractors: #{config.contractors_count}")
    Mix.shell().info("   Contract Templates: #{config.templates_count}")
    Mix.shell().info("   📍 Each contractor gets exactly 2 addresses (different types)")
    Mix.shell().info("   👥 Each company gets 2-3 representatives (different roles)")

    if config.verbose do
      Mix.shell().info("   🔍 Verbose mode enabled")
    end

    Mix.shell().info("")
  end

  defp print_summary do
    Mix.shell().info("")
    Mix.shell().info("📊 Summary:")

    summary_data()
    |> Enum.each(fn {schema, name} ->
      count = Repo.aggregate(schema, :count, :id)
      Mix.shell().info("   #{name}: #{count}")
    end)

    Mix.shell().info("")
  end

  defp summary_data do
    [
      {User, "Users"},
      {Contractor, "Contractors"},
      {Address, "Addresses"},
      {Representative, "Representatives"},
      {ContractTemplate, "Contract Templates"}
    ]
  end

  # Database operations
  defp clean_database(verbose) do
    Mix.shell().info("🧹 Cleaning existing data...")

    cleanup_schemas()
    |> Enum.each(&delete_schema_records(&1, verbose))

    Mix.shell().info("✨ Data cleaned!")
  end

  defp cleanup_schemas do
    [
      {Representative, "representatives"},
      {Address, "addresses"},
      {ContractTemplate, "contract_templates"},
      {Contractor, "contractors"},
      {User, "users"}
    ]
  end

  defp delete_schema_records({schema, name}, verbose) do
    count = Repo.delete_all(schema)

    if verbose do
      Mix.shell().info("   Deleted #{count} records from #{name}")
    end
  end

  # User creation
  defp prime_users(config) do
    Mix.shell().info(
      "👥 Creating #{config.users_count + 1} users (1 fixed + #{config.users_count} random)..."
    )

    with {:ok, fixed_user_id} <- create_fixed_user(config.verbose),
         {:ok, random_user_ids} <- create_random_users(config.users_count, config.verbose) do
      user_ids = [fixed_user_id | random_user_ids]
      Mix.shell().info("✅ Created #{config.users_count + 1} users successfully")
      {:ok, user_ids}
    else
      _error -> {:error, :users_creation_failed}
    end
  rescue
    error ->
      Mix.shell().error("❌ Error creating users: #{inspect(error)}")
      {:error, :users_creation_failed}
  end

  defp create_fixed_user(verbose) do
    fixed_user =
      Factory.insert(:user, %{
        email: "lucas@nomad.com",
        hashed_password: Bcrypt.hash_pwd_salt("lucas123456789")
      })

    if verbose do
      Mix.shell().info("   ✓ Created fixed user: lucas@nomad.com")
    end

    {:ok, fixed_user.id}
  end

  defp create_random_users(count, verbose) do
    user_ids =
      for i <- 1..count do
        user = Factory.insert(:user)

        if verbose and rem(i, @batch_size) == 0 do
          Mix.shell().info("   ✓ Created #{i}/#{count} random users")
        end

        user.id
      end

    {:ok, user_ids}
  end

  # Contractor creation
  defp prime_contractors(config) do
    Mix.shell().info(
      "🏢 Creating #{config.contractors_count} contractors with their relationships..."
    )

    {individual_count, company_count} = split_contractor_counts(config.contractors_count)

    with :ok <- create_individual_contractors(individual_count, config.verbose),
         :ok <- create_company_contractors(company_count, config.verbose) do
      Mix.shell().info(
        "✅ Created #{config.contractors_count} contractors (#{individual_count} individuals, #{company_count} companies)"
      )

      :ok
    else
      error -> {:error, :contractors_creation_failed}
    end
  rescue
    error ->
      Mix.shell().error("❌ Error creating contractors: #{inspect(error)}")
      {:error, :contractors_creation_failed}
  end

  defp split_contractor_counts(total_count) do
    individual_count = div(total_count, 2)
    company_count = total_count - individual_count
    {individual_count, company_count}
  end

  defp create_individual_contractors(0, _verbose), do: :ok

  defp create_individual_contractors(count, verbose) do
    if verbose do
      Mix.shell().info("   Creating #{count} individual contractors...")
    end

    for _i <- 1..count do
      contractor = Factory.insert(:individual_contractor)
      create_contractor_addresses(contractor, verbose)

      if verbose do
        Mix.shell().info("   ✓ Created individual contractor: #{contractor.full_name}")
      end

      contractor
    end

    :ok
  end

  defp create_company_contractors(0, _verbose), do: :ok

  defp create_company_contractors(count, verbose) do
    if verbose do
      Mix.shell().info("   Creating #{count} company contractors...")
    end

    for _i <- 1..count do
      contractor = Factory.insert(:company_contractor)
      address_types = create_contractor_addresses(contractor, verbose)
      rep_count = create_contractor_representatives(contractor, verbose)

      if verbose do
        log_company_contractor_creation(contractor, address_types, rep_count)
      end

      contractor
    end

    :ok
  end

  defp create_contractor_addresses(contractor, verbose) do
    selected_types = Enum.take_random(@address_types, 2)

    Enum.map(selected_types, fn type ->
      Factory.insert(:address, contractor: contractor, address_type: type)
    end)

    if verbose do
      Mix.shell().info("     → 2 addresses: #{Enum.join(selected_types, ", ")}")
    end

    selected_types
  end

  defp create_contractor_representatives(contractor, verbose) do
    rep_count = Enum.random([2, 3])
    roles = get_representative_roles(rep_count)

    Enum.map(roles, fn role ->
      Factory.insert(:representative, contractor: contractor, role: role)
    end)

    if verbose do
      rep_details = format_representative_roles(rep_count)
      Mix.shell().info("     → #{rep_count} representatives: #{rep_details}")
    end

    rep_count
  end

  defp get_representative_roles(2), do: @representative_roles.two
  defp get_representative_roles(3), do: @representative_roles.three

  defp format_representative_roles(2), do: "legal + autorizado"
  defp format_representative_roles(3), do: "legal + 2 autorizados"

  defp log_company_contractor_creation(contractor, address_types, rep_count) do
    company_name = contractor.company_name || contractor.trade_name
    Mix.shell().info("   ✓ Created company contractor: #{company_name}")
    Mix.shell().info("     → 2 addresses: #{Enum.join(address_types, ", ")}")

    rep_details = format_representative_roles(rep_count)
    Mix.shell().info("     → #{rep_count} representatives: #{rep_details}")
  end

  # Contract template creation
  defp prime_contract_templates(config, user_ids) do
    Mix.shell().info("📄 Creating #{config.templates_count} contract templates...")

    templates =
      create_contract_templates_with_user_ids(config.templates_count, user_ids, config.verbose)

    if config.verbose do
      log_template_creation(templates)
    end

    Mix.shell().info("✅ Created #{config.templates_count} contract templates")
    :ok
  rescue
    error ->
      Mix.shell().error("❌ Error creating contract templates: #{inspect(error)}")
      {:error, :templates_creation_failed}
  end

  defp create_contract_templates_with_user_ids(count, user_ids, verbose) do
    for i <- 1..count do
      # Cycle through user IDs to distribute templates evenly
      user_id = Enum.at(user_ids, rem(i - 1, length(user_ids)))

      template = Factory.insert(:contract_template, user_id: user_id)

      if verbose do
        template_name = template.name || "Template ##{template.id}"
        Mix.shell().info("   ✓ Created contract template: #{template_name} (user_id: #{user_id})")
      end

      template
    end
  end

  defp log_template_creation(templates) do
    Enum.each(templates, fn template ->
      name = template.name || "Template ##{template.id}"
      Mix.shell().info("   ✓ Created contract template: #{name} (user_id: #{template.user_id})")
    end)
  end

  # Utility functions
  defp create_in_batches(total_count, batch_size, batch_fn) do
    batches = ceil(total_count / batch_size)

    for batch <- 1..batches do
      remaining = min(batch_size, total_count - (batch - 1) * batch_size)

      if remaining > 0 do
        batch_fn.(remaining, batch)
      end
    end
  end
end
