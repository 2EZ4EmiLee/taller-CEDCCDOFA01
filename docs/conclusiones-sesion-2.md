PARTE I

5- Herramientas. Corre las pruebas de los tres servicios. Anota cuántas pruebas pasan, cuántas fallan en cada servicio y cuánto tarda:

$ make test

root@5c012845aaf9:/work# make test
cd services/incidents && uv run pytest
Using CPython 3.12.16 interpreter at: /usr/local/bin/python3
Creating virtual environment at: .venv
      Built pager-incidents @ file:///work/services/incidents
Installed 36 packages in 362ms
............................................................................ [ 92%]
......                                                                       [100%]
82 passed in 6.43s
cd services/catalog && npm test

> pager-catalog@0.1.0 test
> vitest run


 RUN  v5.0.3 /work/services/catalog

stdout | tests/shifts.test.ts > POST /shifts > crea un turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > POST /shifts > rechaza un turno que se cruza con el vigente
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > lista los turnos
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > filtra por servicio
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts/current/:serviceId > devuelve quien está de guardia hoy
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 updated for checkout: Beto Díaz <beto@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > rechaza fechas invertidas
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/shifts.test.ts (17 tests) 211ms
 ✓ tests/services.test.ts (11 tests) 257ms

 Test Files  2 passed (2)
      Tests  28 passed (28)
   Start at  23:41:03
   Duration  1.36s (transform 47%, import 26%, tests 25%, worker 3%)

cd services/notifications && go test ./...


ok      github.com/lnds/pager/services/notifications    0.041s

6- Herramientas. Mide cuántos cambios al código detectan las pruebas de hoy. El script modifica el archivo de a un cambio por vez (por ejemplo, un < por <=), corre las pruebas y deja todo como estaba. Anota cuántos mutantes salen MUERTO y cuántos SOBREVIVE:

$ tarea/mutar.sh services/catalog/src/shifts.ts

root@5c012845aaf9:/work# tarea/mutar.sh services/catalog/src/shifts.ts
SOBREVIVE  línea 8    «<=» por «<»
SOBREVIVE  línea 8    «<» por «<=»
MUERTO     línea 8    «&&» por «||»
SOBREVIVE  línea 20   «<» por «<=»
SOBREVIVE  línea 20   «&&» por «||»

Mutantes: 5   muertos: 1   sobreviven: 4   puntaje: 20 %
root@5c012845aaf9:/work# cd /work/services/catalog && npm run coverage

> pager-catalog@0.1.0 coverage
> vitest run --coverage


 RUN  v5.0.3 /work/services/catalog
      Coverage enabled with v8

stdout | tests/shifts.test.ts > POST /shifts > crea un turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > POST /shifts > rechaza un turno que se cruza con el vigente
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > lista los turnos
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > filtra por servicio
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts/current/:serviceId > devuelve quien está de guardia hoy
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 updated for checkout: Beto Díaz <beto@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > rechaza fechas invertidas
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/services.test.ts (11 tests) 130ms
 ✓ tests/shifts.test.ts (17 tests) 139ms

 Test Files  2 passed (2)
      Tests  28 passed (28)
   Start at  23:42:59
   Duration  1.34s (transform 45%, import 31%, tests 18%, worker 7%)

 % Coverage report from v8
----------------------|---------|----------|---------|---------|--------------------
File                  | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s  
----------------------|---------|----------|---------|---------|--------------------
All files             |   65.74 |       50 |    62.5 |   66.14 |                    
 app.ts               |    82.6 |    59.32 |      80 |   83.96 | ...179-182,205-206 
 domain.ts            |     100 |      100 |     100 |     100 |                    
 json.ts              |      50 |      100 |      50 |      50 | 8                  
 memory-repository.ts |   82.97 |       44 |      88 |   88.23 | 38-41,59           
 repository.ts        |       0 |        0 |       0 |       0 | 26-133             
 server.ts            |       0 |        0 |       0 |       0 | 6-22               
 shifts.ts            |      80 |      100 |      80 |      80 | 15                 
