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