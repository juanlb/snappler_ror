# Snappler Ror
## Este proyecto instala un entorno de desarrollo completo de Rails 3.16 en un Ubuntu 10.04 Desktop

- RVM
- Ruby 1.9.3
- Lamp-server
- Gmate (plugin de editor de ruby para Gedit)
- Netbeans


Y crea un script para crear proyectos Rails.
Al ejecutar:

    snp_rails NOMBRE_APP

Se crea:

- Gemset de RVM: `NOMBRE_APP-gemset`
- Crea el archivo `.rvmrc` con `rvm use 1.9.3@NOMBRE_APP-gemset`
- Rails 3.1.6
- Todas las gemas necesarias para que ejecute de primera
- `set_netbeans-gems.sh`: script para que netbeans trabaje con las gemas del gemset
- Instalación y modificación de las gemas para debug en netbeans

## Instalación

- Bajar el proyecto
- Ejecutar `./empaquetar.sh` (la primera vez va a bajar la version correcta de Netbeans.)
- Crea el directorio `snappler-ror-install`, y dentro pone: `install-snappler-ror.sh` y `snappler-ror-sources.tar`.
- El directorio creado se puede tarear y distribuir.
- Para instalar, entrar en el directorio y ejecutar: `install-snappler-ror.sh`. 
- Cuando termina todo el proceso, realizar las configuraciones que indica el script sobre Netbeans


### Configuración de Netbeans

Abrir `Netbeans`.

Ir a:
- `Tools -> Ruby Platforms`
- Seleccionar Plataforma: `Ruby 1.9.3`
- Gem Home: `/home/USUARIO/.rvm/netbeans-gems`
- Gem Path, dejar SOLO: `/home/USUARIO/.rvm/gems/ruby-1.9.3-p194@global`

## Uso
Una vez instalado `Snappler Ror` en el sistema, se va a usar solamente en la `creacion` de nuevo proyectos.

- Ejecutar `snp_rails NOMBRE_APP`
- Crea las bases: `NOMBRE_APP_production`, `NOMBRE_APP_test`, `NOMBRE_APP_development` 
- Crea el usuario de base de datos `NOMBRE_APP_user` (pass: `NOMBRE_APP_pass`), con derechos totales sobre las bases mencionadas.
- Crea el gemset `NOMBRE_APP-gemset`, e instala ahi `Rails 3.1.6` y todas las gemas necesarias para que corra y para debug.
- Crea el script `set_netbeans-gems.sh`, que debe ser ejecutado `SIEMPRE, CADA VEZ` que se vaya a editar el proyecto en Netbenas.
- El proyecto se puede `debuguear` en Netbeans desde el inicio, sin necesidad de instalar gems adicionales.

## snp_rails_add_debug

Este comando agrega capacidades de debug a un proyecto existente.

- Tiene que tener archivo `.rvmrc`.
- Crea el script `set_netbeans-gems.sh`
