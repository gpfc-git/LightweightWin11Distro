# Distribución Ligera Windows 11
Sistemas Operativos - Grado de Desarrollo Full-Stack

Pablo Novoa - Gonzalo Pérez Fernández-Corugedo

---
https://drive.google.com/drive/folders/1O__51oBibA1Ky09olc6TnBIOiurlDRNt?usp=drive_link

---

## Instrucciones

Realizar una distribución de Windows 11 usando la versión 22h2 con actualizaciones en lo posible  hasta la 25h2.

La distribución debe correr dentro de una máquina con poca memoria y poco recurso de Procesamiento.

Debe poderse instalar completamente sin interacción con el usuario (debe llegar hasta el momento en que se pueda hacer clic en botón Windows, sin interacción del usuario) (Uso de AutoUnattend.xml).
Esta distribución debe poderse correr en pendrive, sea RUFUS o VENTOY.
Debe tener un archivo de instalación desatendida donde se cree automáticamente un usuario local.
Debe tener una imagen de fondo de escritorio donde se reflejen los participantes del trabajo.
En lo posible cambiar el LOGO de Instalación de Windows el de arranque.
Deben instalar automáticamente 3 tres programas, (7zip o WinRAR + un emulador de juegos arcade con 1 o dos juegos arcade + Brave como navegador predeterminado) y accesos directos en inicio y escritorio.

Para la creación, deben usar los conocimientos adquiridos de Powershell, Regedit, DISM.

Deben realizar la Entrega enviando una Url del GitHub donde este cargado con su respectivo archivo readme que explique claramente los procesos, servicios, herramientas que se quitaron y optimizaron. así como una copia del archivo xml - AutoUnattend.xml

La Defensa del Producto final se realizara en los grupos designados en clase y tendrán 30 minutos cada equipo para sustentar las acciones y ser probadas.

---

## Requisitos y Entorno de Trabajo

Para construir la ISO y automatizar tareas post-instalación se trabajó en un entorno Windows con herramientas de despliegue.

**Requisitos:**

* **Windows ADK** instalado con el componente **Deployment Tools** (necesario para usar `oscdimg.exe`).
* Carpeta de trabajo:

  * `C:\ISO` → ISO extraída (contenido completo del medio).
  * `C:\Work` → recursos y archivos a integrar (Brave, 7-Zip, FBNeo, `DefaultAssociations.xml`, `Ivan.jpg`).

**Nota:** `oscdimg` no estaba en el PATH, por lo que se utilizó siempre la **ruta completa** al ejecutable.

---

## Estructura Final de Carpetas ($OEM$)

Se usó el método OEM:

* `C:\ISO\sources\$OEM$\$1\...`  → se copia a `C:\...` dentro de Windows instalado
* `C:\ISO\sources\$OEM$\$$\...` → se copia a `C:\Windows\...` dentro de Windows instalado
* `SetupComplete.cmd` vive en `C:\ISO\sources\$OEM$\$$\Setup\Scripts\SetupComplete.cmd`

**Árbol final recomendado:**

```
C:\ISO\sources\$OEM$\
 ├─ $1\
 │   ├─ Install\
 │   │   ├─ Brave\
 │   │   │   ├─ BraveBrowserStandaloneSetup.exe
 │   │   ├─ 7zip\
 │   │   │   ├─ 7zip.exe
 │   │   └─ Post\
 │   │       └─ PostInstall.cmd
 │   └─ Apps\
 │       └─ FBNeo\   (portable: fbneo.exe + carpetas)
 └─ $$\
     ├─ DefaultAssociations.xml
     ├─ Setup\
     │   └─ Scripts\
     │       └─ SetupComplete.cmd
     └─ Web\
         ├─ Wallpaper\Windows\img0.jpg
         └─ 4K\Wallpaper\Windows\img0_*.jpg
```

---

##  Cambios de la ISO propia

* Aplicaciones y características innecesarias eliminadas (Cortana, aplicaciones de Xbox, Correo y Calendario, Fotos, Clipchamp, WMP, Media Foundation de 32 bits, IIS, WSL, Edge heredado, muchos paquetes de idioma, fondos de pantalla, Explorador de archivos heredado, redes entre pares, Servidor de Escritorio remoto, etc.)

* Privacidad y telemetría reducidas mediante ajustes (registros de eventos, telemetría de aplicaciones, administración de BitLocker, notificaciones y protección contra manipulaciones de Windows Defender, entrega de datos/controladores de Windows Update, entrega de contenido y descargas automáticas de la Store)

* Comportamiento de Windows Update modificado (actualizaciones automáticas deshabilitadas, controladores excluidos de las actualizaciones de calidad, Delivery Optimization restringido, MRT y algunas experiencias de actualización en línea deshabilitadas)

* Windows Defender y protecciones relacionadas ajustadas (algunas protecciones y notificaciones deshabilitadas, DisableAntiSpyware habilitado)

* Inicio de servicios reconfigurado (por ejemplo, Búsqueda, Windows Update, WinRM, actualización de Edge y varios servicios auxiliares establecidos en manual o deshabilitados)

* OOBE simplificado y en su mayoría omitido (EULA y pantallas de cuenta ocultas, configuración inalámbrica omitida, OOBE de equipo y usuario omitidos; zona horaria y configuraciones regionales preconfiguradas a es-ES)

* Configuración regional del sistema y lenguaje de instalación preestablecidos en Español (España) con teclado español, incluyendo Windows PE y el sistema operativo instalado

* Comportamiento de instalación automática personalizado (imagen de SO compacta, inyección opcional de clave de producto, comportamiento de activación automática ajustado)

* Características de componentes como Impresión, impresión en PDF, Carpetas de trabajo, infraestructura MSRDC y la característica de Búsqueda de Windows deshabilitadas (según la lista de características de NTLite)

## Elementos adicionales

* Navegador Brave instalado silenciosamente y establecido como navegador predeterminado.

* Instalado 7-Zip.

* Instalado Emulador FinalBurn Neo.

* Cambiado el fondo de escritorio por foto propia.

---

## Información Técnica

### Estructura base
Se trabajó siempre sobre una ISO extraída en C:\ISO.
Se evitó NTLite; todo se hizo manualmente.
Estructura de carpetas:
~~~~
bat
mkdir C:\ISO
robocopy D:\ C:\ISO\ /E
~~~~

### Uso de OEM
~~~~
C:\ISO\sources\$OEM$\$1\...  → se copia a C:\... dentro de Windows instalado
C:\ISO\sources\$OEM$\$$\... → se copia a C:\Windows\... dentro de Windows instalado
SetupComplete.cmd vive en C:\ISO\sources\$OEM$\$$\Setup\Scripts\SetupComplete.cmd
~~~~

#### Estructura de carpetas:
~~~~
bat
mkdir "C:\ISO\sources\$OEM$\$1\Install\Brave" 2>nul
mkdir "C:\ISO\sources\$OEM$\$1\Install\7zip" 2>nul
mkdir "C:\ISO\sources\$OEM$\$1\Install\Post" 2>nul
mkdir "C:\ISO\sources\$OEM$\$1\Apps\FBNeo" 2>nul
mkdir "C:\ISO\sources\$OEM$\$$\Setup\Scripts" 2>nul
mkdir "C:\ISO\sources\$OEM$\$$" 2>nul
~~~~

### Brave
Problemas con instaladores “SilentSetup” y con ejecutar tareas pesadas en SetupComplete.
Solución:
Usar BraveBrowserStandaloneSetup.exe.
Ejecutarlo en un script de PostInstall, no directamente en SetupComplete.
Instalación silenciosa tras el primer logon.
~~~~
bat
copy /y "C:\Work\BraveBrowserStandaloneSetup.exe" "C:\ISO\sources\$OEM$\$1\Install\Brave\BraveBrowserStandaloneSetup.exe"

start /wait "" "C:\Install\Brave\BraveBrowserStandaloneSetup.exe" /silent /install
~~~~

### DefaultAssociations.xml
Se preparó para definir Brave como navegador por defecto.
Se copió a C:\Windows\DefaultAssociations.xml vía $OEM$\$$.
Método basado en exportar/importar asociaciones con DISM.
Aplica mejor a usuarios nuevos en Windows 11.
~~~~
bat
copy /y "C:\Work\DefaultAssociations.xml" "C:\ISO\sources\$OEM$\$$\DefaultAssociations.xml"
~~~~

