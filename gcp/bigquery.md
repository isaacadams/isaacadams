# BigQuery

- query syntax: https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax
   - aggregate functions: https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions
   - conditional expressions: https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions
- rest api: https://cloud.google.com/bigquery/docs/reference/rest
- bq cli tool: https://cloud.google.com/bigquery/docs/reference/bq-cli-reference#bq_load

# Bulk Data Uploads

- parquet: https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-parquet
- json: https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-json
- csv: https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv


# Restoring Deleted Tables

1. What is the name of the deleted dataset and in what region was it located?

name: `my_dataset_v1`\
region: `northamerica-northeast1`

2. Recreate the dataset in the correct region

```bash
bq --location=northamerica-northeast1 mk -d my_dataset_v1
```

3. Collect all the old table names to restore

```sql
SELECT TABLE_NAME, MAX(creation_time)
FROM
  `region-northamerica-northeast1`.INFORMATION_SCHEMA.TABLE_STORAGE_TIMELINE
WHERE
  TABLE_SCHEMA = "my_dataset_v1"
  AND total_rows > 0
  AND table_type != "VIEW"
GROUP BY TABLE_NAME;
```

3. Download the results to a CSV file
4. Save it to `tables.csv` and run `just run`

```bash
# justfile, see https://github.com/casey/just
restore dataset table:
   bq cp {{dataset}}.{{table}}@-3600000 {{dataset}}.{{table}}

run:
   qsv select TABLE_NAME tables.csv | \
      qsv behead | \
      xargs -t -n 1 just restore my_dataset_v1
```

# Discovering Hidden Tables

Tables that begin with `__` are hidden from the console view in bigquery. 

```sql
-- write sql that queries metadata and finds datasets that begin with `__`
```

# Check tables in dataset

1. Get all the table names

```sql
SELECT * FROM __Segment_reverse_etl.__TABLES__
```

```sh
bq ls --format json __segment_reverse_etl | jq '"__segment_reverse_etl." + .[].tableReference.tableId'
```

2. Query the statistics on the tables

> Need to use `xargs` to run `bq show` against the result of the prior command.

```
bq show "__segment_reverse_etl.checkpoints"
bq show "__segment_reverse_etl.checkpoints_cvTtWkgqbE69Noy8K4EB16"
bq show "__segment_reverse_etl.checkpoints_meyuE5u6SMeDeJKnDqRjqS"
bq show "__segment_reverse_etl.records"
bq show "__segment_reverse_etl.records_cvTtWkgqbE69Noy8K4EB16"
bq show "__segment_reverse_etl.records_meyuE5u6SMeDeJKnDqRjqS"
```

## Tools

- `just` (https://github.com/casey/just)
- `qsv` (https://github.com/jqnatividad/qsv)
- `bq` (ships w/ `gcloud`) (https://cloud.google.com/sdk/docs/install)
