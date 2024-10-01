#!/bin/bash

# Verificar si el script se está ejecutando con privilegios de root
if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ser ejecutado como root" 
   exit 1
fi

# Ruta del archivo sources.list
FILE="/etc/apt/sources.list"

# Crear una copia de seguridad del archivo original
cp $FILE ${FILE}.bak

# Leer el archivo línea por línea
while IFS= read -r line; do
  # Si la línea está comentada y contiene "deb", y no es una línea vacía
  if [[ $line =~ ^#.*deb && $line != "" ]]; then
    # Eliminar el '#' al inicio de la línea
    new_line=$(echo "$line" | sed 's/^#//')
    # Eliminar espacios antes de "deb"
    new_line=$(echo "$new_line" | sed 's/^[[:space:]]*deb/deb/')
    # Reemplazar la línea en el archivo original
    sed -i "s|$line|$new_line|" $FILE
  fi
done < $FILE

echo "Líneas que contienen 'deb' han sido descomentadas y formateadas en $FILE. Una copia de seguridad fue creada en ${FILE}.bak"
