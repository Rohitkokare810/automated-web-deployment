#!/bin/bash

echo "================================="
echo " Web Server Health Check"
echo "================================="

echo
echo "Apache Status:"
if systemctl is-active --quiet httpd; then
    echo "Apache: RUNNING"
else
    echo "Apache: NOT RUNNING"
fi

echo
echo "EBS Mount:"
if mountpoint -q /mnt/project-data; then
    echo "EBS: MOUNTED"
else
    echo "EBS: NOT MOUNTED"
fi

echo
echo "Disk Usage:"
df -h /mnt/project-data

echo
echo "Website HTTP Status:"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)

if [ "$HTTP_STATUS" = "200" ]; then
    echo "Website: UP (HTTP $HTTP_STATUS)"
else
    echo "Website: PROBLEM (HTTP $HTTP_STATUS)"
fi

echo
echo "S3 Access:"
if aws s3 ls s3://rohit-automated-web-backup-2026 >/dev/null 2>&1; then
    echo "S3: ACCESSIBLE"
else
    echo "S3: NOT ACCESSIBLE"
fi

echo
echo "================================="
echo " Health Check Completed"
echo "================================="
