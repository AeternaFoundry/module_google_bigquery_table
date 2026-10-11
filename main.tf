resource "google_bigquery_table" "bigquery_tables" {
  for_each = var.bigquery_tables

  dataset_id                   = each.value.dataset_id
  table_id                     = each.value.table_id
  clustering                   = each.value.clustering
  deletion_policy              = each.value.deletion_policy
  deletion_protection          = each.value.deletion_protection
  description                  = each.value.description
  expiration_time              = each.value.expiration_time
  friendly_name                = each.value.friendly_name
  ignore_auto_generated_schema = each.value.ignore_auto_generated_schema
  ignore_schema_changes        = each.value.ignore_schema_changes
  labels                       = each.value.labels
  max_staleness                = each.value.max_staleness
  project                      = each.value.project
  require_partition_filter     = each.value.require_partition_filter
  resource_tags                = each.value.resource_tags
  schema                       = each.value.schema
  table_metadata_view          = each.value.table_metadata_view

  dynamic "biglake_configuration" {
    for_each = each.value.biglake_configuration != null ? [each.value.biglake_configuration] : []
    content {
      connection_id = biglake_configuration.value.connection_id
      file_format   = biglake_configuration.value.file_format
      storage_uri   = biglake_configuration.value.storage_uri
      table_format  = biglake_configuration.value.table_format
    }
  }

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration != null ? [each.value.encryption_configuration] : []
    content {
      kms_key_name = encryption_configuration.value.kms_key_name
    }
  }

  dynamic "external_catalog_table_options" {
    for_each = each.value.external_catalog_table_options != null ? [each.value.external_catalog_table_options] : []
    content {
      connection_id = external_catalog_table_options.value.connection_id
      parameters    = external_catalog_table_options.value.parameters
      dynamic "storage_descriptor" {
        for_each = external_catalog_table_options.value.storage_descriptor != null ? [external_catalog_table_options.value.storage_descriptor] : []
        content {
          input_format  = storage_descriptor.value.input_format
          location_uri  = storage_descriptor.value.location_uri
          output_format = storage_descriptor.value.output_format
          dynamic "serde_info" {
            for_each = storage_descriptor.value.serde_info != null ? [storage_descriptor.value.serde_info] : []
            content {
              name                  = serde_info.value.name
              parameters            = serde_info.value.parameters
              serialization_library = serde_info.value.serialization_library
            }
          }
        }
      }
    }
  }

  dynamic "external_data_configuration" {
    for_each = each.value.external_data_configuration != null ? [each.value.external_data_configuration] : []
    content {
      autodetect = external_data_configuration.value.autodetect
      dynamic "avro_options" {
        for_each = external_data_configuration.value.avro_options != null ? [external_data_configuration.value.avro_options] : []
        content {
          use_avro_logical_types = avro_options.value.use_avro_logical_types
        }
      }
      dynamic "bigtable_options" {
        for_each = external_data_configuration.value.bigtable_options != null ? [external_data_configuration.value.bigtable_options] : []
        content {
          dynamic "column_family" {
            for_each = bigtable_options.value.column_family != null ? bigtable_options.value.column_family : []
            content {
              dynamic "column" {
                for_each = column_family.value.column != null ? column_family.value.column : []
                content {
                  encoding          = column.value.encoding
                  field_name        = column.value.field_name
                  only_read_latest  = column.value.only_read_latest
                  qualifier_encoded = column.value.qualifier_encoded
                  qualifier_string  = column.value.qualifier_string
                  type              = column.value.type
                }
              }
              encoding         = column_family.value.encoding
              family_id        = column_family.value.family_id
              only_read_latest = column_family.value.only_read_latest
              type             = column_family.value.type
            }
          }
          ignore_unspecified_column_families = bigtable_options.value.ignore_unspecified_column_families
          output_column_families_as_json     = bigtable_options.value.output_column_families_as_json
          read_rowkey_as_string              = bigtable_options.value.read_rowkey_as_string
        }
      }
      compression   = external_data_configuration.value.compression
      connection_id = external_data_configuration.value.connection_id
      dynamic "csv_options" {
        for_each = external_data_configuration.value.csv_options != null ? [external_data_configuration.value.csv_options] : []
        content {
          allow_jagged_rows     = csv_options.value.allow_jagged_rows
          allow_quoted_newlines = csv_options.value.allow_quoted_newlines
          encoding              = csv_options.value.encoding
          field_delimiter       = csv_options.value.field_delimiter
          quote                 = csv_options.value.quote
          skip_leading_rows     = csv_options.value.skip_leading_rows
          source_column_match   = csv_options.value.source_column_match
        }
      }
      decimal_target_types = external_data_configuration.value.decimal_target_types
      file_set_spec_type   = external_data_configuration.value.file_set_spec_type
      dynamic "google_sheets_options" {
        for_each = external_data_configuration.value.google_sheets_options != null ? [external_data_configuration.value.google_sheets_options] : []
        content {
          range             = google_sheets_options.value.range
          skip_leading_rows = google_sheets_options.value.skip_leading_rows
        }
      }
      dynamic "hive_partitioning_options" {
        for_each = external_data_configuration.value.hive_partitioning_options != null ? [external_data_configuration.value.hive_partitioning_options] : []
        content {
          mode                     = hive_partitioning_options.value.mode
          require_partition_filter = hive_partitioning_options.value.require_partition_filter
          source_uri_prefix        = hive_partitioning_options.value.source_uri_prefix
        }
      }
      ignore_unknown_values = external_data_configuration.value.ignore_unknown_values
      json_extension        = external_data_configuration.value.json_extension
      dynamic "json_options" {
        for_each = external_data_configuration.value.json_options != null ? [external_data_configuration.value.json_options] : []
        content {
          encoding = json_options.value.encoding
        }
      }
      max_bad_records     = external_data_configuration.value.max_bad_records
      metadata_cache_mode = external_data_configuration.value.metadata_cache_mode
      object_metadata     = external_data_configuration.value.object_metadata
      dynamic "parquet_options" {
        for_each = external_data_configuration.value.parquet_options != null ? [external_data_configuration.value.parquet_options] : []
        content {
          enable_list_inference = parquet_options.value.enable_list_inference
          enum_as_string        = parquet_options.value.enum_as_string
        }
      }
      reference_file_schema_uri = external_data_configuration.value.reference_file_schema_uri
      schema                    = external_data_configuration.value.schema
      source_format             = external_data_configuration.value.source_format
      source_uris               = external_data_configuration.value.source_uris
    }
  }

  dynamic "materialized_view" {
    for_each = each.value.materialized_view != null ? [each.value.materialized_view] : []
    content {
      allow_non_incremental_definition = materialized_view.value.allow_non_incremental_definition
      enable_refresh                   = materialized_view.value.enable_refresh
      query                            = materialized_view.value.query
      refresh_interval_ms              = materialized_view.value.refresh_interval_ms
    }
  }

  dynamic "range_partitioning" {
    for_each = each.value.range_partitioning != null ? [each.value.range_partitioning] : []
    content {
      field = range_partitioning.value.field
      range {
        end      = range_partitioning.value.range.end
        interval = range_partitioning.value.range.interval
        start    = range_partitioning.value.range.start
      }
    }
  }

  dynamic "schema_foreign_type_info" {
    for_each = each.value.schema_foreign_type_info != null ? [each.value.schema_foreign_type_info] : []
    content {
      type_system = schema_foreign_type_info.value.type_system
    }
  }

  dynamic "table_constraints" {
    for_each = each.value.table_constraints != null ? [each.value.table_constraints] : []
    content {
      dynamic "foreign_keys" {
        for_each = table_constraints.value.foreign_keys != null ? table_constraints.value.foreign_keys : []
        content {
          column_references {
            referenced_column  = foreign_keys.value.column_references.referenced_column
            referencing_column = foreign_keys.value.column_references.referencing_column
          }
          name = foreign_keys.value.name
          referenced_table {
            dataset_id = foreign_keys.value.referenced_table.dataset_id
            project_id = foreign_keys.value.referenced_table.project_id
            table_id   = foreign_keys.value.referenced_table.table_id
          }
        }
      }
      dynamic "primary_key" {
        for_each = table_constraints.value.primary_key != null ? [table_constraints.value.primary_key] : []
        content {
          columns = primary_key.value.columns
        }
      }
    }
  }

  dynamic "table_replication_info" {
    for_each = each.value.table_replication_info != null ? [each.value.table_replication_info] : []
    content {
      replication_interval_ms = table_replication_info.value.replication_interval_ms
      source_dataset_id       = table_replication_info.value.source_dataset_id
      source_project_id       = table_replication_info.value.source_project_id
      source_table_id         = table_replication_info.value.source_table_id
    }
  }

  dynamic "time_partitioning" {
    for_each = each.value.time_partitioning != null ? [each.value.time_partitioning] : []
    content {
      expiration_ms            = time_partitioning.value.expiration_ms
      field                    = time_partitioning.value.field
      require_partition_filter = time_partitioning.value.require_partition_filter
      type                     = time_partitioning.value.type
    }
  }

  dynamic "view" {
    for_each = each.value.view != null ? [each.value.view] : []
    content {
      query          = view.value.query
      use_legacy_sql = view.value.use_legacy_sql
    }
  }
}

