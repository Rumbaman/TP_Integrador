#! /bin/bash

# Ayuda
ayuda() {
	echo ""
	echo "Ayuda de la copia de respaldo"
	echo ""
	echo "Opcion:"
	echo "-help: Muestra esta ayuda."
	echo ""
	echo "Este script realiza copias de respaldo de los directorios:"
	echo "	/var/logs"
	echo "	/www_dir"
	echo ""
	echo "La nomenclatura del nombre de las copias de respaldo es:"
	echo ""
	echo "<nombre_del_directorio>_bkp_YYYMMDD.tar.gz"
	echo ""
	echo "Calendario de las copias de resplado:"
	echo "	/var/logs: Diario (00:00 hs)"
	echo "	/www_dir: Lun Mie Vie (23:00 hs)"
	echo ""
	echo "Las copias de respaldo se guardan en:"
	echo "	/backup_dir"
	echo ""
	exit 0
}

# Llama a "Ayuda"
if [ "$1" == "-help" ]; then
	ayuda
fi

# Captura de los directorios de Origen y Destino
ORIGEN="$1"
DESTINO="$2"

#echo ""
#read -p "Ingrese la ruta del directorio de ORIGEN: " ORIGEN
#echo ""
#read -p "Ingrese la ruta del directorio de DESTINO: " DESTINO
#echo ""

# Validacion del directorio de Origen
if [ ! -d "$ORIGEN" ]; then
	echo "ERROR: El directorio de Origen '$ORIGEN' no existe."
	exit 1
fi

# Validacion del directorio de Destino
if [ ! -d "$DESTINO" ]; then
	echo "ERROR: El directorio de Destino '$DESTINO' no existe."
	exit 1
fi

# Creacion del nombre del archivo de la copia de respaldo
NOMBRE_DIR=$(basename "$ORIGEN")
FECHA=$(date +%Y%m%d)
ARCHIVO="${NOMBRE_DIR}_bkp_${FECHA}.tar.gz"

# Ejecucion de la copia de respaldo
tar -czf "$DESTINO/$ARCHIVO" -C "$(dirname "$ORIGEN")" "$NOMBRE_DIR"

echo "Copia de respaldo finalizada."
echo ""
