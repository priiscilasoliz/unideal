<!-- Plantilla de PR para cambios que añaden universidades o carreras -->
# Título: [Tipo] - Breve descripción

Resumen corto del cambio:

Checklist para PR "Añadir universidad"
- [ ] Inserté fila en la base de datos (`unideal`.`universidades`) o proporcioné script SQL en la PR.
- [ ] Creé la página HTML `HTML/<mi_universidad>.html` con contenido básico (logo, contacto, listado de carreras si aplica).
- [ ] Añadí el acrónimo y la ruta en los arrays `$links` de `PHP/buscador.php` y `PHP/filtro.php`.
- [ ] Verifiqué que la búsqueda (autocomplete) resuelva correctamente y que la URL apunte al archivo HTML.
- [ ] Si la universidad tiene carreras, incluí `carreras` correspondientes en `unideal.sql` o en el script de migración.

Checklist para PR "Añadir carrera"
- [ ] Inserté fila(s) en la tabla `carreras` (ID_Universidad debe existir).
- [ ] Añadí `URL_Carrera` si existe (si es externa, usar URL absoluta; si es interna, usar la página de la universidad).
- [ ] Verifiqué que `PHP/buscador.php` retorna la carrera en pruebas locales (consulta LIKE '%q%').
- [ ] Actualicé cualquier página HTML que deba listar la nueva carrera.

Notas para el revisor
- Revisar que las rutas relativas funcionen desde `/index.html` y desde páginas dentro de `/HTML/`.
- Ejecutar localmente: importar `unideal.sql` y abrir `http://localhost/unideal/index.html`.

Cómo probar rápido (PowerShell):
```powershell
cd c:\xampp\mysql\bin; .\mysql.exe -u root < c:\xampp\htdocs\unideal\unideal.sql
Start-Process "http://localhost/unideal/index.html"
```

Gracias por mantener la coherencia del sitio y la base de datos.
