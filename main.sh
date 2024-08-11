#!/bin/bash
download_dir="$HOME/Downloads"

# URL de la página donde se encuentra el botón
url="https://netbeans.apache.org/front/main/download/"

# Descargar el contenido de la página
page=$(wget -qO- "$url")

# Extraer la línea que contiene el enlace con la clase "button success"
button_href=$(echo "$page" | grep -oP '<a[^>]*class="[^"]*button success[^"]*"[^>]*href="[^"]*"' | grep -oP 'href="[^"]*"' | sed 's/href="\([^"]*\)"/\1/')

# Comprobar si se ha encontrado el atributo href
if [ -z "$button_href" ]; then
    echo "No se encontró un atributo href en el enlace con la clase 'button success'."
    exit 1
fi

# Reemplazar "../../../" con "https://netbeans.apache.org/"
final_url=$(echo "$button_href" | sed 's#^\.\./\.\./\.\./#https://netbeans.apache.org/#')

url=$final_url

# Descargar el contenido de la página
page=$(wget -qO- "$url")

# Buscar la etiqueta <a> que tiene un href que termina en .deb
deb_link=$(echo "$page" | grep -oP '<a[^>]*href="[^"]*\.deb"[^>]*>.*?</a>')

# Comprobar si se ha encontrado algún enlace
if [ -z "$deb_link" ]; then
    echo "No se encontró ninguna etiqueta <a> con un href que termine en .deb."
else 
    href=$(echo $deb_link | grep -oP '(?<=href=")[^"]*')
    page=$(wget -qO- "$href")
    url=$(echo $page | grep -oP '(?<=<strong>)[^<]*\.deb' | head -n 1) 
    wget "$url" -O "$download_dir/netbeans.deb"

    # Instalar el archivo .deb
    sudo dpkg -i "$download_dir/netbeans.deb" 
fi
