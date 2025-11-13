## Propósito
Guía práctica para asistentes de código que trabajen en este repositorio "unideal". Contiene la arquitectura, convenciones de rutas, puntos de integración y ejemplos concretos para ser productivo rápidamente.

## Visión general
- Aplicación web estática con funcionalidades ligeras en PHP que consumen una base MySQL (`unideal`).
- Estructura: HTML en la raíz y `HTML/`, estilos en `CSS/`, scripts en `JS/`, endpoints en `PHP/`.
- Se espera ejecución local sobre XAMPP (Windows) en `c:\xampp\htdocs\unideal`.

## Archivos clave
- `index.html` — página principal; incluye `JS/buscador.js`.
- `HTML/*.html` — fichas de universidades y páginas internas (usar rutas relativas desde aquí).
- `JS/buscador.js` — autocomplete; prueba rutas `PHP/buscador.php` y `../PHP/buscador.php`. Consume JSON con {nombre, acronimo, url, tipo}.
- `PHP/buscador.php` — busca en `universidades` y `carreras`, devuelve JSON; usa `$links` para mapear acrónimos a páginas estáticas.
- `PHP/filtro.php` — recibe GET (`provincia, localidad, tipo`) y redirige según `Acronimo` usando su propio `$links`.
- `JS/testintereses.js` — lógica del test de intereses; busca el formulario con id interestTest y expone la función calculateResult que escribe en el contenedor result.

## Contrato mínimo al editar
- Mantener la firma JSON de `PHP/buscador.php` (campos: `nombre`, `acronimo`, `url`, `tipo`).
- Si creás páginas nuevas, actualizar ambos arrays `$links` en `PHP/buscador.php` y `PHP/filtro.php`.
- Si cambian nombres de columnas/tabla en BD, actualizar todas las consultas PHP correspondientes.

## Flujo de trabajo local (rápido)
1. Iniciar XAMPP (Apache + MySQL).
2. Colocar el repo en `c:\xampp\htdocs\unideal`.
3. Importar la base (PowerShell):

```powershell
cd c:\xampp\mysql\bin; .\mysql.exe -u root < c:\xampp\htdocs\unideal\unideal.sql
```

o usar phpMyAdmin para crear la DB `unideal`.
4. Abrir: `http://localhost/unideal/index.html` o `http://localhost/unideal/HTML/testintereses.html`.

## Patrones y convenciones específicas
- Rutas relativas: los scripts incluidos desde `HTML/` usan `../` para llegar a `PHP/` o `JS/`. Cuando añadas endpoints, considera registrar rutas absolutas (p. ej. `/unideal/PHP/...`) o actualizar `JS/buscador.js` para probar ambas rutas.
- Mapeo de acrónimos: `$links` en `PHP/buscador.php` y `PHP/filtro.php` mapean `Acronimo` → `HTML/<file>.html`. Al agregar universidades, seguir 3 pasos: insertar en BD, crear `HTML/<uni>.html`, añadir acrónimo en `$links`.
- `carreras.URL_Carrera`: si está vacío, `PHP/buscador.php` usa el enlace de la universidad por defecto.

## Errores comunes y diagnóstico rápido
- Autocomplete vacío: abrir DevTools → Network → comprobar llamada a `PHP/buscador.php` y la ruta usada.
- Redirecciones inesperadas desde `PHP/filtro.php`: inspeccionar el `Acronimo` retornado por la query y su presencia en `$links`.
- BD no accesible: asegurar que MySQL está corriendo y la DB `unideal` fue importada; credenciales por defecto en PHP: `root` sin contraseña.

## Resumen del esquema de la base de datos (extracto)
Tablas relevantes:

- `universidades` (ID_Universidad, ID_Localidad, Nombre_Universidad, Acronimo, Tipo, URL_Web)
- `carreras` (ID_Carrera, ID_Universidad, ID_Area, Nombre_Carrera, Duracion, Requisitos, URL_Carrera)
- `localidades` (ID_Localidad, ID_Provincia, Nombre_Localidad)
- `provincias` (ID_Provincia, Nombre_Provincia)
- `areas` (ID_Area, Nombre_Area)
- `usuarios` (ID_Usuario, Nombre_Usuario, Email, Contraseña, ID_Rol, Fecha_Creacion, ...)
- `roles` (ID_Rol, Nombre_Rol)