----------------------|---------|----------|---------|---------|--------------------

7- Herramientas. Mide la cobertura de catalog. Busca la fila de shifts.ts y anota su porcentaje y las líneas que quedan sin cubrir:

$ cd /work/services/catalog && npm run coverage

root@5c012845aaf9:/work# cd /work/services/catalog && npm run coverage

> pager-catalog@0.1.0 coverage
> vitest run --coverage


 RUN  v5.0.3 /work/services/catalog
      Coverage enabled with v8

stdout | tests/shifts.test.ts > POST /shifts > crea un turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > POST /shifts > rechaza un turno que se cruza con el vigente
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > lista los turnos
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > filtra por servicio
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts/current/:serviceId > devuelve quien está de guardia hoy
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 updated for checkout: Beto Díaz <beto@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > rechaza fechas invertidas
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/services.test.ts (11 tests) 130ms
 ✓ tests/shifts.test.ts (17 tests) 139ms

 Test Files  2 passed (2)
      Tests  28 passed (28)
   Start at  23:42:59
   Duration  1.34s (transform 45%, import 31%, tests 18%, worker 7%)

 % Coverage report from v8
----------------------|---------|----------|---------|---------|--------------------
File                  | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s  
----------------------|---------|----------|---------|---------|--------------------
All files             |   65.74 |       50 |    62.5 |   66.14 |                    
 app.ts               |    82.6 |    59.32 |      80 |   83.96 | ...179-182,205-206 
 domain.ts            |     100 |      100 |     100 |     100 |                    
 json.ts              |      50 |      100 |      50 |      50 | 8                  
 memory-repository.ts |   82.97 |       44 |      88 |   88.23 | 38-41,59           
 repository.ts        |       0 |        0 |       0 |       0 | 26-133             
 server.ts            |       0 |        0 |       0 |       0 | 6-22               
 shifts.ts            |      80 |      100 |      80 |      80 | 15                 
----------------------|---------|----------|---------|---------|--------------------

PARTE 2

1 y 2- Repite la medición de mutantes de la Parte 0, ahora con los dos cambios integrados. Anota cuántos mutantes mueren y cuántos sobreviven, y compara con la Parte 0:

$ cd /work && tarea/mutar.sh services/catalog/src/shifts.ts

root@402bf4717258:/work# cd /work && tarea/mutar.sh services/catalog/src/shifts.ts
SOBREVIVE  línea 8    «<=» por «<»
MUERTO     línea 8    «&&» por «||»
SOBREVIVE  línea 20   «<» por «<=»
SOBREVIVE  línea 20   «&&» por «||»

Mutantes: 4   muertos: 1   sobreviven: 3   puntaje: 25 %
root@402bf4717258:/work# cd /work/services/catalog && npm run coverage

> pager-catalog@0.1.0 coverage
> vitest run --coverage


 RUN  v5.0.3 /work/services/catalog
      Coverage enabled with v8

stdout | tests/shifts.test.ts > POST /shifts > crea un turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > POST /shifts > rechaza un turno que se cruza con el vigente
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > lista los turnos
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > filtra por servicio
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts/current/:serviceId > devuelve quien está de guardia hoy
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 updated for checkout: Beto Díaz <beto@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > rechaza fechas invertidas
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/services.test.ts (11 tests) 146ms
 ✓ tests/shifts.test.ts (18 tests) 149ms

 Test Files  2 passed (2)
      Tests  29 passed (29)
   Start at  00:22:11
   Duration  1.04s (transform 42%, import 30%, tests 23%, worker 5%)

 % Coverage report from v8
----------------------|---------|----------|---------|---------|-----------------------------------------------
File                  | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s                             
----------------------|---------|----------|---------|---------|-----------------------------------------------
All files             |   65.74 |       50 |    62.5 |   66.14 |                                               
 app.ts               |    82.6 |    59.32 |      80 |   83.96 | ...07,116-117,159,163-164,174,179-182,205-206 
 domain.ts            |     100 |      100 |     100 |     100 |                                               
 json.ts              |      50 |      100 |      50 |      50 | 8                                             
 memory-repository.ts |   82.97 |       44 |      88 |   88.23 | 38-41,59                                      
 repository.ts        |       0 |        0 |       0 |       0 | 26-133                                        
 server.ts            |       0 |        0 |       0 |       0 | 6-22                                          
 shifts.ts            |      80 |      100 |      80 |      80 | 15                                            
