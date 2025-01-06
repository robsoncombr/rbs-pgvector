# 🎉 Welcome to rbs-pgvector! 🚀✨

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/robsoncombr/rbs-pgvector)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supported-blue?logo=postgresql)](https://www.postgresql.org/)
[![License](https://img.shields.io/github/license/robsoncombr/rbs-pgvector)](LICENSE)

---

## 🔗 Related Repositories

- 🔹 **[pgvector/`pgvector`](https://github.com/pgvector/pgvector)** → Original repository, serving as the upstream for `fk-pgvector`.
- 🔹 **[robsoncombr/`fk-pgvector`](https://github.com/robsoncombr/fk-pgvector)** → A direct fork of `pgvector` without modifications, used as an upstream for this repository.
- 🔹 **[robsoncombr/`rbs-pgvector`](https://github.com/robsoncombr/rbs-pgvector)** → This repository, maintaining self-driven enhancements and improvements.

---

## 🔍 Repository Highlights

### 📂 **Artifacts**

- **`._rbs/`** → 🚀 A dedicated space for project-related files, including a base template for quickly starting `pgvector` with Docker Compose.
- **`README.upstream.md`** → The original `README.md` file from the upstream repository.
- **`README.md`** → This file.

### 🌿 **Branches**

- **`rbs-pgvector/upstream`** → The upstream branch, regularly merged from `robsoncombr/fk-pgvector`.
- **`rbs-pgvector/*`** → All other branches contain custom changes, fixes, or new features, typically committed with the `[rbs]` prefix.

---

## ✨ Features

- 🧠 **Efficient Vector Similarity Search** (L2, Cosine, Inner Product).
- ⚡ **Optimized for Performance** on PostgreSQL.
- 🏗 **Scalable & Production-Ready** with advanced indexing support.
- 🛠 **Seamless Integration** with AI applications and machine learning models.
- 🔍 **Fully Compatible** with `pgvector` and enhanced for better performance.
- 🌍 **Geo Extensions** → Includes PostGIS, pgRouting, and related extensions for geospatial data.

---

## 📦 Installation

### 1️⃣ Install PostgreSQL and pgvector

Ensure PostgreSQL is installed and activate the `pgvector` extension:

````sh
# Install the pgvector extension

# psql -d your_database -c "CREATE EXTENSION IF NOT EXISTS vector;"

### 2️⃣ Clone the Repository

```sh
git clone https://github.com/robsoncombr/rbs-pgvector.git
cd rbs-pgvector
````

### 3️⃣ Set Up the Database

Run schema migrations:

```sh
psql -d your_database -f schema.sql
```

---

## 🚀 Usage Example

### **Storing & Searching Vectors**

```sql
CREATE TABLE embeddings (
id SERIAL PRIMARY KEY,
data VECTOR(1536) -- Example for OpenAI's 1536-dimension embeddings
);

-- Insert a vector
INSERT INTO embeddings (data) VALUES ('[0.1, 0.2, 0.3, ..., 0.9]');

-- Find the closest match using Cosine Similarity
SELECT \* FROM embeddings ORDER BY data <=> '[0.1, 0.2, 0.3, ..., 0.9]' LIMIT 5;
```

---

## 🛠 **Rebuilding pgvector with Geo Extensions**

The `Dockerfile` in this repository rebuilds the `pgvector` image with additional geo extensions, including **PostGIS**, **pgRouting**, and related tools. Here's how it works:

### **Dockerfile Overview**

```dockerfile
ARG PG_MAJOR=17

# Stage 1: Use postgres image to get the apt lists

FROM postgres:$PG_MAJOR AS postgres_lists
ARG PG_MAJOR

# Stage 2: Use pgvector image and copy the apt lists from Stage 1

FROM pgvector/pgvector:0.8.0-pg17

# Copy the apt lists from the postgres image

COPY --from=postgres_lists /var/lib/apt/lists /var/lib/apt/lists

# Install the required packages

RUN apt-get update && \
 apt-mark hold locales && \
 apt-get install -y --no-install-recommends \
 curl \
 wget \
 unzip \
 osm2pgsql \
 osmium-tool \
 postgis \
 postgresql-17-pgrouting && \
 apt-get autoremove -y && \
 apt-mark unhold locales && \
 apt-get clean autoclean && \
 apt-get autoremove --yes && \
 rm -rf /var/lib/{apt,dpkg,cache,log}/
```

### **Key Additions**

- **PostGIS**: For geospatial data support.
- **pgRouting**: For routing and network analysis.
- **osm2pgsql & osmium-tool**: For OpenStreetMap data integration.

---

## 📂 **Initialization Script (`init.sql`)**

The `init.sql` script is used to initialize the database with extensions, tables, and sample data. It is mounted in the `docker-compose.yml` file instead of being copied into the image, allowing for easy customization.

### **Key Features of `init.sql`**

- Enables `pgvector`, `PostGIS`, and `pgRouting` extensions.
- Creates tables for testing vector embeddings and geospatial data.
- Inserts sample data for testing.
- Includes a cleanup block to ensure no stale data is left behind.

### **Mounting in `docker-compose.yml`**

```yaml
services:
pgvector:
image: pgvector
volumes: - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

---

## 📖 **Initialization Analysis**

When the container starts, the `init.sql` script runs and initializes the database. Here's what happens:

1. **Extensions Created**:

   - All required extensions (`vector`, `postgis`, `postgis_topology`, `postgis_raster`, and `pgrouting`) are created successfully.

2. **Tables Created**:

   - Tables for testing (`document_embeddings` and `locations`) are created.

3. **Data Inserted**:

   - Sample data is inserted into both tables:
     - `document_embeddings`: 2 rows inserted.
     - `locations`: 4 rows inserted (including São Paulo, New York, London, and Tokyo).

4. **Indexes Created**:

   - Indexes are created for both tables to optimize performance.

5. **Warnings**:

   - A warning about the `ivfflat` index being created with little data is expected. This is because the table only contains 2 rows of sample data. The index is more effective with larger datasets.

6. **Success Message**:
   - A success message confirms that all extensions, tables, and test data have been initialized successfully.

---

## 📜 License

This project follows a **dual licensing structure**:

- 📂 **`._rbs/`** → Licensed under the terms specified in **[.\_rbs/LICENSE](._rbs/LICENSE)**.
- 🛠 **`pgvector`** → Maintained under its **original license** as defined in **[LICENSE](LICENSE)**.

For full details, please refer to the respective license files.

---

## 🌟 Support & Community

If you find this project useful, please ⭐ **[star the repository](https://github.com/robsoncombr/rbs-pgvector)** and share your feedback!

---

❤️ **Maintained by [github.com/robsoncombr](https://github.com/robsoncombr)**
