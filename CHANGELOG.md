# Changelog
This library was deprecated in favor of AndesUI

## [5.26.3] - 2022-10-25
### Added
- Migracion de source publico en nexus para soportar fury

## [5.26.1] - 2020-11-09
### Changed
- Rollback  a Static Framework debido a que hay otras libs dependientes que de momento no están migradas a estáticas

## [5.26.0] - 2020-11-09
### Changed
- Migración a Static Framework

## [5.25.0] - 2020-11-09
### Added
- Soporte a Xcode 12

# v5.24.0
### Agregado
- Ahora se permite cambiar el font de MLButton.

# v5.23.0
### Cambiado
- 'MLTitledMultiLineTextField': Al setear el accessibilityIdentifier se lo asigna al textView.

# v5.22.0
### Cambiado
- Se comprimen los recursos con `kelli compress`

# v5.21.1
### Cambiado
- 'MLUITextField': Se cambia el formateo del contador.
- 'MLUITextField': Se cambia el tamaño por defecto del helper description para soportar centrado.

# v5.21.0
### Cambiado
- 'MLUITextField': Se agrega el helperDescription con label separado y se coloca el contador al lado derecho.

# v5.20.2
### Cambiado
- 'MLButton': Cuando se hace set button title se configura el accessibilityIdentifier sólo si no fue configurado previamente.

# v5.20.1
### Cambiado
- 'MLButton': Se agrega accessibilityIdentifier para que Appium lo encuentre

# v5.20.0
### Cambiado
- 'MLButton': Se agranda el area del tap cuando mientras se usa herramientas de accessibilidad.

# v5.19.0
### Cambiado
- 'MLSpinner': Se reduce el tiempo de la animacion de fadeIn/fadeOut a 50ms
- 'MLButton': Se agranda el area del tap cuando mientras se usa herramientas de accessibilidad.

# v5.18.0
- Fix modal full screen

# v5.17.0
### Agregado
- 'MLRadioButton': se corrigen los colores para que muestre los correspondientes a cada plataforma.

### Cambiado
- `MLTitledSingleLineTextField`: Soporte para setear error en MLTitledSingleLineTextField sin animación.

# v5.16.0
### Cambiado
- Se migra a xcode 11.3.1

### Agregado
- Se agrega soporte de prefix en `MLTitledSingleLineTextField`

# v5.15.0
### Agregado
- Se agrega size Large (default) y small a MLButton

# v5.14.0
### Arreglado
- 🛠 Fix `MLTitledMultiLineTextField` ignores delegate

# v5.13.0
### Agregado
- `MLTitledLineTextField`: Se agrega clase para sobre escribir método de borrado.

# v5.12.0
### Agregado
- Se agrega al stylesheet la property statusBarStyle como opcional de MLStyleSheetProtocol.

# v5.11.0
### Cambiado
- Se generan múltiples pod projects

# v5.10.1
### Arreglado
- `MLCheckBox`: Se corrigen los colores para que muestre los correspondientes a cada plataforma.  
- Se traen fixes de la version 5.9.1

# v5.9.1
### Arreglado
- Se ajusta prioridad del constraint en MLButton

# v5.9.0
### Agregado
- Se agrega el soporte de iconos en MLButton
- Se agrega ícono a MLButton según el guideline de AndesUI

# v5.8.0
### Agregado
- Min characters attribute and delegate for MLTitledSingleLineTextField
- Two main app background colors added to the StyleSheet as optionals

# v5.7.1
### Arreglado
- `MLSnackbar`: Se corrige el espaciado derecho para snackbars con title multiline cuando no hay button.

# v5.7.0
## Agregado
- Se agrega soporte para safe areas y tabbars en MLSnackbar.

# v5.6.0
## Arreglado
- Se cambia el nombre del método creditCardFontOfSize a monospaceFontOfSize
- Se agrega soporte para safe areas y tabbars en MLSnackbar.

# v5.5.0
## Agregado
- Add MLFullscreenModal sub module

# v5.4.0
## Agregado
- Se agrega fuente para tarjetas al protocolo de MLStyleSheetProtocol

# v5.2.0
## Arreglado
- Safe Areas on MLModal
- Crash when HTML parsing fails

# v5.1.0
### Nuevo
- Feature/checkbox update #15

# v5.0.1
### Arreglado
- `MLTitledLineTextField`: El ancho del AccessoryView no se calculaba correctamente. Se revierten los cambios del xib introducidos en el release 5.0.0

# v5.0.0
### Agregado
- Soporte para configurar el autocorrection type a los titled text fields

### Cambiado
- Condiciones de nullability de los titled text fields

# v4.2.0
### Agregado
- Implementacion de isEqual para MLButtonConfig

# v4.1.0
### Cambiado
- Modificaion de firmas de NSAttributeString+Html para soportar swift

# v4.0.0
### Agregado
- Se agrega el color warning al StyleSheet
- Se agrega el tipo warning al MLSnackBar
- Job de deploy publico

# v3.2.0
### Agregado
- Se incorpora property config a MLButton en reemplazo del atributo style que está deprecado.

# v3.1.0

### Cambiado
- Se elimina la dependencia con MLCommons
- Se agregaron las macros de nullability en la definición de MLButtonStylesFactory

# v3.0.0

### Arreglado
- Se arregla el seteo del default StyleSheet

### Agregado
- Se incorpora el StyleSheet para controlar los colores y fuentes de la lib

### Cambiado
- Se modifica el MLTextField para utilizar el StyleSheet y ajustarse al nuevo guideline visual
- Se modifica el MLSpinner para utilizar el StyleSheet
- Se modifica el MLModal para utilizar el StyleSheet
- Se modifica la factory del MLButton para utilizar el StyleSheet
- Se modifica el MLSnackBar para utilizar el StyleSheet y el nuevo guideline visual
