#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat/tomcat-users.xml
systemctl restart tomcat

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

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
drush block-configure --module=islandora_usage_stats --delta=top_usage --region=-1 --weight=0
drush block-configure --module=islandora_usage_stats --delta=recent_activity --region=-1 --weight=0
drush block-configure --module=islandora_usage_stats --delta=top_search --region=-1 --weight=0
drush block-configure --module=islandora_usage_stats --delta=top_downloads --region=-1 --weight=0
drush block-configure --module=user --delta=online --region=-1 --weight=0
drush block-configure --module=views --delta=usage_collection-usage_stats --region=-1 --weight=0
drush block-configure --module=node --delta=recent --region=-1 --weight=0
drush block-configure --module=node --delta=syndicate --region=-1 --weight=0
drush block-configure --module=comment --delta=recent --region=-1 --weight=0
