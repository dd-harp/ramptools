#' Location hierarchy table
#'
#' A list of all health facilities and administrative units, and their parent-child relationships
#' @format A data frame with 11219 rows and 9 columns:
#' \describe{
#'    \item{location_name}{Name of Geographic Entity}
#'    \item{location_id}{DHIS2 assigned ID for geographic entity}
#'    \item{parent_id}{DHIS2 assigned ID of parent geographic entity}
#'    \item{level}{DHIS2 assigned hierarchical level}
#'    \item{path_to_top_parent}{string of DHIS2 IDs from current geographic entity to Uganda as a whole}
#'    \item{region_name}{name of region associated with geographic entity. Blank is entity is region}
#'    \item{district_name}{name of district associated with geographic entity. Blank is entity is district}
#'    \item{DLG_name}{name of DLG (District Level Government) associated with geographic entity. Blank is entity is DLG}
#'    \item{subcounty_name}{name of subcounty associated with geographic entity. Blank is entity is subcounty}
#'    }
"loc_table"

#' Health Facility and Administrative Units Table
#'
#' A comprehensive list of health facilities and administrative hierarchies,
#' including ownership, operational status, and geographic coordinates.
#'
#' @format A data frame with 8676 rows and 22 columns:
#' \describe{
#'   \item{location_name}{Name of Health facility}
#'   \item{location_id}{DHIS2 assigned ID for health facility}
#'   \item{parent_id}{DHIS2 assigned ID of parent health facility (subcounty)}
#'   \item{level}{DHIS2 assigned hierarchical level}
#'   \item{authority}{The governing body or authority responsible for the facility}
#'   \item{facility_level}{The original classification level of the health facility}
#'   \item{medical_bureaus}{The medical bureau affiliation (e.g., UPMB, UCMB)}
#'   \item{operational_status}{Current status of the facility (e.g., Functional, Non-Functional)}
#'   \item{ownership}{Type of ownership (e.g., Public, Private, PNFP)}
#'   \item{private_facilities}{Indicator for private sector classification (PFP, PNFP)}
#'   \item{public_facilities}{Indicator for public sector classification (e.g. MOH,BOU, Local Government)}
#'   \item{reporting_status}{Current status of data reporting compliance}
#'   \item{path_to_top_parent}{String of DHIS2 IDs from current health facility to the top-level parent}
#'   \item{region_name}{Name of region associated with health facility}
#'   \item{district_name}{Name of district associated with health facility}
#'   \item{DLG_name}{Name of District Local Government (DLG) associated with health facility}
#'   \item{subcounty_name}{Name of subcounty associated with health facility}
#'   \item{latitude}{Geographic coordinate: North-South position}
#'   \item{longitude}{Geographic coordinate: East-West position}
#'   \item{geom_enhanced}{Indicator if geometry was added through external web-scraping and not present in DHIS2}
#'   \item{facility_level_2}{Secondary facility level classification (clinic, hospital, drugshop, other)}
#'   \item{facility_type}{Secondary facility label created to match other surveys on health seeking (private, gov_HC, private_hosp, drugshop, gov_hosp, other)}
#' }
"health_facility_table"

#' District population data
"district_pop"

#' Age-sex indicator table
"age_sex_table"

#' DHIS indicator table
"indicator_table"

#' District shapefile version1.0
"uga_district_shp"

#' Subcounty shapefile version2.0
#'
#' An R readable, valid, shapefile with subcounty shapes combatible with administrative
#' hierarchies in loc_table
#'
#' @format A shapefile with 2204 rows and 8 variables
#' \describe{
#'   \item{name}{Name of Subcounty}
#'   \item{id}{DHIS2 assigned ID of Subcounty}
#'   \item{geometry}{geometry of subcounty (polygon or multipolygon)}
#'   \item{dup_geom}{indicator flag if the geometry is shared with another subcounty and cannot be resolved}
#'   \item{split_sc}{indicator flag that geometry needs to be split, but has not been done}
#'   \item{shp_as_district}{indicator flag if the subcounty shape is unknown and has therefore been assigned the district shape}
#'   \item{district_name}{Name of parent district of subcounty}
#'   }
"uga_subcounty_shp"

#' region shapefile version1.0
"uga_region_shp"

#' Water shapefile version1.0
"uga_water_shp"
