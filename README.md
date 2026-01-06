# trashpanda-postgres

A custom PostgreSQL Docker image with pre-installed extensions, designed for deployment on Railway and other Docker platforms.

## Extensions Included

- **pgvector** - Vector similarity search
- **pg_cron** - Job scheduler for PostgreSQL
- **pg_uuidv7** - UUID v7 generation

## Quick Start

### Build the Image

```bash
docker build -t trashpanda-postgres .
```

### Run Locally

```bash
docker run -d \
  --name postgres-dev \
  -e POSTGRES_PASSWORD=your_password \
  -e POSTGRES_DB=your_database \
  -p 5432:5432 \
  trashpanda-postgres
```

### Deploy to Railway

1. Connect your repository to Railway
2. Railway will automatically detect the Dockerfile and build the image
3. Set your environment variables in Railway dashboard:
   - `POSTGRES_PASSWORD`
   - `POSTGRES_DB` (optional)
   - `POSTGRES_USER` (optional, defaults to 'postgres')
   - `PGDATA` (optional, for custom data directory)

### Deploy to Other Platforms

This image is platform-agnostic and can be deployed to:
- Railway
- Render
- Fly.io
- Google Cloud Run
- AWS ECS/Fargate
- Any Docker-compatible platform

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | Database password | Required |
| `POSTGRES_DB` | Database name | postgres |
| `POSTGRES_USER` | Database user | postgres |
| `PGDATA` | PostgreSQL data directory | /var/lib/postgresql/data |

## Extensions Usage

After deployment, connect to your database and enable extensions:

```sql
-- Enable vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Enable pg_cron extension  
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Enable UUID v7 extension
CREATE EXTENSION IF NOT EXISTS pg_uuidv7;
```