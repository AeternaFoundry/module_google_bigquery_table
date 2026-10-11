variable "bigquery_tables" {
  description = <<EOT
Map of bigquery_tables, attributes below
Required:
    - dataset_id
    - table_id
Optional:
    - clustering
    - deletion_policy
    - deletion_protection
    - description
    - expiration_time
    - friendly_name
    - ignore_auto_generated_schema
    - ignore_schema_changes
    - labels
    - max_staleness
    - project
    - require_partition_filter
    - resource_tags
    - schema
    - table_metadata_view
    - biglake_configuration (block):
        - connection_id (required)
        - file_format (required)
        - storage_uri (required)
        - table_format (required)
    - encryption_configuration (block):
        - kms_key_name (required)
    - external_catalog_table_options (block):
        - connection_id (optional)
        - parameters (optional)
        - storage_descriptor (optional, block):
            - input_format (optional)
            - location_uri (optional)
            - output_format (optional)
            - serde_info (optional, block):
                - name (optional)
                - parameters (optional)
                - serialization_library (required)
    - external_data_configuration (block):
        - autodetect (required)
        - avro_options (optional, block):
            - use_avro_logical_types (required)
        - bigtable_options (optional, block):
            - column_family (optional, block):
                - column (optional, block):
                    - encoding (optional)
                    - field_name (optional)
                    - only_read_latest (optional)
                    - qualifier_encoded (optional)
                    - qualifier_string (optional)
                    - type (optional)
                - encoding (optional)
                - family_id (optional)
                - only_read_latest (optional)
                - type (optional)
            - ignore_unspecified_column_families (optional)
            - output_column_families_as_json (optional)
            - read_rowkey_as_string (optional)
        - compression (optional)
        - connection_id (optional)
        - csv_options (optional, block):
            - allow_jagged_rows (optional)
            - allow_quoted_newlines (optional)
            - encoding (optional)
            - field_delimiter (optional)
            - quote (required)
            - skip_leading_rows (optional)
            - source_column_match (optional)
        - decimal_target_types (optional)
        - file_set_spec_type (optional)
        - google_sheets_options (optional, block):
            - range (optional)
            - skip_leading_rows (optional)
        - hive_partitioning_options (optional, block):
            - mode (optional)
            - require_partition_filter (optional)
            - source_uri_prefix (optional)
        - ignore_unknown_values (optional)
        - json_extension (optional)
        - json_options (optional, block):
            - encoding (optional)
        - max_bad_records (optional)
        - metadata_cache_mode (optional)
        - object_metadata (optional)
        - parquet_options (optional, block):
            - enable_list_inference (optional)
            - enum_as_string (optional)
        - reference_file_schema_uri (optional)
        - schema (optional)
        - source_format (optional)
        - source_uris (required)
    - materialized_view (block):
        - allow_non_incremental_definition (optional)
        - enable_refresh (optional)
        - query (required)
        - refresh_interval_ms (optional)
    - range_partitioning (block):
        - field (required)
        - range (required, block):
            - end (required)
            - interval (required)
            - start (required)
    - schema_foreign_type_info (block):
        - type_system (required)
    - table_constraints (block):
        - foreign_keys (optional, block):
            - column_references (required, block):
                - referenced_column (required)
                - referencing_column (required)
            - name (optional)
            - referenced_table (required, block):
                - dataset_id (required)
                - project_id (required)
                - table_id (required)
        - primary_key (optional, block):
            - columns (required)
    - table_replication_info (block):
        - replication_interval_ms (optional)
        - source_dataset_id (required)
        - source_project_id (required)
        - source_table_id (required)
    - time_partitioning (block):
        - expiration_ms (optional)
        - field (optional)
        - require_partition_filter (optional)
        - type (required)
    - view (block):
        - query (required)
        - use_legacy_sql (optional)
EOT

  type = map(object({
    dataset_id                   = string
    table_id                     = string
    clustering                   = optional(list(string))
    deletion_policy              = optional(string)
    deletion_protection          = optional(bool)
    description                  = optional(string)
    expiration_time              = optional(number)
    friendly_name                = optional(string)
    ignore_auto_generated_schema = optional(bool)
    ignore_schema_changes        = optional(list(string))
    labels                       = optional(map(string))
    max_staleness                = optional(string)
    project                      = optional(string)
    require_partition_filter     = optional(bool)
    resource_tags                = optional(map(string))
    schema                       = optional(string)
    table_metadata_view          = optional(string)
    biglake_configuration = optional(object({
      connection_id = string
      file_format   = string
      storage_uri   = string
      table_format  = string
    }))
    encryption_configuration = optional(object({
      kms_key_name = string
    }))
    external_catalog_table_options = optional(object({
      connection_id = optional(string)
      parameters    = optional(map(string))
      storage_descriptor = optional(object({
        input_format  = optional(string)
        location_uri  = optional(string)
        output_format = optional(string)
        serde_info = optional(object({
          name                  = optional(string)
          parameters            = optional(map(string))
          serialization_library = string
        }))
      }))
    }))
    external_data_configuration = optional(object({
      autodetect = bool
      avro_options = optional(object({
        use_avro_logical_types = bool
      }))
      bigtable_options = optional(object({
        column_family = optional(list(object({
          column = optional(list(object({
            encoding          = optional(string)
            field_name        = optional(string)
            only_read_latest  = optional(bool)
            qualifier_encoded = optional(string)
            qualifier_string  = optional(string)
            type              = optional(string)
          })))
          encoding         = optional(string)
          family_id        = optional(string)
          only_read_latest = optional(bool)
          type             = optional(string)
        })))
        ignore_unspecified_column_families = optional(bool)
        output_column_families_as_json     = optional(bool)
        read_rowkey_as_string              = optional(bool)
      }))
      compression   = optional(string)
      connection_id = optional(string)
      csv_options = optional(object({
        allow_jagged_rows     = optional(bool)
        allow_quoted_newlines = optional(bool)
        encoding              = optional(string)
        field_delimiter       = optional(string)
        quote                 = string
        skip_leading_rows     = optional(number)
        source_column_match   = optional(string)
      }))
      decimal_target_types = optional(set(string))
      file_set_spec_type   = optional(string)
      google_sheets_options = optional(object({
        range             = optional(string)
        skip_leading_rows = optional(number)
      }))
      hive_partitioning_options = optional(object({
        mode                     = optional(string)
        require_partition_filter = optional(bool)
        source_uri_prefix        = optional(string)
      }))
      ignore_unknown_values = optional(bool)
      json_extension        = optional(string)
      json_options = optional(object({
        encoding = optional(string)
      }))
      max_bad_records     = optional(number)
      metadata_cache_mode = optional(string)
      object_metadata     = optional(string)
      parquet_options = optional(object({
        enable_list_inference = optional(bool)
        enum_as_string        = optional(bool)
      }))
      reference_file_schema_uri = optional(string)
      schema                    = optional(string)
      source_format             = optional(string)
      source_uris               = list(string)
    }))
    materialized_view = optional(object({
      allow_non_incremental_definition = optional(bool)
      enable_refresh                   = optional(bool)
      query                            = string
      refresh_interval_ms              = optional(number)
    }))
    range_partitioning = optional(object({
      field = string
      range = object({
        end      = number
        interval = number
        start    = number
      })
    }))
    schema_foreign_type_info = optional(object({
      type_system = string
    }))
    table_constraints = optional(object({
      foreign_keys = optional(list(object({
        column_references = object({
          referenced_column  = string
          referencing_column = string
        })
        name = optional(string)
        referenced_table = object({
          dataset_id = string
          project_id = string
          table_id   = string
        })
      })))
      primary_key = optional(object({
        columns = list(string)
      }))
    }))
    table_replication_info = optional(object({
      replication_interval_ms = optional(number)
      source_dataset_id       = string
      source_project_id       = string
      source_table_id         = string
    }))
    time_partitioning = optional(object({
      expiration_ms            = optional(number)
      field                    = optional(string)
      require_partition_filter = optional(bool)
      type                     = string
    }))
    view = optional(object({
      query          = string
      use_legacy_sql = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.source_format == null || (contains(["CSV", "GOOGLE_SHEETS", "NEWLINE_DELIMITED_JSON", "AVRO", "ICEBERG", "DATASTORE_BACKUP", "PARQUET", "ORC", "BIGTABLE", "DELTA_LAKE"], v.external_data_configuration.source_format)))
      )
    ])
    error_message = "must be one of: \"CSV\", \"GOOGLE_SHEETS\", \"NEWLINE_DELIMITED_JSON\", \"AVRO\", \"ICEBERG\", \"DATASTORE_BACKUP\", \"PARQUET\", \"ORC\", \"BIGTABLE\", \"DELTA_LAKE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.compression == null || (contains(["NONE", "GZIP"], v.external_data_configuration.compression)))
      )
    ])
    error_message = "must be one of: \"NONE\", \"GZIP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.csv_options == null || (v.external_data_configuration.csv_options.encoding == null || (contains(["ISO-8859-1", "UTF-8"], v.external_data_configuration.csv_options.encoding))))
      )
    ])
    error_message = "must be one of: \"ISO-8859-1\", \"UTF-8\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.csv_options == null || (v.external_data_configuration.csv_options.source_column_match == null || (contains(["POSITION", "NAME"], v.external_data_configuration.csv_options.source_column_match))))
      )
    ])
    error_message = "must be one of: \"POSITION\", \"NAME\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.json_options == null || (v.external_data_configuration.json_options.encoding == null || (contains(["UTF-8", "UTF-16BE", "UTF-16LE", "UTF-32BE", "UTF-32LE"], v.external_data_configuration.json_options.encoding))))
      )
    ])
    error_message = "must be one of: \"UTF-8\", \"UTF-16BE\", \"UTF-16LE\", \"UTF-32BE\", \"UTF-32LE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.json_extension == null || (contains(["GEOJSON"], v.external_data_configuration.json_extension)))
      )
    ])
    error_message = "must be one of: \"GEOJSON\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.external_data_configuration == null || (v.external_data_configuration.metadata_cache_mode == null || (contains(["AUTOMATIC", "MANUAL"], v.external_data_configuration.metadata_cache_mode)))
      )
    ])
    error_message = "must be one of: \"AUTOMATIC\", \"MANUAL\""
  }
  validation {
    condition = alltrue([
      for k, v in var.bigquery_tables : (
        v.time_partitioning == null || (contains(["DAY", "HOUR", "MONTH", "YEAR"], v.time_partitioning.type))
      )
    ])
    error_message = "must be one of: \"DAY\", \"HOUR\", \"MONTH\", \"YEAR\""
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

