# Tarea de la sesión 2: un CI de calidad para el taller

En esta tarea no escribes código. Otro equipo te dejó cambios preparados en la carpeta `tarea/` del repositorio: tú los aplicas, los integras con un pull request, miras qué dice el CI y sacas conclusiones.

Trabajas sobre tu **fork** del repositorio del taller, `lnds/taller-CEDCCDOFA01`. Cada parte tiene pasos con el comando exacto y lo que debes anotar de lo que ves.

Durante la tarea, todos los pull requests se abren **dentro de tu fork**, para que el CI corra en tu cuenta. La **entrega final** es distinta: es un pull request de tu fork al repositorio de `lnds`, y se explica al final de la guía.

Solo necesitas **git y Docker** en tu máquina. Usas dos terminales, las dos en la raíz del repositorio:

- **Tu terminal**: para `git` y para `docker`.
- **La terminal de herramientas**: para correr pruebas y analizadores. Se abre con `docker compose run --rm tools` y ve tu repositorio en `/work`. Lo que cambia en tu máquina aparece ahí al instante, y al revés.

Cada paso dice en cuál terminal va.

## Antes de empezar: tu fork

Todo lo que sigue ocurre en tu fork, no en el repositorio original. Si te saltas alguno de estos pasos, el CI no corre y la tarea no funciona.

1. Comprueba que Docker está corriendo. Si dice que no puede conectarse, abre Docker Desktop y espera a que termine de iniciar.

   ```console
   $ docker version
   ```

2. Comprueba que git sabe quién eres. Si alguno sale vacío, configúralo.

   ```console
   $ git config --global user.name
   $ git config --global user.email
   $ git config --global user.name "Tu Nombre"
   $ git config --global user.email "tu@correo"
   ```

3. En GitHub, abre <https://github.com/lnds/taller-CEDCCDOFA01> y pulsa **Fork** (arriba a la derecha). En «Owner» elige tu cuenta, deja marcada la casilla «Copy the `main` branch only» y pulsa **Create fork**. Quedas en `github.com/TU-USUARIO/taller-CEDCCDOFA01`.
4. **Habilita Actions en tu fork.** En tu fork, abre la pestaña **Actions**. Si ves un aviso de que los workflows no se están ejecutando en este fork, pulsa el botón verde **I understand my workflows, go ahead and enable them**. Sin esto, ningún pull request va a mostrar el CI.
5. Clona **tu fork**, no el original, y comprueba el remoto. Tu usuario debe aparecer en las dos líneas de `origin`. Si dice `lnds`, clonaste el original: borra la carpeta y clona de nuevo.

   ```console
   $ git clone https://github.com/TU-USUARIO/taller-CEDCCDOFA01.git
   $ cd taller-CEDCCDOFA01
   $ git remote -v
   ```

## Parte 0. Preparación

1. Tu terminal. Crea la rama de trabajo:

   ```console
   $ git switch -c tarea-2
   ```

2. Tu terminal. Construye la imagen de herramientas (una sola vez; entre uno y cuatro minutos, cerca de 1 GB):

   ```console
   $ docker compose build tools
   ```

3. Tu terminal. Abre la terminal de herramientas (sales con `exit`):

   ```console
   $ docker compose run --rm tools
   ```

4. Herramientas. Instala las dependencias de catalog:

   ```console
   $ cd /work/services/catalog && npm ci && cd /work
   ```

5. Herramientas. Corre las pruebas de los tres servicios. Anota cuántas pruebas pasan, cuántas fallan en cada servicio y cuánto tarda:

   ```console
   $ make test
   ```

6. Herramientas. Mide cuántos cambios al código detectan las pruebas de hoy. El script modifica el archivo de a un cambio por vez (por ejemplo, un `<` por `<=`), corre las pruebas y deja todo como estaba. Anota cuántos mutantes salen `MUERTO` y cuántos `SOBREVIVE`:

   ```console
   $ tarea/mutar.sh services/catalog/src/shifts.ts
   ```

7. Herramientas. Mide la cobertura de catalog. Busca la fila de `shifts.ts` y anota su porcentaje y las líneas que quedan sin cubrir:

   ```console
   $ cd /work/services/catalog && npm run coverage
   ```

8. Crea el archivo `docs/conclusiones-sesion-2.md` con un título por parte (0 a 6). Ahí vas anotando.

**Anota:** los resultados de los pasos 5, 6 y 7. Son tus números de partida, y los vas a comparar más adelante.

