#!/bin/bash
download_dir="$HOME/Downloads"

base_url="https://www.scootersoftware.com"
# URL de la página donde se encuentra el botón
url="https://www.scootersoftware.com/download"

# Descargar el contenido de la página
page=$(wget -qO- "$url")

# Extraer el valor del href que contiene el texto "Debian"
relative_href=$(echo $page | grep -oP '(?<=<a href=")[^"]*(?="[^>]*>Debian</a>)')
echo "valor $relative_href"
# Combinar la URL base con el href relativo

full_url="${base_url}${relative_href}"
echo "valor $full_url"
wget "$full_url" -O "$download_dir/comper.deb"

# Instalar el archivo .deb
sudo dpkg -i "$download_dir/comper.deb" 
sudo apt-get install -f -y