#!/bin/bash

SOURCE_DIR="/mnt/project-data/application"
BACKUP_DIR="/home/ec2-user/backups"
S3_BUCKET="rohit-automated-web-backup-2026"
S3_PATH="s3://$S3_BUCKET/backups"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/application-backup-$TIMESTAMP.tar.gz"

echo "Starting backup..."

mkdir -p "$BACKUP_DIR"

echo "Creating compressed backup..."
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -ne 0 ]; then
    echo "Backup creation failed."
    exit 1
fi

echo "Uploading backup to S3..."
aws s3 cp "$BACKUP_FILE" "$S3_PATH/"

if [ $? -ne 0 ]; then
    echo "S3 upload failed."
    exit 1
fi

echo "Backup completed successfully."
echo "Backup file: $BACKUP_FILE"
