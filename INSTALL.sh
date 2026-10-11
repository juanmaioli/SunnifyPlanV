#!/usr/bin/env bash
# ==============================================================================
# Sunnify Plan V - Instalador para GNU/Linux
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICONS_DIR="${HOME}/.local/share/icons/hicolor"
WRAPPER_PATH="${BIN_DIR}/sunnify"
DESKTOP_PATH="${DESKTOP_DIR}/sunnify.desktop"
ICON_SOURCE="${SCRIPT_DIR}/web-app/sunnify-webclient/public/spotify.svg"

echo "🎵 Instalando Sunnify Plan V..."

# 1. Crear directorios necesarios
mkdir -p "${BIN_DIR}" "${DESKTOP_DIR}"

# 2. Verificar o crear entorno virtual
if [ ! -d "${SCRIPT_DIR}/.venv" ]; then
    echo "📦 Creando entorno virtual Python..."
    python3 -m venv "${SCRIPT_DIR}/.venv"
    "${SCRIPT_DIR}/.venv/bin/pip" install --upgrade pip
    "${SCRIPT_DIR}/.venv/bin/pip" install -r "${SCRIPT_DIR}/req.txt"
fi

# 3. Crear ejecutable wrapper en ~/.local/bin
echo "⚙️ Configurando comando 'sunnify' en ${BIN_DIR}..."
cat << EOF > "${WRAPPER_PATH}"
#!/usr/bin/env bash
exec "${SCRIPT_DIR}/.venv/bin/python" "${SCRIPT_DIR}/Spotify_Downloader.py" "\$@"
EOF
chmod +x "${WRAPPER_PATH}"

# También actualizar en binarymanager si existe la carpeta
if [ -d "${HOME}/.local/share/binarymanager" ]; then
    cp "${WRAPPER_PATH}" "${HOME}/.local/share/binarymanager/sunnify"
    chmod +x "${HOME}/.local/share/binarymanager/sunnify"
fi

# 4. Instalar iconos del sistema
echo "🎨 Instalando iconos de la aplicación..."
mkdir -p "${HOME}/.local/share/icons" "${HOME}/.icons" "${HOME}/.local/share/pixmaps"
cp "${ICON_SOURCE}" "${HOME}/.local/share/icons/sunnify.svg" 2>/dev/null || true
cp "${ICON_SOURCE}" "${HOME}/.icons/sunnify.svg" 2>/dev/null || true
cp "${ICON_SOURCE}" "${HOME}/.local/share/pixmaps/sunnify.svg" 2>/dev/null || true

ICON_TARGET="${HOME}/.local/share/icons/sunnify.svg"
if command -v convert >/dev/null 2>&1; then
    for size in 16 24 32 48 64 128 256; do
        mkdir -p "${ICONS_DIR}/${size}x${size}/apps"
        convert -background none "${ICON_SOURCE}" -resize "${size}x${size}" "${ICONS_DIR}/${size}x${size}/apps/sunnify.png" 2>/dev/null || true
    done
    cp "${ICONS_DIR}/256x256/apps/sunnify.png" "${HOME}/.local/share/icons/sunnify.png" 2>/dev/null || true
    cp "${ICONS_DIR}/256x256/apps/sunnify.png" "${HOME}/.local/share/pixmaps/sunnify.png" 2>/dev/null || true
    ICON_TARGET="${ICONS_DIR}/256x256/apps/sunnify.png"
fi

# 5. Crear acceso directo en Aplicaciones > Multimedia
echo "🪟 Creando acceso en el menú de aplicaciones..."
cat << EOF > "${DESKTOP_PATH}"
[Desktop Entry]
Version=1.0
Type=Application
Name=Sunnify Plan V
GenericName=Spotify Downloader
Comment=Descargador de música, álbumes y playlists de Spotify
Exec=${WRAPPER_PATH}
Icon=${ICON_TARGET}
Terminal=false
Categories=AudioVideo;Audio;Player;Recorder;Multimedia;
Keywords=spotify;downloader;music;audio;mp3;flac;
StartupNotify=true
StartupWMClass=Sunnify Plan V
EOF
chmod +x "${DESKTOP_PATH}"

# 6. Actualizar cachés del sistema
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${DESKTOP_DIR}" 2>/dev/null || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -f -t "${ICONS_DIR}" 2>/dev/null || true
fi

echo "✅ Sunnify Plan V se instaló correctamente."
echo "👉 Podés abrirlo desde tu menú en Multimedia o ejecutando: sunnify"
