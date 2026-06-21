-- ─────────────────────────────────────────────────────────────────────────────
-- Tests unitarios para el algoritmo CYK
-- Ejecutar después de cargar schema, gramática y funciones.
--
-- Resultado esperado de cada input:
--   {"a":10} → true   (JSON con un par clave-valor numérico)
--   {"a":10,"b":''hola''} → true   (JSON con múltiples pares clave-valor)
--   {"a":''hola'',"b":''chau'',"c":''''} → true   (JSON con valores string y string vacío)
--   {"a":10,"b":''hola'',"c":{"d":''chau'',"e":99},"f":{}} → true   (JSON con objetos anidados)
--   {} → true   (JSON vacío válido)
--   {"a":10,"b":''hola'',"c":{"d":''chau'',"e":99,"g":{"h":12}},"f":{}} → true   (JSON con objetos anidados en varios niveles)
--   {"a":1 → false  (string inválido: falta la llave de cierre)
--   {"a":} → false  (string inválido: falta el valor de una clave)
--   {"a":10"b":''hola''} → false  (string inválido: falta la coma entre pares)
-- ─────────────────────────────────────────────────────────────────────────────

-- Test 1: JSON con un par clave-valor numérico
SELECT
    '{"a":10}'             AS input,
    cyk('{"a":10}')::text AS resultado,
    'true'               AS esperado;

-- Test 2: JSON con múltiples pares clave-valor
SELECT
    '{"a":10,"b":''hola''}'                        AS input,
    cyk('{"a":10,"b":''hola''}')::text AS resultado,
    'true'                          AS esperado;

-- Test 3: JSON con valores string y string vacío
SELECT
    '{"a":''hola'',"b":''chau'',"c":''''}'                                 AS input,
    cyk('{"a":''hola'',"b":''chau'',"c":''''}')::text AS resultado,
    'true'                                   AS esperado;

-- Test 4: JSON con objetos anidados
SELECT
    '{"a":10,"b":''hola'',"c":{"d":''chau'',"e":99},"f":{}}' AS input,
    cyk('{"a":10,"b":''hola'',"c":{"d":''chau'',"e":99},"f":{}}')::text AS resultado,
    'true' AS esperado;

-- Test 5: JSON vacío
SELECT
    '{}'        AS input,
    cyk('{}')::text AS resultado,
    'true'          AS esperado;

-- Test 6: JSON con objetos anidados en varios niveles
SELECT
    '{"a":10,"b":''hola'',"c":{"d":''chau'',"e":99,"g":{"h":12}},"f":{}}' AS input,
    cyk('{"a":10,"b":''hola'',"c":{"d":''chau'',"e":99,"g":{"h":12}},"f":{}}')::text AS resultado,
    'true' AS esperado;

-- Test 7: string inválido (falta la llave de cierre)
SELECT
    '{"a":1'            AS input,
    cyk('{"a":1')::text AS resultado,
    'false'             AS esperado;

-- Test 8: falta el valor de una clave
SELECT
    '{"a":}'            AS input,
    cyk('{"a":}')::text AS resultado,
    'false'             AS esperado;

-- Test 9: falta la coma entre pares clave-valor
SELECT
    '{"a":10"b":''hola''}'                          AS input,
    cyk('{"a":10"b":''hola''}')::text AS resultado,
    'false'                           AS esperado;
