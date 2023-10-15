#!/bin/bash

#!/bin/bash

# Obtener la última versión de Go desde la API de GitHub
latest_version=$(curl -s https://api.github.com/repos/golang/go/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

# Seleccionar la arquitectura del sistema
arch=$(uname -m)
case $arch in
    x86_64) arch="amd64";;
    i686)   arch="386";;
    *)
        echo "Arquitectura $arch no soportada"
        exit 1
        ;;
esac

# Construir la URL de descarga
download_url="https://golang.org/dl/go${latest_version}.linux-${arch}.tar.gz"

# Descargar e instalar Go
echo "Descargando Go $latest_version..."
curl -O $download_url
sudo tar -C /usr/local -xzf go${latest_version}.linux-${arch}.tar.gz

# Actualizar las variables de entorno
echo "Actualizando variables de entorno..."
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Limpiar archivos descargados
rm go${latest_version}.linux-${arch}.tar.gz

echo "¡Go $latest_version se ha instalado correctamente!"