----------------------|---------|----------|---------|---------|-----------------------------------------------

3- Mide la cobertura de los otros dos servicios. Anota el total de cada uno:

$ cd /work/services/incidents && uv run pytest --cov=incidents
$ cd /work/services/notifications && go test -cover ./...

root@402bf4717258:/work/services/catalog# cd /work/services/incidents && uv run pytest --cov=incidents
      Built pager-incidents @ file:///work/services/incidents
Uninstalled 1 package in 5ms
Installed 1 package in 4ms
..................................................................................                      [100%]
=============================================== tests coverage ================================================
______________________________ coverage: platform linux, python 3.12.16-final-0 _______________________________

Name                          Stmts   Miss  Cover
-------------------------------------------------
src/incidents/__init__.py         0      0   100%
src/incidents/admin.py           50      6    88%
src/incidents/api.py            493     82    83%
src/incidents/clients.py         47     28    40%
src/incidents/config.py           9      0   100%
src/incidents/domain.py          67      0   100%
src/incidents/main.py             8      8     0%
src/incidents/memory.py          95     15    84%
src/incidents/notifier.py        57      9    84%
src/incidents/repository.py      99     67    32%
-------------------------------------------------
TOTAL                           925    215    77%
82 passed in 7.35s

root@402bf4717258:/work/services/incidents# cd /work/services/notifications && go test -cover ./...
ok      github.com/lnds/pager/services/notifications    0.060s  coverage: 70.3% of statements

PARTE 3

$ km score
Code Health Score
──────────────────────────────────────────────────────────────────
 Project Score:  C (71.1)
 Files Analyzed: 23
 Total LOC:      2,679
──────────────────────────────────────────────────────────────────
 Dimension                 Weight   Score   Grade
──────────────────────────────────────────────────────────────────
 Cognitive Complexity         32%    34.0   F--  
 Duplication                  21%    91.9   A    
 Indentation Complexity       16%    87.0   A-   
 Halstead Effort              21%    82.9   B    
 File Size                    10%    95.8   A+   
──────────────────────────────────────────────────────────────────

 Files Needing Attention (worst per-file scores, excl. duplication)
──────────────────────────────────────────────────────────────────
 Score  Grade  File                                       Issues
──────────────────────────────────────────────────────────────────
  42.1  F-     services/incidents/src/incidents/api.py    Cognitive: 399
  51.8  F      services/notifications/server.go           Cognitive: 52
  52.6  F      services/catalog/src/app.ts                Cognitive: 76
  55.7  F      ...ces/incidents/src/incidents/memory.py   Cognitive: 46
  61.5  D      ...incidents/src/incidents/static/app.js   Cognitive: 42
  64.8  D+     ...s/incidents/src/incidents/notifier.py   Cognitive: 35
  76.4  C+     ...ices/incidents/src/incidents/admin.py   Cognitive: 18
  78.1  B-     scripts/seed.py                            Cognitive: 16
  90.4  A      ...ices/catalog/src/memory-repository.ts   
  90.7  A      tarea/mutar.sh                             
──────────────────────────────────────────────────────────────────

$ km smells
Code Smells
──────────────────────────────────────────────────────────────────────────────────────
 File                                            Total  magic  long  param  todo  comm
──────────────────────────────────────────────────────────────────────────────────────
 services/incidents/src/incidents/api.py            79     78     1      0     0     0
 services/catalog/src/app.ts                        23     22     1      0     0     0
 services/incidents/src/incidents/repository.py     14      3     0     11     0     0
 services/incidents/src/incidents/static/app.js      9      9     0      0     0     0
 services/incidents/src/incidents/memory.py          7      2     0      5     0     0
 services/incidents/src/incidents/notifier.py        6      4     1      1     0     0
 services/incidents/src/incidents/clients.py         5      5     0      0     0     0
 services/notifications/server.go                    2      1     1      0     0     0
 scripts/seed.py                                     1      0     1      0     0     0
 services/catalog/src/json.ts                        1      1     0      0     0     0
