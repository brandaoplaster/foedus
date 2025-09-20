# Foedus

A modern contract management system built with Phoenix LiveView, designed to streamline contract creation, clause management, and client-company relationships.

*Foedus* - from Latin meaning "treaty" or "alliance", perfectly embodying the essence of contract management and business agreements.

## Features

- **Contract Management**: Create, edit, and manage contracts with dynamic clause building
- **Client & Company Management**: Maintain detailed records of clients and companies
- **Real-time Interface**: Built with Phoenix LiveView for interactive user experience
- **UUID-based IDs**: Uses binary IDs for enhanced security and scalability
- **PostgreSQL Database**: Robust data storage with full ACID compliance

## Tech Stack

- **Phoenix Framework** - Web framework
- **Phoenix LiveView** - Real-time, interactive web interface
- **PostgreSQL** - Primary database
- **Docker & Docker Compose** - Containerized development environment
- **Elixir** - Programming language

## Prerequisites

- Docker and Docker Compose installed
- Git

## Getting Started

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd foedus
```

### 2. Environment Setup

Create a `.env` file in the project root:

```bash
# User permissions for file generation
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# PostgreSQL Database Configuration
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=foedus_dev
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# Phoenix Configuration
SECRET_KEY_BASE=your_secret_key_base_here
PHX_HOST=localhost
PHX_PORT=4000
DATABASE_URL=ecto://postgres:postgres@db:5432/foedus_dev

```

**Important**: Replace `your_secret_key_base_here` with a real secret key (see step 3).

### 3. Generate Secret Key

Generate a secret key for the application:

```bash
# If you have Elixir installed locally
mix phx.gen.secret

# Or use OpenSSL
openssl rand -base64 64
```

Update the `SECRET_KEY_BASE` in the `.env` file with the generated key.

### 4. Build and Start Services

```bash
# Build the application with proper user permissions
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
docker compose build

# Start all services
docker compose up -d
```

### 5. Setup Database

```bash
# Create the database
docker compose run --rm app mix ecto.create

# Run migrations (when you have them)
docker compose run --rm app mix ecto.migrate
```

### 6. Access the Application

Open your browser and navigate to: `http://localhost:4000`

## Development Commands

### Running Migrations

```bash
# Create a new migration
docker compose run --rm app mix ecto.gen.migration create_contracts

# Run pending migrations
docker compose run --rm app mix ecto.migrate

# Rollback last migration
docker compose run --rm app mix ecto.rollback
```

### Code Quality & Linting

```bash
# Run Credo for code analysis
docker compose run --rm app mix credo

# Run Credo with strict mode (more detailed analysis)
docker compose run --rm app mix credo --strict
```

### Database Priming

```bash
# Run default
docker compose run --rm app mix db.prime

# Clean database
docker compose run --rm app mix db.prime --clean

# Run prime with flags
docker compose run --rm app mix db.prime --users 5 --contractors 3 --templates 2
```

### Generating Phoenix Resources

```bash
# Generate a LiveView resource
docker compose run --rm app mix phx.gen.live Contracts Contract contracts title:string content:text status:string client_id:binary_id company_id:binary_id

# Generate a schema only
docker compose run --rm app mix phx.gen.schema Client clients name:string email:string phone:string
```

### Managing Dependencies

```bash
# Install new dependencies
docker compose run --rm app mix deps.get

# Update dependencies
docker compose run --rm app mix deps.update --all
```

### Database Operations

```bash
# Reset database (drop, create, migrate)
docker compose run --rm app mix ecto.reset

# Drop database
docker compose run --rm app mix ecto.drop

# Check migration status
docker compose run --rm app mix ecto.migrations
```

## Docker Services

The application runs with the following services:

- **app**: Phoenix application (port 4000)
- **db**: PostgreSQL database (port 5432)
- **redis**: Redis cache (port 6379) - Optional

### Useful Docker Commands

```bash
# View application logs
docker compose logs -f app

# View all service logs
docker compose logs -f

# Access application shell
docker compose exec app sh

# Access PostgreSQL
docker compose exec db psql -U postgres -d foedus_dev

# Stop all services
docker compose down

# Stop and remove volumes
docker compose down -v

# Rebuild services
docker compose up --build
```

## Project Structure

```
foedus/
├── assets/          # Static assets (CSS, JS)
├── config/          # Application configuration
├── lib/
│   ├── foedus/      # Business logic and contexts
│   └── foedus_web/  # Web-related code (controllers, views, etc.)
├── priv/
│   └── repo/        # Database migrations and seeds
├── test/            # Test files
├── docker compose.yml
├── Dockerfile
└── mix.exs          # Project dependencies and configuration
```

## Configuration

### Database Configuration

The database connection is configured in `config/dev.exs`. For Docker environment, the connection string is set via environment variables in `docker compose.yml`.

### Environment Variables

Key environment variables used:

- `DATABASE_URL`: PostgreSQL connection string
- `SECRET_KEY_BASE`: Secret key for sessions and cookies
- `PHX_HOST`: Phoenix host (default: localhost)
- `PHX_PORT`: Phoenix port (default: 4000)

## File Permissions

The Docker setup is configured to use your host user ID to prevent permission issues when generating files. If you encounter permission problems:

```bash
# Fix file permissions
sudo chown -R $USER:$USER .
```

## Troubleshooting

### Database Connection Issues

1. Ensure PostgreSQL service is running:
   ```bash
   docker compose ps db
   ```

2. Check database logs:
   ```bash
   docker compose logs db
   ```

### Application Won't Start

1. Check application logs:
   ```bash
   docker compose logs app
   ```

2. Verify dependencies are installed:
   ```bash
   docker compose run --rm app mix deps.get
   ```

### Permission Issues

1. Rebuild with correct user permissions:
   ```bash
   export USER_ID=$(id -u)
   export GROUP_ID=$(id -g)
   docker compose build --no-cache
   ```

## License

This project is licensed under the MIT License - see the LICENSE file for details.