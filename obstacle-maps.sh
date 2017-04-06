
set -e

# исходный файл карт ОСМ
SOURCE_PBF_FILE=../source/russia.osm.pbf

# файл описания связки региона, полигона и описания
REGIONS_FILE=./obstacle-data/russia-regions.file

# путь до каталога poly с распакованными полигонами регионов субъектов РФ из http://gis-lab.info/qa/osm-poly.html
POLYGON_DIR=./

# каталог с нарезками карт ОСМ
OUTPUT_MAP_DIR=../source/maps
mkdir -p ${OUTPUT_MAP_DIR}

TARGET_DATA_DIR=../maps/data
mkdir -p ${TARGET_DATA_DIR}

TARGET_ROOT_DIR=../maps/root
mkdir -p ${TARGET_ROOT_DIR}

echo === 1. режем исходную карту на области ===
./cut-pbf.sh ${SOURCE_PBF_FILE} ${REGIONS_FILE} ${POLYGON_DIR} ${OUTPUT_MAP_DIR}

echo === 2. генерируем граф дорог ===
./gen-ghz.sh ${OUTPUT_MAP_DIR} ${POLYGON_DIR} ${REGIONS_FILE} org.fruct.oss.ghpriority.ObstacleMain ${TARGET_DATA_DIR}

echo === 3. генерируем карты ===
./gen-map.sh ${OUTPUT_MAP_DIR} ${REGIONS_FILE} ${TARGET_DATA_DIR}

echo === 4. Создаем XML файл ===
./gen-xml.sh ${TARGET_DATA_DIR} ${REGIONS_FILE} "http://gets.cs.karelia.ru/obstacle/maps/data/" >${TARGET_ROOT_DIR}/root.xml

echo === 5. Создаем архив регионов ===
./gen-regions-archive.sh  ${REGIONS_FILE} ${POLYGON_DIR} ${TARGET_ROOT_DIR}/russia-regions.zip

