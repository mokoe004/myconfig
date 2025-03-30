#!/bin/bash

# Zielverzeichnis für .desktop-Dateien
DESKTOP_DIR="$HOME/.local/share/applications"

# Name der Verknüpfung
APP_NAME="Nextcloud Folder"
FILE_NAME="nextcloud-folder.desktop"

# Zielpfad (zu ändernder Ordner)
FOLDER_PATH="/data/nextcloud"

# Icon (optional kannst du hier z. B. ein Nextcloud-Icon setzen)
ICON_NAME="folder"

# Desktop-Datei erstellen
cat <<EOF > "$DESKTOP_DIR/$FILE_NAME"
[Desktop Entry]
Name=$APP_NAME
Comment=Öffnet den Nextcloud-Ordner
Exec=nautilus $FOLDER_PATH
Icon=$ICON_NAME
Terminal=false
Type=Application
Categories=Utility;
EOF

echo "Verknüpfung erstellt: $DESKTOP_DIR/$FILE_NAME"
echo "Du kannst sie nun über die Suche finden und an die Seitenleiste anheften!"
