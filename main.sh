#!/bin/bash
download_dir="$HOME/Downloads"
file_download="$download_dir/get_helm.sh"

# Descargar el archivo de script de Helm
curl -fsSL -o "$file_download" https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Dar permisos de ejecución
chmod 700 "$file_download"

# Ejecutar el script
"$file_download"