## Parte 1. Un bug, de rojo a verde

Los usuarios reportaron: «El domingo era mi último día de turno, hubo un SEV2 y no me llegó nada.»

La regla 8 de `docs/dominio.md` dice que un turno cubre desde `start_date` hasta `end_date`, ambos días incluidos. El otro equipo te mandó dos cambios: primero una prueba que demuestra el bug, después la corrección.

1. Tu terminal. Aplica la prueba y mira qué trae. Anota qué archivo cambió y cuántas líneas se agregaron:

   ```console
   $ git apply tarea/01-prueba-que-falla.patch
   $ git diff --stat
   ```

2. Herramientas. Corre las pruebas de catalog. Anota el valor observado (cuántas pasan y cuántas fallan), compáralo con lo que viste en la Parte 0 e indica si hubo mejora:

   ```console
   $ cd /work/services/catalog && npm test
   ```

3. Tu terminal. Sube **solo la prueba**:

   ```console
   $ git commit -am "test: el último día del turno debe estar cubierto"
   $ git push -u origin tarea-2
   ```

4. En GitHub, abre un pull request de `tarea-2` hacia `main` **de tu fork**. Anota el color de cada job del CI y, en el job que falla, qué pruebas fallan.

   **Cuidado con la base.** Al crear un pull request desde un fork, GitHub propone como destino el repositorio original. En la pantalla «Open a pull request» mira el primer desplegable, «base repository»: si dice `lnds/taller-CEDCCDOFA01`, cámbialo a `TU-USUARIO/taller-CEDCCDOFA01`, con base `main`. Antes de crear el pull request, la línea de arriba debe mostrar solo dos ramas: `base: main` y `compare: tarea-2`. Durante la tarea, si lo creas contra `lnds`, queda en un repositorio ajeno y tu CI no corre: ciérralo y ábrelo de nuevo. Solo la entrega final, al terminar, va contra `lnds`.

   Que no sea borrador: el CI no corre en los borradores.

5. Tu terminal. Aplica la corrección y mira qué trae. Anota qué cambió:

   ```console
   $ git apply tarea/02-correccion.patch
   $ git diff
   ```

6. Herramientas. Corre las pruebas otra vez. Anota el valor observado y compáralo con el del paso 2:

   ```console
   $ npm test
   ```

7. Tu terminal. Sube la corrección y mira el CI del pull request. Anota el color de los jobs:

   ```console
   $ git commit -am "fix: el turno cubre también su último día"
   $ git push
   ```

**Anota:** antes de estos cambios el CI estaba en verde y el bug ya existía. ¿Qué te dice eso de un CI en verde? ¿Por qué conviene que la prueba llegue en un commit aparte, antes de la corrección?

## Parte 2. ¿Las pruebas detectan cambios?

Todo en la terminal de herramientas.

1. Repite la medición de mutantes de la Parte 0, ahora con los dos cambios integrados. Anota cuántos mutantes mueren y cuántos sobreviven, y compara con la Parte 0:

   ```console
   $ cd /work && tarea/mutar.sh services/catalog/src/shifts.ts
   ```

2. Mide la cobertura de catalog otra vez. Anota el porcentaje de `shifts.ts` y el cambio respecto de la Parte 0:

   ```console
   $ cd /work/services/catalog && npm run coverage
   ```

3. Mide la cobertura de los otros dos servicios. Anota el total de cada uno:

   ```console
   $ cd /work/services/incidents && uv run pytest --cov=incidents
   $ cd /work/services/notifications && go test -cover ./...
   ```

**Anota:**
- Mutantes muertos y sobrevivientes, antes y después, y el cambio.
- Cobertura de `shifts.ts` antes y después. ¿Cambió? ¿Estaba cubierto el código del bug cuando el bug existía?
- Una línea cubierta, ¿está verificada?
- Quedan mutantes que sobreviven. ¿Qué significa para el CI? ¿Qué le pedirías al equipo dueño de ese código?

## Parte 3. Análisis estático

Herramientas, desde `/work`. Anota lo que reporta cada comando:

```console
$ km score
$ km smells
$ km infra smells
```

**Anota:** la nota del proyecto, los tres archivos con peor nota y el tipo de hallazgo más frecuente. De lo que reportó `km infra smells`, qué es un riesgo real y qué es ruido, con una línea de justificación por cada uno.

## Parte 4. Dependencias y secretos

Herramientas. Estos comandos consultan bases de vulnerabilidades en internet, así que los resultados cambian con el tiempo. Anota lo que ves en cada uno.

