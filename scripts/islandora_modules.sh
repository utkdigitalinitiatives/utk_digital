#!/bin/bash

echo "Installing all Islandora Foundation modules"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# clone repo via https
cd "$DRUPAL_HOME"/sites || exit
sudo rm -rf all
sudo git clone https://github.com/utkdigitalinitiatives/utk-islandora7-drupal all

# reset remote origin to use ssh-key
cd "$DRUPAL_HOME"/sites/all || exit
sudo git remote remove origin
sudo git remote add origin git@github.com:utkdigitalinitiatives/utk-islandora7-drupal.git

# Permissions and ownership
sudo chown -hR vagrant:apache "$DRUPAL_HOME"/sites/all/libraries
sudo chown -hR vagrant:apache "$DRUPAL_HOME"/sites/all/modules
sudo chown -hR apache:apache "$DRUPAL_HOME"/sites/default/files
sudo chown -hR apache:apache "$DRUPAL_HOME"/sites/all/modules/custom
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/libraries
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/default/files
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules/custom


cd "$DRUPAL_HOME"/sites/all/modules || exit

# Check for a user's .drush folder, create if it doesn't exist
if [ ! -d "$HOME_DIR/.drush" ]; then
  mkdir "$HOME_DIR/.drush"
  sudo chown vagrant:vagrant "$HOME_DIR"/.drush
fi


# create root fedora object
curl -s -u "fedoraAdmin:fedoraAdmin" -XPOST "http://localhost:8080/fedora/objects/digital:collections?label=digitalcollections"

# Enable Modules
drush -y -u 1 en libraries 
drush -y -u 1 en php_lib islandora objective_forms
drush -y -u 1 en xml_forms xml_form_builder xml_schema_api xml_form_elements
drush -y -u 1 en xml_form_api
drush -y -u 1 en jquery_update
drush -y -u 1 en zip_importer
drush -y -u 1 en islandora_importer
drush -y -u 1 en islandora_basic_image
drush -y -u 1 en islandora_basic_collection
drush -y -u 1 en islandora_large_image
drush -y -u 1 en islandora_internet_archive_bookreader
drush -y -u 1 en islandora_paged_content
drush -y -u 1 en colorbox
drush -y -u 1 en islandora_book 
drush -y -u 1 en islandora_pdf
drush -y -u 1 en islandora_audio
drush -y -u 1 en islandora_solr islandora_solr_metadata
drush -y -u 1 en islandora_solr_config
drush -y -u 1 en islandora_solr_views
drush -y -u 1 en islandora_book_batch
drush -y -u 1 en islandora_video
drush -y -u 1 en islandora_compound_object
drush -y -u 1 en islandora_premis
drush -y -u 1 en islandora_checksum
#drush -y -u 1 en islandora_checksum_checker
drush -y -u 1 en islandora_pdfjs
drush -y -u 1 en islandora_videojs
#drush -y -u 1 en islandora_compound_object
drush -y -u 1 en islandora_fits
drush -y -u 1 en islandora_ocr
drush -y -u 1 en islandora_oai
#drush -y -u 1 en islandora_simple_workflow
drush -y -u 1 en islandora_xacml_api islandora_xacml_editor
drush -y -u 1 en islandora_xmlsitemap
drush -y -u 1 en islandora_bagit
#drush -y -u 1 en islandora_usage_stats
drush -y -u 1 en islandora_form_fieldpanel
# drush -y -u 1 en utk_lib_feedback
#drush -y -u 1 en islandora_binary_object
#drush -y -u 1 en islandora_batch_derivative_trigger
#drush -y -u 1 en islandora_compound_batch
drush -y -u 1 en islandora_collection_search
#drush -y -u 1 en islandora_batch_derivative_trigger
#drush -y -u 1 en islandora_compound_batch
#drush -y -u 1 en islandora_social_metatags
drush -y -u 1 en islandora_context
drush -y -u 1 en features context

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Set variables for Islandora modules
drush eval "variable_set('islandora_audio_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_fits_executable_path', '$FITS_HOME/fits/fits.sh')"
drush eval "variable_set('islandora_lame_url', '/usr/bin/lame')"
drush eval "variable_set('islandora_video_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_video_ffmpeg_path', '/usr/local/bin/ffmpeg')"
drush eval "variable_set('islandora_book_viewers', array('name' => array('none' => 'none', 'islandora_internet_archive_bookreader' => 'islandora_internet_archive_bookreader'), 'default' => 'islandora_internet_archive_bookreader'))"
drush eval "variable_set('islandora_book_page_viewers', array('name' => array('none' => 'none', 'islandora_openseadragon' => 'islandora_openseadragon'), 'default' => 'islandora_openseadragon'))"
drush eval "variable_set('islandora_large_image_viewers', array('name' => array('none' => 'none', 'islandora_openseadragon' => 'islandora_openseadragon'), 'default' => 'islandora_openseadragon'))"
drush eval "variable_set('islandora_use_kakadu', TRUE)"
drush eval "variable_set('islandora_pdf_create_fulltext', 1)"
drush eval "variable_set('islandora_checksum_enable_checksum', TRUE)"
drush eval "variable_set('islandora_checksum_checksum_type', 'SHA-1')"
drush eval "variable_set('islandora_ocr_tesseract', '/usr/bin/tesseract')"
drush eval "variable_set('islandora_batch_java', '/usr/bin/java')"
drush eval "variable_set('image_toolkit', 'imagemagick')"
drush eval "variable_set('imagemagick_convert', '/usr/bin/convert')"
drush eval "variable_set('islandora_repository_pid', 'digital:collections')"
