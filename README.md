# ydro_test

[![Build DEB Package](https://github.com/Pix3lPunch/ydro_test/actions/workflows/build_deb.yml/badge.svg)](https://github.com/Pix3lPunch/ydro_test/actions/workflows/build_deb.yml)

Переменные среды настройки сборки пакета для разработчиков размещены в '/builder/.env'

Описание переменных для разработчика:

* PYTHON_VER - версия python.
* DEPENDENCIES - требуемые зависимости.
* SRC_DIR - путь, до исходного кода, собираемого модуля.


Скрипт для сборки пакета находится в '/builder/scripts/build_deb.sh'

Исходный код с модулем для примера сборки размещен в директории 'src'