1. Dependencias de catalog. Anota cuántas vulnerabilidades hay en total y cuántas quedan al dejar fuera las dependencias de desarrollo, y cuáles son altas:

   ```console
   $ cd /work/services/catalog && npm audit
   $ npm audit --omit=dev
   ```

2. Dependencias de incidents:

   ```console
   $ cd /work/services/incidents
   $ uv export --frozen --no-dev --no-hashes --no-emit-project -o /tmp/req.txt
   $ pip-audit -r /tmp/req.txt --no-deps --disable-pip
   ```

3. Dependencias de notifications. Fíjate en las líneas `Found in` y `Fixed in`:

   ```console
   $ cd /work/services/notifications && govulncheck ./...
   ```

4. Secretos en el historial de git. Mira en qué archivos están:

   ```console
   $ cd /work && gitleaks detect --redact -v
   ```

5. Haz el **triaje**. En `docs/conclusiones-sesion-2.md`, una tabla con al menos cuatro hallazgos de los pasos anteriores, cada uno con su decisión: **corregir**, **aceptar** (con justificación) o **posponer** (con fecha).
6. Corrige la vulnerabilidad alta de catalog y comprueba. Anota cuántas vulnerabilidades quedan y si las pruebas siguen pasando:

   ```console
   $ cd /work/services/catalog && npm install --save-exact zod@4.6.7
   $ npm audit --omit=dev
   $ npm test
   ```

7. Corrige las de incidents y comprueba. Repite los dos comandos del paso 2, y anota qué dicen ahora y si las pruebas siguen pasando:

   ```console
   $ cd /work/services/incidents
   $ uv lock --upgrade-package certifi --upgrade-package opentelemetry-api
   $ uv run pytest
   ```

8. Tu terminal. Sube las correcciones y espera el CI:

   ```console
   $ git commit -am "fix(deps): actualiza zod, certifi y opentelemetry-api"
   $ git push
   ```

**Anota:** la tabla de triaje. ¿Qué hallazgo fue el más difícil de decidir y por qué? ¿Por qué los hallazgos de Go no se arreglan con un comando como los otros? Uno de los hallazgos de secretos está en la carpeta `tarea/`: ¿es un secreto real?

## Parte 5. El gate en el CI

Hasta aquí corriste los controles a mano. Ahora quedan en el CI, para que ningún pull request pase sin ellos. El workflow ya viene escrito.

1. Tu terminal. Copia el workflow a su lugar y súbelo:

   ```console
   $ cp tarea/gate-calidad.yml .github/workflows/gate-calidad.yml
   $ git add .github/workflows/gate-calidad.yml
   $ git commit -m "ci: agrega el gate de calidad"
   $ git push
   ```

2. En el pull request, mira los jobs nuevos `calidad-y-seguridad` y `construye-imagenes`. Anota su color. Si `calidad-y-seguridad` falla en un paso de dependencias, vuelve a los pasos 6 y 7 de la Parte 4.
3. Abre `tarea/gate-calidad.yml` y ubica cada paso del job `calidad-y-seguridad`. No hay que cambiar nada: identifica qué comando de las partes 3 y 4 corre cada uno, y cuál lleva `continue-on-error: true`.
4. Exige los jobs `calidad-y-seguridad` y `construye-imagenes` como requisito del merge, igual que en la sesión 1, pero **en tu fork**: **Settings**, **Branches**, y en la regla de `main` (si no existe, **Add classic branch protection rule** con `main` como patrón) marca **Require status checks to pass before merging**, busca `calidad-y-seguridad` y `construye-imagenes`, selecciónalos y guarda. Los jobs aparecen en el buscador solo después de haber corrido una vez, por eso este paso va después del paso 2.
5. Comprueba que el gate **bloquea**. Tu terminal. Aplica el parche y mira qué trae. Anota qué cambió en `compose.yaml`:

   ```console
   $ git switch -c prueba-gate
   $ git apply tarea/03-secreto.patch
   $ git diff
   $ git commit -am "prueba: secreto literal en compose.yaml"
   $ git push -u origin prueba-gate
   ```

6. En GitHub, abre un segundo pull request, de `prueba-gate` hacia `main` de tu fork. Revisa otra vez que «base repository» sea `TU-USUARIO/taller-CEDCCDOFA01` y no `lnds`. Anota el color de `calidad-y-seguridad`, qué paso falla y cuántos secretos reporta ese paso.
7. Tu terminal. Quita el secreto, sube y mira `calidad-y-seguridad`. Anota el color:

   ```console
   $ git apply -R tarea/03-secreto.patch
   $ git commit -am "revierte el secreto de prueba"
   $ git push
   ```

