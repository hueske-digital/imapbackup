# IMAP-Backup mit Docker

Dieses Projekt ermöglicht das Sichern von E-Mails über IMAP mithilfe eines Docker-Containers.

## Voraussetzungen

- Docker und Docker Compose müssen installiert sein.
- Eine `.env`-Datei mit den notwendigen Konfigurationswerten muss erstellt werden.

## Installation

1. Klone dieses Repository:
   ```bash
   git clone <repository-url>
   cd <repository-verzeichnis>
   ```

2. Erstelle eine `.env`-Datei basierend auf der `.env.example`:
   ```dotenv
   EMAIL_ADDRESS=deine-email@example.com
   EMAIL_PASSWORD=dein-passwort
   EMAIL_HOST=imap.example.com
   RUN_ON_STARTUP=false
   ```

3. Starte den Docker-Container:
   ```bash
   docker-compose up -d
   ```

## Konfiguration

### `.env`-Datei

Die `.env`-Datei enthält folgende Konfigurationswerte:

- `EMAIL_ADDRESS`: Die E-Mail-Adresse, die gesichert werden soll.
- `EMAIL_PASSWORD`: Das Passwort für die E-Mail-Adresse.
- `EMAIL_HOST`: Der IMAP-Server der E-Mail-Adresse.
- `RUN_ON_STARTUP`: Wenn auf `true` gesetzt, wird beim Start des Containers ein einmaliges Backup ausgeführt.

### Cron-Job

Ein Cron-Job wird mit [Ofelia](https://github.com/mcuadros/ofelia) konfiguriert. Der Backup-Job wird standardmäßig täglich um 12:00 Uhr ausgeführt. Die Konfiguration erfolgt über die Labels im `docker-compose.yml`.

## Datenvolumen

Die gesicherten Daten werden im Docker-Volume `app_data` gespeichert.

## Skripte

### `start.sh`

Das Skript `start.sh` steuert den Ablauf:

- **Cron-Modus**: Führt ein Backup aus, wenn das Skript mit dem Argument `cron` aufgerufen wird.
- **Startup-Modus**: Führt ein einmaliges Backup aus, wenn `RUN_ON_STARTUP=true` gesetzt ist.