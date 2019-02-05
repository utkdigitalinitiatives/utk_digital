#!/bin/bash

cd "$DRUPAL_HOME" || exit

drush vset islandora_solr_advanced_search_block_lucene_regex_default '/(\+|-|&&|\|\||!|\(|\)|\{|\}|\[|\]|\^| |~|\*|\?|\:|"|\\|\/)/'
drush vset islandora_solr_advanced_search_block_lucene_syntax_escape 0
drush vset islandora_solr_allow_preserve_filters 0
drush vset islandora_solr_base_advanced 0
drush vset islandora_solr_base_query '*:*'
drush vset islandora_solr_content_model_field 'RELS_EXT_hasModel_uri_ms'
drush vset islandora_solr_datastream_id_field 'fedora_datastreams_ms'
drush vset islandora_solr_debug_mode 0
drush vset islandora_solr_facet_max_limit '20'
drush vset islandora_solr_facet_min_limit '2'
drush vset islandora_solr_human_friendly_query_block 1
drush vset islandora_solr_limit_result_fields 0
drush vset islandora_solr_luke_timeout '45'
drush vset islandora_solr_member_of_collection_field 'RELS_EXT_isMemberOfCollection_uri_ms'
drush vset islandora_solr_member_of_field 'RELS_EXT_isMemberOf_uri_ms'
drush vset islandora_solr_num_of_results '20'
drush vset islandora_solr_num_of_results_advanced '{'
drush vset islandora_solr_object_label_field 'fgs_label_s'
drush vset islandora_solr_primary_display 'grid'
drush vset islandora_solr_query_fields 'dc.title^5 dc.subject^2 dc.description^2 dc.creator^2 dc.contributor^1 dc.type'
drush vset islandora_solr_search_boolean 'user'
drush vset islandora_solr_search_field_value_separator ', '
drush vset islandora_solr_search_navigation 1
drush vset islandora_solr_search_truncated_field_value_separator '<br />'
drush vset islandora_solr_tabs__active_tab 'edit-query-defaults'
drush vset islandora_solr_use_ui_qf 0
drush vset islandora_basic_collection_admin_page_size '20'
drush vset islandora_basic_collection_default_view 'grid'
drush vset islandora_basic_collection_disable_collection_policy_delete 1
drush vset islandora_basic_collection_disable_count_object 0
drush vset islandora_basic_collection_disable_display_generation 0
drush vset islandora_basic_collection_display_backend 'islandora_solr_query_backend'
drush vset islandora_basic_collection_page_size: '12'
drush vset islandora_collection_metadata_display: 0
drush vset islandora_solr_base_sort: 'score desc, mods_identifier_local_ss asc'
drush vset islandora_solr_collection_result_limit_block_override: 0
drush vset islandora_solr_collection_sort: 'PID asc'
drush vset islandora_solr_collection_sort_block_override: 1
drush vset islandora_solr_dismax_allowed: true
drush vset islandora_solr_facet_max_limit: '100'
drush vset islandora_solr_facet_min_limit: '1'
drush vset islandora_solr_facet_soft_limit '5'
drush vset islandora_solr_force_update_index_after_object_purge: 1
drush vset islandora_solr_individual_collection_sorting 1
drush vset islandora_solr_limit_result_fields 1
drush vset islandora_solr_metadata_dedup_values 0
drush vset islandora_solr_metadata_omit_empty_values 1
drush vset default 'grid'
drush vset grid 'grid'
drush vset islandora_solr_request_handler '0'
drush vset islandora_solr_tabs__active_tab 'edit-default-display-settings'
drush vset islandora_solr_url 'localhost:8080/solr'
drush ev 'variable_set("islandora_solr_secondary_display", array("csv" => 0,"rss" => 0));'
drush ev 'variable_set("islandora_solr_primary_display_table", array(weight => array("default" => 0,"grid" => 0,"table" => 0),"default" => "grid","enabled" => array("default" => "default","grid" => "grid","table" => 0)));'
drush ev 'variable_set("islandora_basic_collection_metadata_info_table_drag_attributes", array("description" => array("weight" => 0, "omit" => 0), "collections" => array("weight" => 0,"omit" => 0), "wrapper" => array("weight" => 0, "omit" => 0), "islandora_basic_collection_display" => array("weight" => 0, "omit" => 0)));'

# Set Permissions for users to see thumbnails of the home page.
drush role-add-perm 'anonymous user' 'view fedora repository objects'
drush role-add-perm 'authenticated user' 'view fedora repository objects'

# Set front paget to repository page
drush vset  site_frontpage 'islandora/object'