8. Cierra ese segundo pull request **sin hacer merge** y vuelve a tu rama:

   ```console
   $ git switch tarea-2
   ```

**Anota:**
- Qué bloquea tu gate y qué deja pasar. Nombra un problema que se le escaparía.
- ¿Cuántos secretos reportó el paso y cuántos agregó el parche? Si no coinciden, ¿por qué? ¿Qué le pasará al próximo que cambie `compose.yaml`?
- El paso de notifications no bloquea aunque encuentra vulnerabilidades. ¿Es una buena decisión? ¿Hasta cuándo?
- Quitaste el secreto con un commit nuevo. ¿Sigue en el historial de la rama `prueba-gate`? ¿Qué habría que hacer si fuera un secreto real?

## Parte 6. Contenedores

Tu terminal: Docker está en tu máquina, no dentro de la imagen de herramientas.

1. Construye las tres imágenes:

   ```console
   $ docker build -t pager-incidents services/incidents
   $ docker build -t pager-catalog services/catalog
   $ docker build -t pager-notifications services/notifications
   ```

2. Compara los tamaños. Anota el de cada imagen:

   ```console
   $ docker images
   ```

3. Revisa `pager-incidents` contra la lista de una imagen reproducible. Anota qué cumple y qué no:
   - Versión fija de la base: abre `services/incidents/Dockerfile` y mira las líneas `FROM` y `COPY --from`.
   - Usuario sin privilegios:

     ```console
     $ docker inspect -f '{{.Config.User}}' pager-incidents
     ```

   - Sin secretos en las capas:

     ```console
     $ docker history pager-incidents
     ```

   - `.dockerignore` presente:

     ```console
     $ ls -a services/incidents
     ```

4. Arráncala con dos configuraciones distintas del puerto:

   ```console
   $ docker run -d --rm --name pager-a -p 9001:8080 pager-incidents
   $ docker run -d --rm --name pager-b -e PORT=9090 -p 9002:9090 pager-incidents
   ```

5. Abre <http://localhost:9001/health> y <http://localhost:9002/health>. Anota qué responde cada una. Sin base de datos el resto de la aplicación no funciona, y para esta prueba no hace falta.
6. Detén los dos contenedores:

   ```console
   $ docker stop pager-a pager-b
   ```

7. En el pull request, abre el job `construye-imagenes`. Es el mismo paso 1, corrido por el CI.

**Anota:** qué cumple la lista y qué no. ¿A qué se debe la diferencia de tamaño entre las tres imágenes? La misma imagen corrió en dos puertos sin reconstruirla: ¿por qué importa eso para desplegar?

## Registro de IA

Si usaste un asistente, anota en las conclusiones qué te propuso, qué aceptaste, qué corregiste y qué rechazaste. Una propuesta que silencia un control en vez de resolver el problema se rechaza.

## Qué entregas

Esta tarea vale el **60 %** de la nota del curso. El otro 40 % es la tarea de la sesión 4, levantar un postmortem.

La entrega es un **pull request de tu fork al repositorio de `lnds`**. Es el único que va a `lnds`: todos los anteriores se quedaron en tu fork.

1. Comprueba que tu rama `tarea-2` tiene todo en GitHub (`git push`) y que el CI de tu fork está en verde.
2. Comprueba que `docs/conclusiones-sesion-2.md` está en la rama, con:
   - lo que anotaste en cada parte;
   - la tabla de triaje;
   - la respuesta a estas tres preguntas, con evidencia de lo que viste:
     1. ¿Qué te dice la distancia entre «las pruebas pasan» y «las pruebas detectan»?
     2. De todos los controles que corriste, ¿cuál te dio más información y cuál menos?
     3. Si tuvieras una hora más, ¿qué agregarías al pipeline y por qué?
3. En GitHub, abre un pull request desde tu fork. Aquí **sí** el destino es el original: en «base repository» deja `lnds/taller-CEDCCDOFA01`, con base `main`, y en «head repository» tu fork, rama `tarea-2`. El título es `Tarea sesión 2: Nombre Apellido`.
4. En la descripción, escribe en tres líneas qué encontraste en la tarea.
5. No hagas merge de ese pull request: lo revisa el profesor.

El pull request debe incluir estos commits: la prueba, la corrección, las dependencias y el gate de calidad.
