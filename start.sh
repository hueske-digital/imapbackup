#!/bin/sh
set -e

run_backup() {
  local context=$1
  echo "[$context] $(date '+%Y-%m-%d %H:%M:%S %Z') starting imap-backup…"
  imap-backup single backup \
    --email    "${EMAIL_ADDRESS}" \
    --password "${EMAIL_PASSWORD}" \
    --server   "${EMAIL_HOST}" \
    --path     "/data/${EMAIL_ADDRESS}"
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "[$context] $(date '+%Y-%m-%d %H:%M:%S %Z') ERROR: Backup failed (exit code $rc)"
    exit $rc
  fi
  echo "[$context] $(date '+%Y-%m-%d %H:%M:%S %Z') backup complete."
}

if [ "${1:-}" = "cron" ]; then
  run_backup "cron"
  exit 0
fi

RUN_ON_STARTUP="${RUN_ON_STARTUP:-false}"
if [ "$RUN_ON_STARTUP" = "true" ]; then
  run_backup "startup"
fi

echo "[startup] $(date '+%Y-%m-%d %H:%M:%S %Z') entering sleep mode."
exec sleep infinity