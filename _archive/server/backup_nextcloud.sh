#!/bin/bash

INSTALL_PATH=${NC_INSTALL_PATH}
BACKUP_PATH=${NC_BACKUP_PATH}
TODAY=`date +%d-%m-%Y`
DB_BACKUP="$BACKUP_PATH"db/nextcloud_"$TODAY".sql

if [ "$INSTALL_PATH" == "" ] || [ "$BACKUP_PATH" == "" ]
then
    echo "What am I supposed to do?! Exiting..."
    exit 1
fi

echo "Creating backup of nextcloud/data/"
rsync -Aaux --stats --delete $INSTALL_PATH "$BACKUP_PATH"data/

echo "Creating backup of nextcloud/config/"
rsync -Aaux --stats --delete $INSTALL_PATH "$BACKUP_PATH"config/

if [ -f $DB_BACKUP ]
then
    echo "Database backup already exists. Skipping..."
else
    echo "Creating backup of nexcloud database"
    docker exec -t postgres pg_dump -U postgres nextcloud > $DB_BACKUP
fi

echo "All done!"

cat <<EOF

in order to restore the database run:
cat your_dump.sql | docker exec -i postgres psql -U postgres nextcloud
EOF
