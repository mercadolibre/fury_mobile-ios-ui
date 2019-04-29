# Sin Publicar
## Arreglado
- Se cambia el nombre del método creditCardFontOfSize a monospaceFontOfSize

# 5.2.0
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
