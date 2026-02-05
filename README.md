# ramptools

An R package providing utility functions and reference data for working with health information systems databases, particularly DHIS2 (District Health Information System 2) data from Uganda.

## Overview

`ramptools` simplifies working with versioned health data by providing:

- **Database utilities** for managing and querying versioned SQLite databases
- **Period handling** for DHIS2 temporal data formats (weekly/monthly)
- **Reference datasets** for Uganda's administrative geography and health indicators
- **Data transformation** utilities for working with health information data

## Key Features

### Database Management

- `get_latest_version()` - Retrieve the most recent data version from a database
- `get_version_metadata()` - Access metadata for specific data versions
- `get_data()` - Query versioned data with filtering by ID variables and version
- `get_db_diff()` - Identify new or changed data compared to existing database records
- `get_id_vars()` / `get_value_var()` - Discover database schema information

### Period Utilities

- `get_period_range()` - Generate sequences of DHIS2-formatted periods (weekly/monthly)
- `make_week_map()` - Create mappings between ISO weeks and dates
- `make_month_map()` - Create mappings between months and dates

### Output Management

- `get_output_dir()` - Create versioned output directories with standardized naming (YYYY_MM_DD.VV)
- `get_latest_output_date_index()` - Find the latest version index for a given date

### Data Transformation

- `make_human_readable()` - Merge human-readable location and indicator names onto raw DHIS2 data

## Included Datasets

The package includes reference data for Uganda:

### Geographic Data
- `uga_district_shp` - District-level shapefiles
- `uga_subcounty_shp` - Subcounty-level shapefiles  
- `uga_region_shp` - Region-level shapefiles
- `uga_water_shp` - Water body shapefiles

### Reference Tables
- `loc_table` - Location hierarchy with administrative units
- `district_pop` - Population data by district
- `indicator_table` - DHIS2 indicator definitions and metadata
- `age_sex_table` - Age-sex stratification reference data

## Installation

```r
# Install from source
devtools::install_github("yourusername/ramptools")
```

## Dependencies

- data.table
- DBI
- RSQLite
- dplyr

## Use Case

This package is designed for teams working with:
- DHIS2 health information systems data
- Versioned data workflows requiring audit trails
- Uganda health and geographic data analysis
- Time series analysis of health indicators

## License

MIT License
