sudo apt update && apt upgrade -y

sudo snap install --classic code 
sudo snap install --classic slack
sudo apt install chromium-browser -y 
sudo snap install notion-snap
# Instalacion de postman
sudo snap install postman 
sudo apt instal 
sudo apt install python3-pip -y
sudo apt install filezilla -y
sudo apt-get install shutter -y


# Descargue la clave GPG de Docker y guárdela en /usr/share/keyrings
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Agregue el repositorio de Docker a la lista de fuentes
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Instale Docker
sudo apt install docker-ce -y
sudo apt install python3.12-venv -y

sudo usermod -aG docker ${USER} 

sudo apt-get install open-vm-tools-desktop -y 
sudo apt-get install jq -y

# Instalacion de Maltego
#!/bin/bash

# Instalación de Maltego
# URL de la API
api_url="https://downloads.maltego.com/maltego-v4/info.json"

# Descargar el contenido JSON de la API
json=$(curl -s "$api_url")

# Extraer la URL del objeto con "os": "linux" y "file-type": ".deb" usando jq
download_url=$(echo "$json" | jq -r '.[] | select(.os == "linux" and .["file-type"] == ".deb") | .url')

# Verificar si la URL fue encontrada
if [ -z "$download_url" ]; then
    echo "No se encontró una URL para 'os': 'linux' y 'file-type': '.deb'"
    exit 1
fi

# Directorio de descargas del usuario actual
download_dir="$HOME/Downloads"

# Definir el nombre del archivo de salida
output_file="$download_dir/Maltego.v4.7.0.deb"

# Descargar el archivo usando wget con sobrescritura automática
wget -O "$output_file" "$download_url"

# Asegurarse de que el archivo sea ejecutable
chmod +x "$output_file"

# Mostrar la URL descargada y el nombre del archivo de salida
echo "Archivo descargado desde: $download_url"
echo "Archivo guardado como: $output_file"

# Instalar el archivo descargado
sudo dpkg -i "$output_file"

#Instalacion de MongoDB Compass
# URL de la página de instalación de MongoDB Compass
url="https://www.mongodb.com/docs/compass/current/install/"

# Descargar la página
page=$(wget -qO- "$url")

# Extraer el enlace de descarga del archivo .deb
download_url=$(echo "$page" | grep -oP 'https://downloads.mongodb.com/compass/mongodb-compass_[0-9.]+_amd64.deb' | head -n 1)

# Comprobar si se ha encontrado la URL de descarga
if [ -z "$download_url" ]; then
    echo "No se pudo encontrar la URL de descarga."
    exit 1
fi

# Descargar el archivo .deb
wget "$download_url" -O "$download_dir/mongodb-compass.deb"

# Instalar el archivo .deb
sudo dpkg -i "$download_dir/mongodb-compass.deb"

#Instalacion de helm
file_download="$download_dir/get_helm.sh"

# Descargar el archivo de script de Helm
curl -fsSL -o "$file_download" https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Dar permisos de ejecución
chmod 700 "$file_download"

# Ejecutar el script
"$file_download"

# Resolver dependencias si es necesario
sudo apt-get install -f 

#Installl netbeans.
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
    # Resolver dependencias si es necesario
    sudo apt-get install -f 
fi

#Instacion de beyonecomper
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


# code --list-extensions | xargs -I {} echo '"{}"'
extensions=(
    "alefragnani.project-manager"
    "almenon.arepl"
    "batisteo.vscode-django"
    "codezombiech.gitignore"
    "cstrap.python-snippets"
    "dbaeumer.vscode-eslint"
    "deerawan.vscode-dash"
    "demystifying-javascript.python-extensions-pack"
    "dongli.python-preview"
    "donjayamanne.git-extension-pack"
    "donjayamanne.githistory"
    "eamodio.gitlens"
    "esbenp.prettier-vscode"
    "formulahendry.docker-explorer"
    "hbenl.vscode-test-explorer"
    "kaih2o.python-resource-monitor"
    "kevinrose.vsc-python-indent"
    "littlefoxteam.vscode-python-test-adapter"
    "mgesbert.python-path"
    "mintlify.document"
    "ms-azuretools.vscode-docker"
    "ms-dotnettools.csharp"
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-vscode.test-adapter-converter"
    "njpwerner.autodocstring"
    "njqdev.vscode-python-typehint"
    "oderwat.indent-rainbow"
    "p1c2u.docker-compose"
    "pkief.material-icon-theme"
    "streetsidesoftware.code-spell-checker"
    "thebarkman.vscode-djaneiro"
    "trabpukcip.wolf"
    "xirider.livecode"
    "ziyasal.vscode-open-in-github"
    "genieai.chatgpt-vscode"
)

for extension in "${extensions[@]}"; do
    code --install-extension $extension
done

sudo apt install default-jre -y
sudo apt install default-jdk -y
 
sudo apt-get install gnome-shell-extension-dash-to-dock -y
sudo apt-get install dconf-editor
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
 

# Cambiar la distribución del teclado a español (latinoamericano) temporalmente
setxkbmap -layout latam

# Editar el archivo de configuración del teclado para que el cambio sea permanente
sudo sed -i 's/XKBLAYOUT=.*/XKBLAYOUT="latam"/' /etc/default/keyboard

# Reconfigurar el teclado para aplicar los cambios
sudo dpkg-reconfigure -f noninteractive keyboard-configuration



