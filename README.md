# Proyecto Diseño II

Proyecto de la segunda materia del segundo año de la carrera de Analista de Sistemas.

IDEA GENERAL: Se desea generar el sistema “BiosMessenger” para un sitio de intercambio de mensajes. Todo el 
acceso será mediante un único sitio web.

DESCRIPCIÓN DE LA REALIDAD:
Existen usuarios que mandan mensajes.
De los mensajes en general se sabe: 
1. Código Interno (único en el sistema – autogenerado )
2. Fecha y hora de generado el mensaje (automático en el momento de crearlo)
3. Asunto (no puede estar vacío) 
4. Texto del mensaje (no puede estar vacío) 
5. Cuándo caducan (es decir cuando ya no podrán mostrarse en las consultas – no implica que 
se eliminen). Un mensaje al menos deberá ser accesible un día
6. Usuario que lo envía 
7. Usuario/os que reciben el mensaje (un mensaje puede tener varios receptores, y un usuario 
puede enviar muchos mensajes)
8. Tipo de mensaje 

De los tipos de mensajes se sabe: su código (3 letras) y su nombre. Ejemplos: URG (urgente), IVT 
(invitación), EVT (eventos), etc.

FUNCIONALIDADES DEL SITIO WEB:

Página Web: Pagina Inicial del sitio (Default)
Actor Participante: publico
Resumen: Esta página permite que un usuario se loguee y acceda a la página principal de su 
mensajería. Para ello se deberá solicitar nombre de usuario y contraseña. La autenticación del 
empleado se deberá realizar manualmente y mediante el repositorio de datos del propio sistema. 
También deberá tenerse un acceso a la página de Alta Usuario. 
Además se mostraran estadísticas del sitio: cantidad de usuarios activos en el sistema; cantidad de mensajes 
enviados; cantidad de mensajes por tipo. 

Página Web: Alta Usuario
Actor Participante: publico
Resumen: Esta página permite que un visitante se cree un usuario en nuestro sistema. El nombre de 
usuario para loguearse debe ser único en el sistema (identificador) y contar con 8 caracteres 
exactamente. La contraseña debe ser de 6 de largo (5 letras y un número). También interesa saber su 
nombre completo y un mail de contacto. 

Página Web: Baja y Modificación Usuario Logueado
Actor Participante: Usuario
Resumen: Esta página permite modificar la información del usuario actualmente logueado, o que el 
mismo usuario se auto elimine del sistema. En este último caso, luego de la eliminación deberá 
desloguearse el usuario y volver a la página principal del sitio.

Página Web: ABM Tipos de Mensaje
Actor Participante: Usuario
Resumen: Esta página permite mantener la información de los tipos de mensaje del sistema. Se 
deberán determinar todos los datos mencionados en el apartado “Descripción de la Realidad”.
NO se podrán eliminar tipos de mensajes que tengas mensajes asociados. 

Página Web: Alta Mensaje 
Actor Participante: Usuario
Resumen: Esta página permite mantener información de los mensajes que envía el usuario. Se 
deberán determinar todos los datos del mensaje, mencionados en el apartado “Descripción de la 
Realidad”. NO se podrán eliminar ni modificar mensajes. Como un mensaje puede estar destinado 
a más de un usuario, esta lista debe manejarse conjuntamente con el mensaje.

Página Web: Bandeja de entrada
Actor Participante: Usuario
Resumen: Esta página permite mostrar todos los mensajes recibidos por el usuario actualmente 
logueado. La lista se despliega ordenada por fecha, siendo el primero en desplegarse el último 
mensaje en recibirse. Deberá desplegarse esta información en una grilla, con los siguientes datos: 
Fecha – Asunto – Remitente (usuario que lo envía). Si el usuario selecciona uno de estos mensajes, 
en un Control de tipo UserControl, se desplegara el mensaje completo (todos sus datos). Tomar en 
cuenta que los mensajes tienen fecha de caducidad, luego de la cual el mensaje no se mostrara en esa 
lista.
Además deberá contar al principio de la página con un cuadro de búsqueda, que poseerá: 
a) Filtro por tipo de Mensaje
b) Filtro por fecha de recepción (una fecha específica).
c) Botón de limpiar filtros (vuelve a mostrar todos los mensajes como al principio) 
El usuario podrá realizar siempre estos tipos de búsquedas, realizándose el filtrado mediante Linq to 
Entities (obligatorio).

Página Web: Bandeja de Salida
Actor Participante: Usuario
Resumen: Esta página permite mostrar todos los mensajes enviados por el usuario actualmente 
logueado. La lista se despliega ordenada por fecha, siendo el primero en desplegarse el último 
mensaje en enviarse. Deberá desplegarse esta información en una grilla, con los siguientes datos: 
Fecha – Asunto). Si el usuario selecciona uno de estos mensajes, en un Control de tipo 
UserControl, se desplegara el mensaje completo (todos sus datos).
Además deberá contar al principio de la página con un cuadro de búsqueda, que poseerá: 
a) Filtro por tipo de Mensaje
b) Filtro por fecha de envío (una fecha específica).
c) Botón de limpiar filtros (vuelve a mostrar todos los mensajes como al principio) 
El usuario podrá realizar siempre estos tipos de búsquedas, realizándose el filtrado mediante Linq to 
Entities (obligatorio).

** Tomar en cuenta que deberá tenerse una Master Page (para páginas del sitio no públicas), con:
1. Nombre del usuario actualmente logueado
2. Acceso para desloguearse del sitio
3. Menú principal con todas las acciones que pueda realizar el usuario.

REQUERIMIENTOS DE IMPLEMENTACIÓN:
Implementación completa del sistema con tecnologías .NET en lenguaje C#. 

La información deberá almacenarse obligatoriamente en una base de datos SQL Server.
El script de la base de datos debe generarse manualmente, sin la ayuda de un asistente. 

Deberá contener el Esquema de creación de la base de datos, Stored Procedures
necesarios para realizar todas las tareas solicitadas, e Inserción de datos de prueba. Las 
restricciones sobre datos deberán realizarse en la propia estructura de la tabla (uso
obligatorio de los modificadores unique, check, default). Tomar en cuenta que usuario se 
necesita para la ejecución del Sitio publicado.

Obligatorio la implementación del modelo a través de Entity Framework DataBase First.

La acción de eliminación (usuario) deberá ejecutar un Strored Procedure a través de EF 
manualmente. Obligatorio de implementar.
El resto de acciones se realizaran directamente a través del Modelo. Obligatorio de 
implementar.

Desarrollar el sitio web con (al menos) las funcionalidades especificadas, utilizando:
WebService: capa de comunicación entre la Interfaz Gráfica Usuaria (UI) y el modelo de 
EF. Obligatoriamente se deben comunicar los datos a través de los objetos de negocios 
establecidos. Estará publicado en un IIS que se contratará específicamente para la 
publicación del WS.
El sitio web del cliente estará instalado en otro servidor, diferente al contratado para 
alojar al WebService.

Requerimientos de Entrega:
Solución completa del Software,
Script de la base de datos y
MER.

Nota: todos los diagramas deberán ser generados con una herramienta para lenguaje UML. Estos deberán ser
entregados en forma digital: una copia del archivo original del diagrama y una copia en formato PDF o JPG
