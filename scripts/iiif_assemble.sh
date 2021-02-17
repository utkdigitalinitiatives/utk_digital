#!/bin/bash

echo "Installing the IIIF Assemble & Serve application"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# clone repo via https
cd /vhosts/digital/web || exit
sudo rm -rf assemble
sudo git clone https://github.com/mathewjordan/iiif_assemble assemble

# reset remote origin to use ssh-key
cd assemble
sudo git remote remove origin
sudo git remote add origin git@github.com:mathewjordan/iiif_assemble.git

# echo "Installing Composer"
# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer