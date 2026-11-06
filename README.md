# Traky 🤘 · v4

Hábitos y tareas con palancas. App web instalable (PWA) para iPhone, con cuenta de Google: cada persona tiene sus datos en Supabase y ve su progreso mes a mes.

## 1. Base de datos (una vez)
1. Supabase → **SQL Editor** → **New query**.
2. Pega todo `supabase.sql` y toca **Run**. Debe decir *Success*.

Crea la tabla `traky_data` (una fila por persona, solo visible para su dueño) y la vista `traky_progreso_mensual` para que tú consultes el progreso de todos desde Supabase.

## 2. Publicar la actualización
1. En tu repositorio de GitHub: **Add file → Upload files**.
2. Arrastra **todo el contenido** de esta carpeta: `index.html`, `privacidad.html`, `sw.js`, `manifest.webmanifest`, `supabase.sql`, `README.md` y las carpetas `icons` y `vendor`.
3. **Commit changes** y espera 1–2 minutos.

## 3. Revisa en Supabase
**Authentication → URL Configuration**:
- *Site URL:* `https://TU-USUARIO.github.io/traky/`
- *Redirect URLs:* la misma dirección.

Si no coincide exacta, Google te devuelve a otra página después de entrar.

## 4. En el iPhone
1. Abre Traky desde el ícono, con conexión. Si sigue igual, ciérrala desde el selector de apps y ábrela de nuevo. En **Hoy → ⚙ Ajustes** debe decir **v4**.
2. Verás la pantalla de entrada. Toca **Continuar con Google**.
3. La primera vez, todo lo que ya tenías en el teléfono se sube a tu cuenta.

## Cómo funciona
- **Cuenta:** login con Google vía Supabase. Cada persona solo puede leer y escribir su propia fila (Row Level Security).
- **Sin conexión:** el teléfono guarda una copia. Los cambios se suben solos al volver la señal. El estado se ve en Ajustes (*Sincronizado / Guardando… / Sin conexión*).
- **Varios dispositivos:** al abrir la app trae la versión más reciente de la cuenta. Si editas en dos equipos a la vez, gana el último cambio.
- **Eliminar de verdad:** "Eliminar definitivamente" borra el hábito y todas sus marcas, también en la cuenta.
- **Progreso mes a mes:** en **Hoy** y al final de **Hábitos → Mes**. Barras de los últimos 12 meses con el % cumplido sobre lo programado, el cambio vs el mes anterior, el promedio y el mejor mes. Toca un mes para abrirlo.
- **Usar sin cuenta:** "Usar solo en este teléfono" mantiene el modo anterior. Desde Ajustes se puede entrar con Google después.

## Publicar el login para cualquiera (Google)
Mientras la app esté en *Prueba* en Google Cloud, solo entran los correos agregados como usuarios de prueba. Para abrirla:
1. Google Auth Platform → **Información de la marca**:
   - Página principal: `https://TU-USUARIO.github.io/traky/`
   - Política de privacidad: `https://TU-USUARIO.github.io/traky/privacidad.html`
   - Dominios autorizados: `TU-USUARIO.github.io`
2. **Público → Publicar app**. Solo usa nombre y correo, así que no requiere verificación.

## Archivos
- `index.html` · toda la app. `Store` y `Sync` son el único punto que lee y escribe datos.
- `vendor/supabase.js` · cliente de Supabase (incluido para que funcione sin conexión).
- `privacidad.html` · política de privacidad que pide Google.
- `supabase.sql` · tabla, seguridad y vista de progreso.
- `sw.js` · funcionamiento sin conexión. Sube `VERSION` en cada publicación.
