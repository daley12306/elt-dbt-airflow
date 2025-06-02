# 📊 ELT Pipeline with Apache Airflow, dbt, and PostgreSQL

This project demonstrates a full **ELT workflow** using:

* **Apache Airflow** for orchestration
* **PostgreSQL** as source and destination databases
* **dbt (data build tool)** for transformations
* **Docker Compose** for containerized deployment

---

## 🛠️ Technologies

* Apache Airflow `2.9.3`
* dbt `1.4.7`
* PostgreSQL `13`
* Docker Compose
* Python `3.8+`

---

## 🧱 Architecture Overview

![Architecture](architecture.png)

---

## 📂 Project Structure

```
.
├── airflow/
│   ├── dags/
│   │   └── elt_dag.py              # Airflow DAG for ETL + dbt run
│   └── airflow.cfg                 # Airflow config (optional override)
├── custom_postgres/                # dbt project and models
├── elt/
│   ├── elt_script.py               # Python script for data extraction + loading
│   └── Dockerfile                  # Custom Dockerfile for elt
├── logs/                           # dbt logs
├── source_db_init/
│   └── init.sql                    # Initial SQL script for source DB
├── architecture.png                # Visual diagram of ELT pipeline
├── Dockerfile                      # Custom Airflow Dockerfile
├── docker-compose.yml              # Full environment definition
└── README.md                       # This file
```

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/daley12306/elt-dbt-airflow.git
cd elt-dbt-airflow
```

### 2. Create `profiles.yml` for dbt
Create a file at `~/.dbt/profiles.yml` with the following content:

```bash
custom_postgres:
  outputs:
    dev:
      dbname: destination_db
      host: host.docker.internal
      pass: secret
      port: 5434
      schema: public
      threads: 1
      type: postgres
      user: postgres
  target: dev
```

### 3. Update Mount Paths

Before running the project, make sure to update local file paths in elt_dag.py under the DockerOperator mounts:

```bash
Mount(source='your/local/path/custom_postgres', target='/dbt', type='bind'),
Mount(source='your/local/path/.dbt', target='/root/.dbt', type='bind')
```

Replace with your absolute paths depending on your OS (e.g., WSL, macOS, Windows).


### 4. Launch All Services

```bash
docker compose up
```

### 5. Access Airflow UI

* Navigate to: [http://localhost:8080](http://localhost:8080)
* Default credentials:

  * Username: `airflow`
  * Password: `password`

---

## ⚙️ Configuration

### Airflow connections are defined via ENV:

```env
AIRFLOW_CONN_DESTINATION_POSTGRES=postgres://postgres:secret@destination_postgres:5434/destination_db
```

### PostgreSQL credentials:

* User: `postgres`
* Password: `secret`

---

## 🪩 Clean Up

To shut down and remove all containers and volumes:

```bash
docker compose down -v
```

---

## 📌 Notes

* Ensure the `~/.dbt/profiles.yml` file is present and matches the profile name `custom_postgres`.
* All source paths in `docker-compose.yml` and DAG should exist and be correctly mounted.

---

💁‍♀️ This project is inspired by the tutorial on freeCodeCamp:
[Data Engineering Course for Beginners](https://youtu.be/PHsC_t0j1dU?si=6QlHJ4eCFo_1t22Z)
