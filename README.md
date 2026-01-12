# Distribución Ligera Windows 11
Proyecto De Sistemas Operativos - Grado de Desarrollo Full-Stack

Pablo Novoa - Gonzalo Pérez Fernández-Corugedo

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

## Modificaciones

### Cambios de la ISO propia

* Aplicaciones y características innecesarias eliminadas (Cortana, aplicaciones de Xbox, Correo y Calendario, Fotos, Clipchamp, WMP, Media Foundation de 32 bits, IIS, WSL, Edge heredado, muchos paquetes de idioma, fondos de pantalla, Explorador de archivos heredado, redes entre pares, Servidor de Escritorio remoto, etc.)

* Privacidad y telemetría reducidas mediante ajustes (registros de eventos, telemetría de aplicaciones, administración de BitLocker, notificaciones y protección contra manipulaciones de Windows Defender, entrega de datos/controladores de Windows Update, entrega de contenido y descargas automáticas de la Store)

* Comportamiento de Windows Update modificado (actualizaciones automáticas deshabilitadas, controladores excluidos de las actualizaciones de calidad, Delivery Optimization restringido, MRT y algunas experiencias de actualización en línea deshabilitadas)

* Windows Defender y protecciones relacionadas ajustadas (algunas protecciones y notificaciones deshabilitadas, DisableAntiSpyware habilitado)

* Inicio de servicios reconfigurado (por ejemplo, Búsqueda, Windows Update, WinRM, actualización de Edge y varios servicios auxiliares establecidos en manual o deshabilitados)

* OOBE simplificado y en su mayoría omitido (EULA y pantallas de cuenta ocultas, configuración inalámbrica omitida, OOBE de equipo y usuario omitidos; zona horaria y configuraciones regionales preconfiguradas a es-ES)

* Configuración regional del sistema y lenguaje de instalación preestablecidos en Español (España) con teclado español, incluyendo Windows PE y el sistema operativo instalado

* Comportamiento de instalación automática personalizado (imagen de SO compacta, inyección opcional de clave de producto, comportamiento de activación automática ajustado)

* Características de componentes como Impresión, impresión en PDF, Carpetas de trabajo, infraestructura MSRDC y la característica de Búsqueda de Windows deshabilitadas (según la lista de características de NTLite)

### Elementos adicionales

* Navegador Brave instalado silenciosamente y establecido como navegador predeterminado.

* Instalado 7-Zip.

* Instalado Emulador FinalBurn Neo con ___ preinstalado.

* Cambiado el fondo de escritorio por foto propia.
