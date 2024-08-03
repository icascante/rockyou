sudo apt update && apt upgrade -y

sudo snap install --classic code 
sudo snap install --classic slack 
sudo snap install notion-snap 
sudo apt instal 

# Descargue la clave GPG de Docker y guárdela en /usr/share/keyrings
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Agregue el repositorio de Docker a la lista de fuentes
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Instale Docker
sudo apt install docker-ce -y

sudo usermod -aG docker ${USER} 

sudo apt-get install open-vm-tools-desktop -y 
sudo apt-get install jq -y

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

# Definir el nombre del archivo de salida
output_file="Maltego.v4.7.0.deb"

# Descargar el archivo usando wget con sobrescritura automática
wget -O "$output_file" "$download_url"

chmod +x "$output_file"
# Mostrar la URL descargada y el nombre del archivo de salida
echo "Archivo descargado desde: $download_url"
echo "Archivo guardado como: $output_file"

sudo dpkg -i "$output_file"

extensions=(
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "ms-python.python"
    "ms-dotnettools.csharp"
    "ms-azuretools.vscode-docker"
    "formulahendry.docker-explorer"
    "p1c2u.docker-compose"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
)

for extension in "${extensions[@]}"; do
    code --install-extension $extension
done

sudo apt install default-jre -y
 
sudo apt-get install gnome-shell-extension-dash-to-dock -y
sudo apt-get install dconf-editor
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock center true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true

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



