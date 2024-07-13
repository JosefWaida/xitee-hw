# Use Alpine Linux as the base image
FROM alpine:latest

# Install required packages
RUN apk update && apk add --no-cache \
    bash \
    mysql-client \
    tar \
    gzip \
    apk-cron

# Add backup script and cron job
COPY backup.sh /usr/local/bin/backup.sh
COPY crontab /etc/crontabs/root

# Make the backup script executable
RUN chmod +x /usr/local/bin/backup.sh

# Start cron service
CMD ["crond", "-f"]