──────────────────────────────────────────────────────────────────────────────────────
 Total (10 files)                                  147    125     5     17     0     0

$ km infra smells

Infrastructure smells — security smells of infrastructure code
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 File                      Line  Smell              Detail
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
 compose.yaml              9     Hard-coded secret  `POSTGRES_PASSWORD` holds a literal
 compose.yaml              25    Hard-coded secret  `POSTGRES_PASSWORD` holds a literal
 compose.yaml              57    Hard-coded secret  `NOTIFICATIONS_API_KEY` holds a literal
 compose.yaml              83    Hard-coded secret  `NOTIFICATIONS_API_KEY` holds a literal
 compose.yaml              84    Hard-coded secret  `ADMIN_TOKEN` holds a literal
 .github/workflows/ci.yml  24    Unpinned           action `actions/checkout@v4` is not pinned to a commit
 .github/workflows/ci.yml  25    Unpinned           action `astral-sh/setup-uv@v6` is not pinned to a commit
 .github/workflows/ci.yml  40    Unpinned           action `actions/checkout@v4` is not pinned to a commit
 .github/workflows/ci.yml  41    Unpinned           action `actions/setup-node@v4` is not pinned to a commit
 .github/workflows/ci.yml  50    Unpinned           action `actions/upload-artifact@v4` is not pinned to a commit
 .github/workflows/ci.yml  62    Unpinned           action `actions/checkout@v4` is not pinned to a commit
 .github/workflows/ci.yml  63    Unpinned           action `actions/setup-go@v5` is not pinned to a commit
 .github/workflows/ci.yml  70    Unpinned           action `actions/upload-artifact@v4` is not pinned to a commit
 .github/workflows/ci.yml  80    Unpinned           action `actions/checkout@v4` is not pinned to a commit
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────

 14 smells in 2 of 6 files: hard-coded secret 5, unpinned 9


PARTE 4

1- Dependencias de catalog. Anota cuántas vulnerabilidades hay en total y cuántas quedan al dejar fuera las dependencias de desarrollo, y cuáles son altas:

$ cd /work/services/catalog && npm audit
$ npm audit --omit=dev

# npm audit report
4 vulnerabilities (2 moderate, 2 high)
- Total: 4 vulnerabilidades (2 moderate: @hono/node-server, hono; 2 high: vite, zod).
- Sin dependencias de desarrollo (--omit=dev): 3 vulnerabilidades (2 moderate: @hono/node-server, hono; 1 high: zod <4.6.6).
- Altas: vite (solo dev) y zod <4.6.6 (producción).

2- Dependencias de incidents:

$ cd /work/services/incidents
$ uv export --frozen --no-dev --no-hashes --no-emit-project -o /tmp/req.txt
$ pip-audit -r /tmp/req.txt --no-deps --disable-pip

Found 4 known vulnerabilities in 2 packages
Name              Version   ID              Fix Versions
----------------- --------- --------------- ------------
certifi           2026.7.22 PYSEC-2026-4320 2026.10.18
certifi           2026.7.22 PYSEC-2026-4320 2026.10.18
opentelemetry-api 1.45.0    CVE-2026-114603 1.45.1
opentelemetry-api 1.45.0    CVE-2026-126360 1.45.2

3- Dependencias de notifications. Fíjate en las líneas Found in y Fixed in:

$ cd /work/services/notifications && govulncheck ./...

Your code is affected by 37 vulnerabilities from the Go standard library.
- Found in: net/http@go1.23.12, crypto/tls@go1.23.12, crypto/x509@go1.23.12, net/url@go1.23.12, net/textproto@go1.23.12, encoding/asn1@go1.23.12, encoding/pem@go1.23.12, net@go1.23.12
- Fixed in: go1.24.8 hasta go1.26.11

