#!/bin/bash

echo "Installing all Islandora Foundation module's required libraries"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi
cd "$DRUPAL_HOME"/sites/all/modules || exit
#sudo drush cache-clear drush
#drush -v videojs-plugin
#drush -v pdfjs-plugin
#drush -v iabookreader-plugin
#drush -v colorbox-plugin
#drush -v openseadragon-plugin
#sudo drush -v -y en islandora_openseadragon
# After last drush call from root user, change cache permissions
sudo chown -R vagrant:vagrant "$HOME_DIR"/.drush
