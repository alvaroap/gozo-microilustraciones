#!/bin/bash
# Crea las versiones .mov (HEVC con transparencia) para Safari / iPhone a partir de la secuencia máster.
# Doble clic en Finder. Necesita ffmpeg (Homebrew: brew install ffmpeg).
cd "$(dirname "$0")"
if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "Falta ffmpeg. Instálalo con Homebrew:  brew install ffmpeg"; read -n 1 -s -r -p "Pulsa una tecla para cerrar"; exit 1
fi
for tramo in entrada loop; do
  ffmpeg -y -loglevel error -framerate 30 -i "master/${tramo}/transferencia-${tramo}_%04d.png" \
    -c:v hevc_videotoolbox -alpha_quality 0.9 -q:v 65 -tag:v hvc1 -pix_fmt bgra "transferencia-${tramo}.mov" && echo "Creado transferencia-${tramo}.mov"
done
read -n 1 -s -r -p "Listo. Pulsa una tecla para cerrar"
