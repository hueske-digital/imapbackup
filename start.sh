#!/bin/sh
set -e

# Wenn das Skript mit Argument "cron" aufgerufen wird,
# führe nur das Backup aus und beende dich:
if [ "$1" = "cron" ]; then
  echo "[cron] running imap-backup…"
  imap-backup single backup \
    --email    "${EMAIL_ADDRESS}" \
    --password "${EMAIL_PASSWORD}" \
    --server   "${EMAIL_HOST}" \
    --path     "/data/${EMAIL_ADDRESS}"
  echo "[cron] backup complete."
  exit 0
fi

# Sonst: normaler Container-Start
RUN_ON_STARTUP="${RUN_ON_STARTUP:-false}"
if [ "$RUN_ON_STARTUP" = "true" ]; then
  echo "[startup] running one-time imap-backup…"
  imap-backup single backup \
    --email    "${EMAIL_ADDRESS}" \
    --password "${EMAIL_PASSWORD}" \
    --server   "${EMAIL_HOST}" \
    --path     "/data/${EMAIL_ADDRESS}"
  echo "[startup] backup complete."
fi

echo "[startup] entering sleep mode."
exec sleep infinity