### 7-Zip
El instalador dentro del ISO estaba truncado (tamaño incorrecto).
Se solucionó copiando correctamente el EXE oficial x64.
Se verificó con hashes SHA256.
Verificación con hash (para detectar truncado):
~~~~
bat
certutil -hashfile "C:\Work\7zip.exe" SHA256
certutil -hashfile "C:\ISO\sources\$OEM$\$1\Install\7zip\7zip.exe" SHA256
~~~~
Instalación silenciosa en PostInstall:
~~~~
bat
"C:\Install\7zip\7zip.exe" /S /D="C:\Program Files\7-Zip"
~~~~

### FBNeo
Tratado como aplicación portable.

### Copia completa de la carpeta con robocopy
Se creó acceso directo en C:\Users\Public\Desktop para todos los usuarios.
~~~~
bat
robocopy "C:\Work\FBNeo" "C:\ISO\sources\$OEM$\$1\Apps\FBNeo" /E
~~~~

### Arquitectura final de scripts
#### SetupComplete.cmd
Para evitar pantallazos negros
~~~~
bat
@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v PostInstall /t REG_SZ /d "\"C:\Install\Post\PostInstall.cmd\"" /f
exit /b 0
~~~~

#### PostInstall.cmd 
Instala Brave y 7-Zip.
Crea accesos directos.
Genera log en C:\Windows\Temp\PostInstall.log.

#### Recompilación de la ISO
Se usó oscdimg del Windows ADK.
Se generó una ISO booteable (BIOS + UEFI) desde C:\ISO.
~~~~
bat
"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe" -m -o -u2 -udfver102 -bootdata:2#p0,e,bC:\ISO\boot\etfsboot.com#pEF,e,bC:\ISO\efi\microsoft\boot\efisys.bin C:\ISO C:\Win11_Lite.iso
~~~~

### Logs para depuración
Sirvieron para detectar cuelgues, rutas incorrectas y códigos de salida.
~~~~
type C:\Windows\Temp\SetupComplete.log
type C:\Windows\Temp\PostInstall.log
type C:\Windows\Temp\BraveInstall.log
~~~~

---

### Fondo de Escritorio

#### Primer intento: política / registro (fallido)
Aplicar el fondo por política durante OOBE no es fiable porque Windows reaplica tema y cachés en el primer logon.
~~~~
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v Wallpaper /t REG_SZ /d "C:\Wall\Ivan.jpg" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v WallpaperStyle /t REG_SZ /d "10" /f
gpupdate /force
~~~~

#### Método Win32 considerado (no consistente en setup)
Forzar refresco del wallpaper funciona en sesión normal, pero no de forma consistente durante la instalación.
~~~~
rundll32.exe user32.dll,UpdatePerUserSystemParameters
~~~~

#### Estrategia final: reemplazo del wallpaper por defecto
Reemplazar los archivos que Windows usa por defecto garantiza que la imagen se aplique desde el primer inicio.
~~~~
C:\Windows\Web\Wallpaper\Windows\img0.jpg
C:\Windows\Web\4K\Wallpaper\Windows\img0_*.jpg
~~~~

#### Integración en la ISO con OEM\$$
OEM\$$ copia directamente a C:\Windows durante la instalación.
~~~~
mkdir "C:\ISO\sources\$OEM$\$$\Web\Wallpaper\Windows" 2>nul
copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\Wallpaper\Windows\img0.jpg"
~~~~

#### Variantes 4K del wallpaper
Copiar todas las resoluciones evita que Windows use una imagen cacheada distinta.
~~~~
mkdir "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows" 2>nul

copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows\img0_3840x2160.jpg"
copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows\img0_2560x1600.jpg"
copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows\img0_1920x1200.jpg"
copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows\img0_1920x1080.jpg"
copy /y "C:\Work\Ivan.jpg" "C:\ISO\sources\$OEM$\$$\Web\4K\Wallpaper\Windows\img0_1366x768.jpg"
~~~~

#### Limpieza del PostInstall
Al cambiar el wallpaper por defecto real, las políticas dejan de ser necesarias.
~~~~
:: eliminar reg add ... Personalization
:: eliminar gpupdate /force
~~~~

#### Validación tras instalar
Si los archivos existen con los nombres correctos, el fondo se aplica desde el primer logon.
~~~~
dir "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
dir "C:\Windows\Web\4K\Wallpaper\Windows"
~~~~

