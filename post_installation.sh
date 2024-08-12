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


#!/bin/bash

# Obtener el directorio del escritorio del usuario actual
desktop_dir="$HOME/Desktop"
src_dir="$desktop_dir/src"

# Verificar si el directorio del escritorio existe
if [ ! -d "$desktop_dir" ]; then
    echo "El directorio del escritorio no existe en $desktop_dir"
    exit 1
fi

# Crear el directorio src si no existe
mkdir -p "$src_dir"

# Preguntar por el nombre de usuario
read -p "Nombre de usuario: " username

# Preguntar por el token de forma segura
read -s -p "Token de acceso personal: " token
echo

# Lista de URLs de repositorios privados
repos=(
    "https://github.com/VulnMatter/cli.git"
    "https://github.com/VulnMatter/api_server.git"
    "https://github.com/VulnMatter/engine_modules.git"
    "https://github.com/VulnMatter/infrastructure.git"
)

# Función para solicitar confirmación
confirm() {
    while true; do
        read -p "$1 [s/n]: " yn
        case $yn in
            [Ss]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Por favor responda s (sí) o n (no).";;
        esac
    done
}

# Cambiar al directorio src en el escritorio
cd "$src_dir"

# Iterar sobre cada repositorio y clonarlo en el directorio src
for repo_url in "${repos[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    if [ -d "$repo_name" ]; then
        echo "El directorio $repo_name ya existe en $src_dir."
        if confirm "¿Desea sobrescribir $repo_name?"; then
            echo "Eliminando $repo_name..."
            rm -rf "$repo_name"
            echo "Clonando $repo_url en $src_dir..."
            git clone "https://$username:$token@github.com/${repo_url#https://github.com/}"
            if [ $? -eq 0 ]; then
                echo "El repositorio $repo_url se ha clonado exitosamente en $src_dir."
            else
                echo "Hubo un error al clonar el repositorio $repo_url. Por favor, verifica tus credenciales e intenta nuevamente."
            fi
        else
            echo "Omitiendo la clonación de $repo_url."
        fi
    else
        echo "Clonando $repo_url en $src_dir..."
        git clone "https://$username:$token@github.com/${repo_url#https://github.com/}"
        if [ $? -eq 0 ]; then
            echo "El repositorio $repo_url se ha clonado exitosamente en $src_dir."
        else
            echo "Hubo un error al clonar el repositorio $repo_url. Por favor, verifica tus credenciales e intenta nuevamente."
        fi
    fi
done
 

# Cambiar la distribución del teclado a español (latinoamericano) temporalmente
setxkbmap -layout latam

# Editar el archivo de configuración del teclado para que el cambio sea permanente
sudo sed -i 's/XKBLAYOUT=.*/XKBLAYOUT="latam"/' /etc/default/keyboard

# Reconfigurar el teclado para aplicar los cambios
sudo dpkg-reconfigure -f noninteractive keyboard-configuration


