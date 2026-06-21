# CYK Parser - PostgreSQL

Implementación del algoritmo CYK (Cocke-Younger-Kasami) en PL/pgSQL para reconocer cadenas a partir de una gramática libre de contexto en Forma Normal de Chomsky (FNC).

Trabajo práctico de la materia Teoría de la Computación. La implementación principal reconoce expresiones JSON simples (objetos con pares clave-valor, valores numéricos, strings y anidamiento), y se incluye una segunda gramática de prueba para expresiones aritméticas.

## Estructura del repositorio

```
cyk-parser/
├── database/
│   ├── 1_schema.sql               Creación de tablas (GLC_en_FNC, matriz_cyk)
│   ├── 2_grammar.sql              Carga de la gramática JSON en FNC
│   ├── 3_functions.sql            Funciones setear_matriz() y cyk()
│   ├── 4_output.sql               Funciones de visualización (print_glc_fnc, print_matriz_cyk)
│   └── 5_grammar_aritmetica.sql   Gramática alternativa de expresiones aritméticas
├── docs/
│   ├── TP_CYK_2025C2.pdf          Enunciado del trabajo práctico
│   └── img/                       Árboles de parsing de los ejemplos desarrollados
├── scripts/
│   ├── config.sh                  Configuración de conexión a PostgreSQL
│   └── menu.sh                    Menú interactivo para operar el proyecto
├── tests/
│   └── tests.sql                  Tests unitarios del algoritmo CYK
└── README.md
```

## Requisitos

- PostgreSQL 13 o superior
- Cliente `psql` disponible en el PATH
- Bash (Git Bash en Windows, o cualquier shell POSIX en Linux/Mac)

## Configuración inicial

Editar `scripts/config.sh` con los datos de conexión a la base de datos local:

```bash
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="cyk"
DB_USER="postgres"
DB_PASS=""
```

Si `DB_PASS` se deja vacío, el menú la solicita por consola al ejecutar la primera acción que la requiera.

La base de datos (`cyk` en el ejemplo) debe existir previamente:

```sql
CREATE DATABASE cyk;
```

## Uso

Todo el flujo de trabajo se maneja desde el menú interactivo:

```bash
cd scripts
./menu.sh
```

Opciones disponibles:

| Opción | Acción |
|---|---|
| 1 | Crear schema (tablas) |
| 2 | Cargar funciones (`setear_matriz`, `cyk`, funciones de impresión) |
| 3 | Cargar gramática JSON |
| 4 | Cargar gramática aritmética |
| 5 | Mostrar la gramática actualmente cargada |
| 6 | Ejecutar CYK sobre un string ingresado por consola |
| 7 | Mostrar la matriz CYK de la última ejecución |
| 8 | Correr los tests unitarios |
| 9 | Eliminar todas las tablas |
| 0 | Salir |

### Flujo recomendado para una primera ejecución

1. Opción `1` — crea las tablas.
2. Opción `2` — carga las funciones.
3. Opción `3` o `4` — carga la gramática a utilizar.
4. Opción `5` — verifica que la gramática se cargó correctamente.
5. Opción `6` — evalúa strings de prueba.
6. Opción `7` — inspecciona la matriz construida por CYK.

Cargar una gramática nueva (opción 3 o 4) reemplaza por completo el contenido de la tabla `GLC_en_FNC`; solo puede haber una gramática activa a la vez.

## Diseño de la solución

### Modelo de datos

**`GLC_en_FNC`**: almacena las producciones de la gramática en FNC. Cada fila representa una producción de la forma `X → a` (terminal, `tipo_produccion = 1`) o `X → Y Z` (dos variables, `tipo_produccion = 2`). La columna `start` marca las producciones del símbolo inicial.

**`matriz_cyk`**: almacena la matriz triangular del algoritmo. Cada fila es una celda `(i, j)` con el array de variables que pueden derivar la subcadena entre las posiciones `i` y `j` del string de entrada.

**`cyk_input`**: tabla auxiliar que guarda el string de entrada tokenizado carácter a carácter, usada durante la ejecución de `cyk()`.

### Algoritmo

La función `cyk(input_str)` tokeniza el string carácter a carácter, inicializa la matriz y llama a `setear_matriz(fila)` para cada nivel, de 1 a `n`. Al finalizar, verifica si el símbolo inicial de la gramática pertenece a la celda `(1, n)`.

`setear_matriz(fila)` distingue dos casos:

- **Fila 1**: cada celda `(i, i)` se llena con las variables que producen directamente el carácter en esa posición.
- **Filas siguientes**: cada celda `(i, j)` se llena probando todas las particiones posibles de la subcadena y buscando producciones binarias cuyas dos partes deriven cada mitad.

### Gramática JSON

La gramática reconoce objetos JSON con claves entre comillas dobles, valores numéricos, valores string entre comillas simples y objetos anidados sin límite de profundidad. El proceso de diseño, limpieza (eliminación de producciones no generadoras, no alcanzables, épsilon y unitarias) y normalización a FNC está documentado en `docs/`.

### Gramática aritmética

Gramática alternativa para expresiones aritméticas con operadores `+ - * /` y paréntesis, usada para validar que la implementación de CYK es independiente de la gramática cargada.

## Tests

```bash
psql -h localhost -U postgres -d cyk -f tests/tests.sql
```

O mediante la opción `8` del menú. Los tests verifican tanto strings válidos como inválidos contra la gramática JSON.

## Limitaciones conocidas

El llenado de la matriz para strings largos tiene un costo computacional elevado debido a las subconsultas repetidas dentro de los loops anidados de `setear_matriz`. Para inputs de más de ~50 caracteres el tiempo de ejecución puede ser considerable.
