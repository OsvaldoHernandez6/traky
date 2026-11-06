# Traky 🤘

Hábitos y tareas con palancas, en una hoja simple. App web instalable (PWA) para iPhone: se abre a pantalla completa, funciona sin conexión y guarda los datos en el teléfono.

## Publicarla (una vez, ~10 minutos)

### Opción A · GitHub Pages
1. Entra a github.com y crea un repositorio nuevo, por ejemplo `traky` (puede ser público).
2. En el repositorio: **Add file → Upload files**, arrastra **todo el contenido** de esta carpeta (`index.html`, `manifest.webmanifest`, `sw.js` y la carpeta `icons`) y confirma con **Commit changes**.
3. Ve a **Settings → Pages**. En *Build and deployment* elige **Deploy from a branch**, rama `main`, carpeta `/ (root)` y guarda.
4. Espera 1–2 minutos. Tu app quedará en `https://TU-USUARIO.github.io/traky/`.

### Opción B · Netlify (sin cuenta de GitHub)
1. Entra a app.netlify.com/drop.
2. Arrastra esta carpeta completa. Te da un link `https://algo.netlify.app` al instante.

## Instalarla en el iPhone
1. Abre el link en **Safari** (tiene que ser Safari).
2. Toca **Compartir** (el cuadrado con la flecha) → **Agregar a inicio** → **Agregar**.
3. Abre Traky desde el ícono 🤘. Desde ahí funciona como cualquier app, también sin conexión.

## Tus datos
- Se guardan en el iPhone, dentro de la app instalada. Cerrar o reiniciar el teléfono no los borra.
- Se pierden si borras la app de la pantalla de inicio. Por eso: **Hoy → ⚙ Ajustes → Exportar respaldo** de vez en cuando (se guarda en Archivos o donde elijas). Con **Importar respaldo** lo recuperas, también en otro teléfono.
- La versión que abres en Safari y la instalada guardan datos por separado: usa siempre la del ícono.

## Hábitos: Semana y Mes
- **Semana** (se abre por defecto): anillos de los 7 días, lista para marcar con un toque y cómo te fue con cada hábito esta semana. Toca un día para marcar días anteriores; con las flechas cambias de semana.
- **Mes**: tu línea de progreso, mantra, rachas y una tira de 30 días por hábito. Toca un hábito para marcar hoy, un punto del gráfico para abrir ese día, o ••• para editar el hábito.

## Historial de hábitos
- Lo que marcas queda guardado por fecha. Si cambias la frecuencia de un hábito, el cambio rige desde ese día: los meses anteriores no se reescriben.
- **Archivar** (desde el hábito): deja de aparecer desde hoy y su historial sigue visible en los meses anteriores. Se puede reactivar en Hoy → ⚙ Ajustes → Hábitos archivados.
- **Eliminar definitivamente**: borra el hábito y todas sus marcas de todos los meses. No se puede deshacer.

## Actualizar la app
Si cambias `index.html`, sube el archivo de nuevo y en `sw.js` cambia `VERSION` (por ejemplo `traky-v2`). La app se actualiza sola la próxima vez que la abras con conexión. Tus datos no se tocan.

## Estructura
- `index.html` · toda la app (Hoy, Hábitos, Tareas). La capa `Store` es el único lugar que lee y escribe datos: para sincronizar con una base de datos (Supabase, Firebase) se reemplaza solo esa parte.
- `manifest.webmanifest` · nombre, ícono y modo pantalla completa.
- `sw.js` · funcionamiento sin conexión.
- `icons/` · ícono 🤘.
