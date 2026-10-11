# 🎵 Sunnify &middot; Descargador de Playlists de Spotify

> **Descargá playlists, álbumes y canciones de Spotify a archivos de audio locales con carátulas y metadatos completos.**  
> Libre, de código abierto y multiplataforma. Aplicación de escritorio moderna con CLI headless integrado. Sin cuentas ni suscripciones.

---

## 🌟 Características Principales

- 🎨 **Interfaz Adaptable:** Se sincroniza automáticamente con la paleta de colores del sistema (modo claro y oscuro nativo).
- 📁 **Nomenclatura Personalizada de Canciones:** Formato `"Artista - Track - Título"` por defecto (`Artist - 01 - Song.mp3`).
- 💿 **Carpetas de Álbum Inteligentes:** Formato de carpeta por defecto `"Artista - Año - Álbum"` (`The Beatles - 1969 - Abbey Road`).
- 🎬 **Exportación de Enlaces de YouTube:** Botón para guardar la lista de canciones encontradas en un archivo HTML estilizado con tema oscuro y nombrado automáticamente como el álbum.
- 🏷️ **Metadatos y Carátulas Automáticas:** Casillas de *Show Preview* y *Add Meta Tags* activadas por defecto para una experiencia completa.
- ⚠️ **Gestión de Descargas Fallidas:** Panel interactivo para visualizar y copiar al portapapeles la lista de pistas no completadas.
- ⚡ **Descargas en Paralelo:** Descarga acelerada multihilo con cancelación inmediata y segura.
- 🎛️ **Múltiples Formatos:** MP3, M4A, Opus (128 / 192 / 256 / 320 kbps), FLAC y WAV (lossless).
- 💻 **CLI Headless Potente:** Automatizá descargas desde la terminal, scripts o entornos de servidor.

---

## 🚀 Instalación y Uso Rápido

### 1. ⚙️ Requisitos
- **Python 3.10+**
- **FFmpeg** instalado en el sistema

### 2. 📦 Dependencias

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r req.txt
```

### 3. ▶️ Ejecución

Para iniciar la aplicación gráfica:

```bash
python Spotify_Downloader.py
```

Para utilizar la herramienta por línea de comandos (CLI):

```bash
python sunnify_cli.py download "https://open.spotify.com/playlist/..."
```

---

## ⚙️ Formatos de Nombre y Carpetas

### Nombres de Archivo de Audio
| Opción en Ajustes | Ejemplo Generado |
| :--- | :--- |
| **Artist - Track - Song** *(Por defecto)* | `The Beatles - 01 - Yesterday.mp3` |
| **Artist - Song** | `The Beatles - Yesterday.mp3` |
| **Song - Artist** | `Yesterday - The Beatles.mp3` |
| **Song only** | `Yesterday.mp3` |

### Formato de Carpetas
| Tipo de Descarga | Formato de la Carpeta | Ejemplo |
| :--- | :--- | :--- |
| **Álbum** | `{Artista} - {Año} - {Álbum}` | `The Beatles - 1969 - Abbey Road` |
| **Playlist** | `{Playlist} - {Dueño}` | `Top 50 Global - Spotify` |
| **Canción Individual** | Carpeta raíz seleccionada | `~/Music/Sunnify/` |

---

## 🧪 Pruebas Unitarias

Para ejecutar la suite de pruebas completa:

```bash
pytest tests/
```

---

## 👤 Autor y Mantenimiento

- **Autor:** Juan Gabriel Maioli
- **Licencia:** Uso Educativo
