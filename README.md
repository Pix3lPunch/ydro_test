# ydro_test

[![Build DEB Package](https://github.com/Pix3lPunch/ydro_test/actions/workflows/build_deb.yml/badge.svg)](https://github.com/Pix3lPunch/ydro_test/actions/workflows/build_deb.yml)

Переменные среды настройки сборки пакета для разработчиков размещены в '/builder/.env'

Описание переменных среды для сборки *.deb пакета:

* PYTHON_VER - версия python.
* DEPENDENCIES - требуемые зависимости для установки пакета.
* SRC_DIR - путь, до исходного кода собираемого модуля.

Описание переменных для сборки контейнера:

* COMPAT_LEVEL - уровень совместимости пакета.
* BUILD_DEPENDENCIES - зависимости для сборки модуля в *.deb пакет.
* MODULE_SRC - директория сборки.

Скрипт для сборки пакета находится в '/builder/scripts/build_deb.sh'

Исходный код с модулем для примера сборки размещен в директории 'src'
