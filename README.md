# ramptools

Shared R package for the Uganda **RAMP** (Routine Assessment of Malaria Programs) project. Provides metadata tables, shapefiles, and database utilities used by the ETL pipeline (`uga-etl-facility-data`) and analytics repos (`outbreak`).

## Installation

```r
# install.packages("devtools")
devtools::install_github("dd-harp/ramptools")
```

## Contents

### Data

| Object | Description |
|---|---|
| `loc_table` | Location hierarchy — 11,229 facilities and admin units with parent-child relationships (Uganda → Region → District → DLG → Subcounty → Facility) |
| `health_facility_table` | 8,676 health facilities with ownership, status, coordinates, facility type |
| `indicator_table` | ~100 DHIS2 data element mappings (DHIS ID → code_name, display_name, frequency, dhis_version) |
| `district_pop` | District-level population estimates |
| `age_sex_table` | Age-sex disaggregated indicator definitions |
| `uga_district_shp` | District-level shapefile |
| `uga_subcounty_shp` | Subcounty-level shapefile |
| `uga_region_shp` | Region-level shapefile |
| `uga_water_shp` | Water body geometries |

### Functions

#### SQLite utilities (local/legacy)
- `get_data()` — Read versioned data from a SQLite database
- `get_db_diff()` — Compare new pull against stored DB, return only new/changed rows
- `get_latest_version()` — Get latest version number from DB
- `get_version_metadata()` — Get metadata for a specific version
- `get_id_vars()` / `get_value_var()` — Introspect database schema
- `make_human_readable()` — Join DHIS IDs to human-readable names

#### BigQuery utilities (cloud)
- `bq_connect()` — Create a BigQuery connection
- `bq_get_data()` — Read raw data from BigQuery (with version/filter support)
- `bq_get_clean_data()` — Read clean aggregated data from BigQuery
- `bq_get_db_diff()` — Diff new data against BigQuery
- `bq_get_latest_version()` — Get latest version from BigQuery
- `bq_append_raw_data()` / `bq_append_version_metadata()` — Append to BigQuery
- `bq_write_clean_data()` / `bq_write_imputed_data()` — Overwrite clean outputs
- `bq_init_tables()` — Initialize BigQuery schema

#### Period utilities
- `get_period_range()` — Generate DHIS-formatted period vectors
- `make_week_map()` / `make_month_map()` — Date lookup tables for DHIS periods

#### Output management
- `get_output_dir()` — Create versioned output directories

## BigQuery Setup

The pipeline stores data in Google BigQuery under project `uganda-malaria`, dataset `uga_facility_data`. Tables:

| Table | Description |
|---|---|
| `raw_{frequency}_data` | Append-only versioned raw DHIS pulls |
| `raw_{frequency}_version_metadata` | Provenance metadata per version |
| `clean_{frequency}_data` | Latest clean aggregated data (overwritten each run) |
| `imputed_{frequency}_facility_data` | Facility-level imputed data (overwritten each run) |

To initialize:
```r
library(ramptools)
bq_init_tables(frequency = "both")
```
