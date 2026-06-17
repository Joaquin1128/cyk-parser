-- ─────────────────────────────────────────────────────────────────────────────
-- Tests unitarios para el algoritmo CYK
-- Ejecutar después de cargar schema, gramática y funciones.
--
-- Resultado esperado de cada test:
--   test_1 → true   (JSON vacío válido)
--   test_2 → true   (JSON con un par numérico)
--   test_3 → false  (string inválido)
-- ─────────────────────────────────────────────────────────────────────────────

-- Test 1: JSON vacío
SELECT
    'test_1'                    AS test,
    cyk('{}')                   AS resultado,
    true                        AS esperado,
    cyk('{}') = true            AS ok;

-- Test 2: JSON con un par clave-valor numérico
SELECT
    'test_2'                    AS test,
    cyk('{"a":1}')              AS resultado,
    true                        AS esperado,
    cyk('{"a":1}') = true       AS ok;

-- Test 3: string inválido (falta la llave de cierre)
SELECT
    'test_3'                    AS test,
    cyk('{"a":1')               AS resultado,
    false                       AS esperado,
    cyk('{"a":1') = false       AS ok;