4- Secretos en el historial de git. Mira en qué archivos están:

$ cd /work && gitleaks detect --redact -v

12:44AM INF 8 commits scanned.
12:44AM INF scanned ~466872 bytes (466.87 KB) in 438ms
12:44AM WRN leaks found: 7
- tarea/03-secreto.patch (línea 9: CATALOG_API_KEY)
- services/incidents/src/incidents/config.py (línea 10: NOTIFICATIONS_API_KEY)
- compose.yaml (líneas 57 y 83: NOTIFICATIONS_API_KEY)
- services/notifications/README.md (líneas 21 y 23: X-Api-Key)
- services/notifications/server.go (línea 15: defaultAPIKey)

5- Haz el triaje. En docs/conclusiones-sesion-2.md, una tabla con al menos cuatro hallazgos de los pasos anteriores, cada uno con su decisión: corregir, aceptar (con justificación) o posponer (con fecha).

| Hallazgo                                  | Servicio / Archivo | Decisión | Justificación / Fecha                                                                |
| -----------------------------------       | ------------------ | -------- | ------------------------------------------------------------------------------------ |
| zod <4.6.6 (High)                         | catalog            | Corregir | Severidad alta en producción; se actualiza a zod@4.6.7                               |
| certifi y opentelemetry-api (4 CVEs)      | incidents          | Corregir | Dependencias de producción con parches disponibles sin romper compatibilidad         |
| 37 CVEs en stdlib de Go (go1.23.12)       | notifications      | Posponer | Requiere actualizar versión del compilador Go e imagen base (fecha: 15-12-2026)      |
| hono y @hono/node-server (Moderate)       | catalog            | Posponer | Requiere actualización mayor fuera de rango con riesgo de ruptura (fecha: 10-12-2026)|
| vite (High, devDependency)                | catalog            | Aceptar  | Solo se usa en entorno de pruebas/build, nunca en el contenedor de producción        |
| CATALOG_API_KEY en tarea/03-secreto.patch | tarea/             | Aceptar  | Secreto ficticio de prueba preparado para validar el gate en la Parte 5              |

6- Corrige la vulnerabilidad alta de catalog y comprueba. Anota cuántas vulnerabilidades quedan y si las pruebas siguen pasando:

$ cd /work/services/catalog && npm install --save-exact zod@4.6.7
$ npm audit --omit=dev
$ npm test

root@c5456af5cb41:/work/services/incidents# cd /work/services/catalog && npm install --save-exact zod@4.6.7

up to date, audited 61 packages in 1s

16 packages are looking for funding
  run `npm fund` for details

3 vulnerabilities (2 moderate, 1 high)

To address issues that do not require attention, run:
  npm audit fix

To address all issues, run:
  npm audit fix --force

Run `npm audit` for details.
root@c5456af5cb41:/work/services/catalog# npm audit --omit=dev
# npm audit report

@hono/node-server  2.0.0 - 2.1.5
Severity: moderate
@hono/node-server: Unhandled `ECONNRESET` on the socket during an asynchronous WebSocket upgrade crashes the process - https://github.com/advisories/GHSA-qv5m-9pm6-hqp3
@hono/node-server: Backslash in the request path is parsed as a path separator, bypassing path-based access control at a reverse proxy - https://github.com/advisories/GHSA-jpvv-r467-5p4w
fix available via `npm audit fix --force`
Will install @hono/node-server@2.1.11, which is outside the stated dependency range
node_modules/@hono/node-server

hono  <=4.13.15
Severity: moderate
Hono: `mount()` and `app.mount()` can forward a path that bypasses middleware scoped inside the mount prefix - https://github.com/advisories/GHSA-4m76-xfj5-7975
Hono: RegExpRouter skips wildcard middleware for some route sets and for paths with an encoded line terminator - https://github.com/advisories/GHSA-h7mg-cq63-vhpq
Hono: `css` helper does not escape a closing tag split between the template and an interpolated value, allowing HTML injection - https://github.com/advisories/GHSA-3gg2-335m-rxc6
Hono: `csrf()` does not check requests sent by hyperlink auditing (`text/ping`) - https://github.com/advisories/GHSA-46wx-v44x-9hh2
Hono: `validator('form')` skips validation for `multipart/form-data` requests with extra parameters - https://github.com/advisories/GHSA-4h7h-rv7c-7m2v
fix available via `npm audit fix --force`
Will install hono@4.13.22, which is outside the stated dependency range
node_modules/hono

