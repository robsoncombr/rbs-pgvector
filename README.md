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

---

## 📦 Installation

### 1️⃣ Install PostgreSQL and pgvector

Ensure PostgreSQL is installed and activate the `pgvector` extension:

```sh
# Install the pgvector extension
psql -d your_database -c "CREATE EXTENSION IF NOT EXISTS vector;"
```

### 2️⃣ Clone the Repository

```sh
git clone https://github.com/robsoncombr/rbs-pgvector.git
cd rbs-pgvector
```

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
SELECT * FROM embeddings ORDER BY data <=> '[0.1, 0.2, 0.3, ..., 0.9]' LIMIT 5;
```

---

## 📖 Documentation

For full documentation, visit the **[Official GitHub Repository](https://github.com/robsoncombr/rbs-pgvector)**.

---

## 🛠 Contribution

We welcome contributions! To get started:

1. **Fork the repo**: [rbs-pgvector](https://github.com/robsoncombr/rbs-pgvector)
2. **Create a new branch**:
   ```sh
   git checkout -b feature-new-functionality
   ```
3. **Make your changes** and commit:
   ```sh
   git commit -m "Added new feature"
   ```
4. **Push the changes**:
   ```sh
   git push origin feature-new-functionality
   ```
5. **Submit a pull request** 🎉

---

## 📜 License

This project follows a **dual licensing structure**:

- 📂 **`._rbs/`** → Licensed under the terms specified in **[.\_rbs/LICENSE](./_rbs/LICENSE)**.
- 🛠 **`pgvector`** → Maintained under its **original license** as defined in **[LICENSE](LICENSE)**.

For full details, please refer to the respective license files.

---

## 🌟 Support & Community

If you find this project useful, please ⭐ **[star the repository](https://github.com/robsoncombr/rbs-pgvector)** and share your feedback!

---

❤️ **Maintained by [github.com/robsoncombr](https://github.com/robsoncombr)**
