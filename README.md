
# MLUI

[![Build Status](https://travis-ci.com/mercadolibre/mobile-ios_ui.svg?token=7FLbnHbLmp4qqdEmsLyy&branch=develop)](https://travis-ci.com/mercadolibre/mobile-ios_ui) [![codecov](https://codecov.io/gh/mercadolibre/mobile-ios_ui/branch/development/graph/badge.svg?token=aJvOhV7JqA)](https://codecov.io/gh/mercadolibre/mobile-ios_ui)

Es una libería de iOS con componentes comunes de UI para las aplicaciones nativas de MercadoLibre.
El repositorio también cuenta con ejemplos de como utlizar cada componente y código de muestra para ayudar al desarrollador a utilizar los diferentes componentes.
Todos los ejemplos se encuentran en la sección de Example.

Los componentes ya creados se encuentran en la carpeta LibraryComponentes.
Es vital respetar la estructura para correcto parseo del podspec a la hora de generar el pod.

## ¿Cómo crear un nuevo componente de UI?

## Uso

Para correr el proyecto , clonar el repo, y correr `pod install` desde el directorio root.


## Requerimientos
Tener acceso a los repositorios privados de MercadoLibre
Este repositorio pertenece al grupo mobile.

## Instalación

MLUI esta disponible por medio de [MercadoLibre Mobile Pods](https://github.com/mercadolibre/mobile-ios_specs). Para instalar, hacer lo siguiente:
Primero agregar el repositorio privado a tu instalación de pods.

`pod repo add MLPods https://github.com/mercadolibre/mobile-ios_specs.git`

Luego simplemente agregar la siguiente linea a tu Podfile

pod "MLUI" , "#version"

Para instalar subdependecias simplemente hacer.

pod "MLUI/#nombreDepencia" , "#version"

Ejemplo pod "MLUI/ActionButton"

Para más información sobre Pods ir a [CocoaPods](http://cocoapods.org/)

## Autor

MercadoLibre Mobile, mobile@mercadolibre.com


## Licencia
MLUI es propiedad de MercadoLibre.
Ver el archivo LICENSE para más información