2 moderate severity vulnerabilities

To address all issues, run:
  npm audit fix --force
root@c5456af5cb41:/work/services/catalog# npm test

> pager-catalog@0.1.0 test
> vitest run


 RUN  v5.0.3 /work/services/catalog

stdout | tests/shifts.test.ts > POST /shifts > crea un turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > POST /shifts > rechaza un turno que se cruza con el vigente
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > lista los turnos
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts > filtra por servicio
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > GET /shifts/current/:serviceId > devuelve quien está de guardia hoy
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/services.test.ts (11 tests) 94ms
stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 created for checkout: Ana Soto <ana@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > cambia la persona del turno
shift 1 updated for checkout: Beto Díaz <beto@example.com>

stdout | tests/shifts.test.ts > PUT /shifts/:id > rechaza fechas invertidas
shift 1 created for checkout: Ana Soto <ana@example.com>

 ✓ tests/shifts.test.ts (18 tests) 111ms

 Test Files  2 passed (2)
      Tests  29 passed (29)
   Start at  01:30:34
   Duration  603ms (transform 43%, import 30%, tests 25%, worker 2%)


7- Corrige las de incidents y comprueba. Repite los dos comandos del paso 2, y anota qué dicen ahora y si las pruebas siguen pasando:

$ cd /work/services/incidents
$ uv lock --upgrade-package certifi --upgrade-package opentelemetry-api
$ uv export --frozen --no-dev --no-hashes --no-emit-project -o /tmp/req.txt
$ pip-audit -r /tmp/req.txt --no-deps --disable-pip
$ uv run pytest

root@c5456af5cb41:/work/services/catalog# cd /work/services/incidents
root@c5456af5cb41:/work/services/incidents# uv lock --upgrade-package certifi --upgrade-package opentelemetry-api
Resolved 38 packages in 535ms
root@c5456af5cb41:/work/services/incidents# uv export --frozen --no-dev --no-hashes --no-emit-project -o /tmp/req.txt
# This file was autogenerated by uv via the following command:
#    uv export --frozen --no-dev --no-hashes --no-emit-project -o /tmp/req.txt
annotated-doc==0.0.5
    # via fastapi
annotated-types==0.8.0
    # via pydantic
anyio==4.15.1
    # via
    #   httpx
    #   starlette
    #   watchfiles
certifi==2026.11.20
    # via
    #   httpcore
    #   httpx
click==8.5.0
    # via uvicorn
fastapi==0.142.2
    # via pager-incidents
h11==0.16.0
    # via
    #   httpcore
    #   uvicorn
httpcore==1.0.9
    # via httpx
httptools==0.8.0
    # via uvicorn
httpx==0.28.1
    # via pager-incidents
idna==3.20
    # via
    #   anyio
    #   httpx
opentelemetry-api==1.45.2
    # via fastapi
prometheus-client==0.26.0
    # via pager-incidents
psycopg==3.3.6
    # via pager-incidents
psycopg-binary==3.3.6 ; implementation_name != 'pypy'
    # via psycopg
psycopg-pool==3.3.3
    # via psycopg
pydantic==2.13.5
    # via fastapi
pydantic-core==2.46.5
    # via pydantic
python-dotenv==1.2.4
    # via uvicorn
pyyaml==6.0.3
    # via uvicorn
starlette==1.7.0
    # via fastapi
typing-extensions==4.16.0
    # via
    #   anyio
    #   fastapi
    #   opentelemetry-api
    #   psycopg
    #   psycopg-pool
    #   pydantic
    #   pydantic-core
    #   starlette
    #   typing-inspection
typing-inspection==0.4.4
    # via
    #   fastapi
    #   pydantic
