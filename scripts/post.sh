#!/bin/bash

# add a link to collections from web root ( until we get something else there)
sudo tee -a /home/vagrant/index.html &>/dev/null <<<EOF
<html><head><title>digital</title></head>
<body>
 <hr />
 <a href="/collections">Go To Collections</a>
</body>
</html>
EOF
sudo mv /home/vagrant/index.html /vhosts/digital/web/

# Set correct permissions on sites/default/files
chown -R apache.apache "$DRUPAL_HOME"/sites/default/files

cd "$DRUPAL_HOME" || exit
drush vset islandora_openseadragon_tilesource 'iiif'
drush vset islandora_openseadragon_iiif_url 'http://localhost:8000/iiif/2'
drush vset islandora_openseadragon_iiif_token_header 0
drush vset islandora_openseadragon_iiif_identifier '/collections~islandora~object~[islandora_openseadragon:pid]~datastream~JP2~view~[islandora_openseadragon:token]'

drush vset islandora_internet_archive_bookreader_iiif_identifier '[islandora_iareader:pid]~[islandora_iareader:dsid]~[islandora_iareader:token]'
drush vset islandora_internet_archive_bookreader_iiif_url 'http://localhost:8000/iiif/2'
drush vset islandora_internet_archive_bookreader_iiif_token_header 0
drush vset islandora_internet_archive_bookreader_pagesource 'iiif'

cd "$DRUPAL_HOME" || exit
# Removes powered by drupal text and the area it blocks content with.
drush -y -u 1 dl drush_extras
drush block-configure --module=system --delta=powered-by --region=-1 --weight=0
drush block-configure --module=islandora_compound_object --delta=compound_navigation --region=-1 --weight=0
drush block-configure --module=islandora_compound_object --delta=compound_jail_display --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=advanced --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=simple --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=basic_facets --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=current_query --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=display_switch --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=sort --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=explore --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=search_navigation --region=-1 --weight=0
drush block-configure --module=islandora_solr --delta=result_limit --region=-1 --weight=0
drush block-configure --module=islandora_solr_facet_pages --delta=islandora-solr-facet-pag--region=-1 --weight=0
#drush block-configure --module=islandora_usage_stats --delta=top_usage --region=-1 --weight=0
#drush block-configure --module=islandora_usage_stats --delta=recent_activity --region=-1 --weight=0
#drush block-configure --module=islandora_usage_stats --delta=top_search --region=-1 --weight=0
#drush block-configure --module=islandora_usage_stats --delta=top_downloads --region=-1 --weight=0
drush block-configure --module=user --delta=online --region=-1 --weight=0
drush block-configure --module=views --delta=usage_collection-usage_stats --region=-1 --weight=0
drush block-configure --module=node --delta=recent --region=-1 --weight=0
drush block-configure --module=node --delta=syndicate --region=-1 --weight=0
drush block-configure --module=comment --delta=recent --region=-1 --weight=0
