#!/usr/bin/env bash
# ==============================================================================
# Sunnify Plan V - Desinstalador para GNU/Linux
# ==============================================================================
set -euo pipefail

BIN_DIR="${HOME}/.local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICONS_DIR="${HOME}/.local/share/icons/hicolor"

echo "🗑️ Desinstalando Sunnify Plan V..."

# 1. Eliminar ejecutables
rm -f "${BIN_DIR}/sunnify"
if [ -f "${HOME}/.local/share/binarymanager/sunnify" ]; then
    rm -f "${HOME}/.local/share/binarymanager/sunnify"
    if [ -f "${HOME}/.local/share/binarymanager/sunnify.bak" ]; then
        echo "ℹ️ Restaurando copia de respaldo original en binarymanager..."
        mv "${HOME}/.local/share/binarymanager/sunnify.bak" "${HOME}/.local/share/binarymanager/sunnify"
    fi
fi

# 2. Eliminar acceso de escritorio
rm -f "${DESKTOP_DIR}/sunnify.desktop"

# 3. Eliminar iconos
rm -f "${HOME}/.local/share/icons/sunnify.svg" "${HOME}/.icons/sunnify.svg" "${HOME}/.local/share/pixmaps/sunnify.svg"
rm -f "${HOME}/.local/share/icons/sunnify.png" "${HOME}/.icons/sunnify.png" "${HOME}/.local/share/pixmaps/sunnify.png"
for size in 16 24 32 48 64 128 256; do
    rm -f "${ICONS_DIR}/${size}x${size}/apps/sunnify.png"
done

# 4. Actualizar cachés
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "${DESKTOP_DIR}" 2>/dev/null || true
fi
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -f -t "${ICONS_DIR}" 2>/dev/null || true
fi

echo "✅ Sunnify Plan V fue desinstalado del sistema."