tzdata==2026.5 ; sys_platform == 'win32'
    # via psycopg
uvicorn==0.54.0
    # via pager-incidents
uvloop==0.23.0 ; platform_python_implementation != 'PyPy' and sys_platform != 'cygwin' and sys_platform != 'win32'
    # via uvicorn
watchfiles==1.3.0
    # via uvicorn
websockets==17.2
    # via uvicorn
root@c5456af5cb41:/work/services/incidents# pip-audit -r /tmp/req.txt --no-deps --disable-pip
WARNING:pip_audit._cli:--no-deps is supported, but users are encouraged to fully hash their pinned dependencies
WARNING:pip_audit._cli:Consider using a tool like `pip-compile`: https://pip-tools.readthedocs.io/en/latest/#using-hashes
No known vulnerabilities found
root@c5456af5cb41:/work/services/incidents# uv run pytest
..................................................................................                                                        [100%]
82 passed in 3.15s

8- Tu terminal. Sube las correcciones y espera el CI:

$ git commit -am "fix(deps): actualiza zod, certifi y opentelemetry-api"
$ git push

emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git log -n 4 --stat
commit 7053875c54d62080a7894b7224fadac51f30578f (HEAD -> tarea-2, origin/tarea-2)
Author: Emile Coloma Narvaez <emile.coloma@live.cl>
Date:   Wed Nov 18 16:56:19 2026 -0800

    ci: agrega el gate de calidad

 .github/workflows/gate-calidad.yml | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

commit b1ed374bdf1129d0db94decf4c8098ef09ab1ddc
Author: Emile Coloma Narvaez <emile.coloma@live.cl>
Date:   Wed Nov 18 16:55:04 2026 -0800

    fix(deps): actualiza uv.lock para certifi y opentelemetry-api

 services/incidents/uv.lock | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

commit 08e6b438c194cb2bdd6959ecb4518bab92792259
Author: Emile Coloma Narvaez <emile.coloma@live.cl>
Date:   Wed Nov 18 16:53:25 2026 -0800

    fix(deps): actualiza zod, certifi y opentelemetry-api

 services/catalog/package-lock.json | 8 ++++----
 services/catalog/package.json      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)


 PARTE 5

1- Tu terminal. Copia el workflow a su lugar y súbelo:

$ cp tarea/gate-calidad.yml .github/workflows/gate-calidad.yml
$ git add .github/workflows/gate-calidad.yml
$ git commit -m "ci: agrega el gate de calidad"
$ git push

[tarea-2 7053875] ci: agrega el gate de calidad
 1 file changed, 104 insertions(+)
To https://github.com/2EZ4EmiLee/taller-CEDCCDOFA01.git
   b1ed374..7053875  tarea-2 -> tarea-2

2- En el pull request, mira los jobs nuevos calidad-y-seguridad y construye-imagenes. Anota su color:

      - Gate de calidad / calidad-y-seguridad: verde (Successful in 46s)
      - Gate de calidad / construye-imagenes: verde (Successful in 34s)

3- Abre tarea/gate-calidad.yml y ubica cada paso del job calidad-y-seguridad. Identifica qué comando de las partes 3 y 4 corre cada uno, y cuál lleva continue-on-error: true:

| Paso en calidad-y-seguridad         | Comando equivalente (Partes 3 y 4)                            | Bloquea el PR / Configuración                       |
| ----------------------------------- | ------------------------------------------------------------- | --------------------------------------------------- |
| Nota del código                     | km score --trend "$BASE" --fail-if-worse --gate-scope changed | Sí, si empeora la nota en archivos tocados          |
| Code smells                         | km smells --since-ref "$BASE"                                 | No (solo informa los hallazgos)                     |
| Seguridad de la infraestructura     | km infra smells --since-ref "$BASE" --fail-on ...             | Sí, si hay hard-coded-secret o empty-password       |
| Dependencias de catalog             | npm audit --omit=dev --audit-level=high                       | Sí, ante vulnerabilidades altas o críticas en prod  |
| Dependencias de incidents           | uv export ... + pip-audit -r ... --no-deps --disable-pip      | Sí, ante vulnerabilidades conocidas en producción   |
| Dependencias de notifications       | govulncheck ./...                                             | No, lleva `continue-on-error: true` (informa CVEs)  |
| Secretos                            | gitleaks detect --redact -v --log-opts="$BASE..HEAD"          | Sí, si detecta secretos en los commits del PR       |