Notas:
- `Acronimo` en `universidades` se usa para mapping a páginas estáticas (ver `$links`).
- `URL_Carrera` puede ser externa; si está vacía, se enlaza a la página de la universidad.

## Esquema completo (extracto de columnas y tipos)
A continuación se listan las columnas y tipos de las tablas más editadas. Esto facilita modificaciones y consultas PHP.

- `universidades`:
	- `ID_Universidad` int(11) NOT NULL AUTO_INCREMENT
	- `ID_Localidad` int(11) NOT NULL
	- `Nombre_Universidad` varchar(150) NOT NULL
	- `Acronimo` varchar(20) DEFAULT NULL
	- `Tipo` varchar(40) DEFAULT NULL
	- `URL_Web` varchar(255) DEFAULT NULL

- `carreras`:
	- `ID_Carrera` int(11) NOT NULL AUTO_INCREMENT
	- `ID_Universidad` int(11) NOT NULL
	- `ID_Area` int(11) NOT NULL
	- `Nombre_Carrera` varchar(150) NOT NULL
	- `Duracion` varchar(50) DEFAULT NULL
	- `Requisitos` varchar(255) DEFAULT NULL
	- `URL_Carrera` varchar(255) DEFAULT NULL

- `localidades`:
	- `ID_Localidad` int(11) NOT NULL AUTO_INCREMENT
	- `ID_Provincia` int(11) NOT NULL
	- `Nombre_Localidad` varchar(100) NOT NULL

- `provincias`:
	- `ID_Provincia` int(11) NOT NULL AUTO_INCREMENT
	- `Nombre_Provincia` varchar(100) NOT NULL

- `areas`:
	- `ID_Area` int(11) NOT NULL AUTO_INCREMENT
	- `Nombre_Area` varchar(100) NOT NULL

- `usuarios`:
	- `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT
	- `Nombre_Usuario` varchar(100) NOT NULL (UNIQUE)
	- `Email` varchar(100) NOT NULL (UNIQUE)
	- `Contraseña` varchar(255) NOT NULL
	- `ID_Rol` int(11) NOT NULL DEFAULT 1
	- `Fecha_Creacion` datetime DEFAULT current_timestamp()

- `roles`:
	- `ID_Rol` int(11) NOT NULL AUTO_INCREMENT
	- `Nombre_Rol` varchar(50) NOT NULL

- `materias` (extracto):
	- `ID_Materia` int(11) NOT NULL AUTO_INCREMENT
	- `ID_Carrera` int(11) DEFAULT NULL
	- `Nombre_Materia` varchar(150) NOT NULL
	- `Año` int(11) DEFAULT NULL

- `pregrados` / `posgrados` (extracto):
	- `ID_Pregrado` / `ID_Posgrado` int(11) NOT NULL AUTO_INCREMENT
	- `ID_Universidad` int(11) NOT NULL
	- `ID_Area` int(11) NOT NULL
	- `Nombre_Pregrado` / `Nombre_Posgrado` varchar(150) NOT NULL

Notas de integridad:
- Varias tablas tienen claves foráneas (por ejemplo `carreras.ID_Universidad` → `universidades.ID_Universidad`) y ON DELETE CASCADE en muchas relaciones; tenlo presente cuando borres filas.


---

## Plantilla de Pull Request (PR)
Existe una plantilla práctica en `.github/PULL_REQUEST_TEMPLATE.md` para PRs que añaden universidades o carreras. Sigue esa checklist antes de pedir revisión.

Si querés, puedo añadir ejemplo de PR completado y/o extraer el esquema de tablas completo desde `unideal.sql`.
- `roles` (ID_Rol, Nombre_Rol)

Notas rápidas:
- Las columnas `Acronimo` en `universidades` se usan para mapear a páginas estáticas (ver `$links` en `PHP/*.php`).
- `carreras.URL_Carrera` puede contener enlaces externos; si está vacío, el código cae al link de la universidad.

---

## Plantilla de Pull Request (PR) sugerida
Ver archivo de plantilla `.github/PULL_REQUEST_TEMPLATE.md` para PRs relacionadas a añadir universidades o carreras.
