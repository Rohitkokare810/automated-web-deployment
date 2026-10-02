#!/bin/bash

BACKUP_DIR="/home/ec2-user/backups"

echo "Starting backup cleanup..."

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

echo "Cleanup completed."

echo "Remaining backups:"
ls -lh "$BACKUP_DIR"