4- En GitHub, protege main (Settings -> Branches, añade una regla para main si no hay) con Require status checks to pass before merging y selecciona calidad-y-seguridad y construye-imagenes:

- Regla de protección configurada en `main` con `Require status checks to pass before merging` activo y los checks requeridos `calidad-y-seguridad` y `construye-imagenes` seleccionados.

5- Tu terminal. Crea otra rama, aplica el secreto de prueba y súbela:

$ git switch -c prueba-gate
$ git apply tarea/03-secreto.patch
$ git diff
$ git commit -am "prueba: secreto literal en compose.yaml"
$ git push -u origin prueba-gate

emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git switch -c prueba-gate
Switched to a new branch 'prueba-gate'
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git apply tarea/03-secreto.patch
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git diff
diff --git a/compose.yaml b/compose.yaml
index d9f85ba..652d81a 100644
--- a/compose.yaml
+++ b/compose.yaml
@@ -63,6 +63,7 @@ services:
     build: ./services/catalog
     environment:
       DATABASE_URL: postgres://pager:pager@catalog-db:5432/catalog
+      CATALOG_API_KEY: ctl_live_********************************
     ports:
       - "8081:8080"
     healthcheck:
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git commit -am "prueba: secreto literal en compose.yaml"
[prueba-gate 0e8011d] prueba: secreto literal en compose.yaml
 1 file changed, 1 insertion(+)
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git push -u origin prueba-gate
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 384 bytes | 384.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
remote: 
remote: Create a pull request for 'prueba-gate' on GitHub by visiting:
remote:      https://github.com/2EZ4EmiLee/taller-CEDCCDOFA01/pull/new/prueba-gate
remote: 
To https://github.com/2EZ4EmiLee/taller-CEDCCDOFA01.git
 * [new branch]      prueba-gate -> prueba-gate
branch 'prueba-gate' set up to track 'origin/prueba-gate'.

6- Abre un segundo pull request de prueba-gate hacia main en tu fork y mira qué pasa. Anota el color del job calidad-y-seguridad, qué paso falla y cuántos secretos reporta:

- Color del job calidad-y-seguridad: Rojo (failed in 19s); construye-imagenes quedó en verde.
- Paso que falla: Seguridad de la infraestructura (`km infra smells --since-ref "$BASE" --fail-on hard-coded-secret,empty-password`).
- Secretos reportados: 6 secretos literales (`hard-coded secret`) en `compose.yaml` (incluyendo el nuevo `CATALOG_API_KEY` en la línea 66), además de 6 acciones `unpinned` en `.github/workflows/gate-calidad.yml` (12 smells en total). El paso `Secretos` (`gitleaks`) quedó omitido porque el job se detuvo al fallar el paso de infraestructura.
- Estado del botón de merge: Bloqueado por la regla de branch protection en `main`.

7- Quita el secreto de prueba para que el pull request quede limpio:

$ git apply -R tarea/03-secreto.patch
$ git commit -am "revierte el secreto de prueba"
$ git push

emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git apply -R tarea/03-secreto.patch
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git commit -am "revierte el secreto de prueba"
[prueba-gate 29adc9f] revierte el secreto de prueba
 1 file changed, 1 deletion(-)
emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 313 bytes | 313.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/2EZ4EmiLee/taller-CEDCCDOFA01.git
   0e8011d..29adc9f  prueba-gate -> prueba-gate

8- Cierra el segundo pull request en GitHub sin hacer merge y vuelve a tu rama:

$ git switch tarea-2

emile@root:/opt/curso-devops/taller-CEDCCDOFA01$ git switch tarea-2
Switched to branch 'tarea-2'
Your branch is up to date with 'origin/tarea-2'.