# insurgate/pg-replica

This is a simple Docker image for a Postgres replica.

On first run, it will initialize the data directory with `pg_basebackup`.

## Usage

```bash
docker run -d --name pg-replica -e POSTGRES_HOST=primary-postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=mydb -v /path/to/replica/data:/var/lib/postgresql/data insurgate/pg-replica
```
