-- ─────────────────────────────────────────────────────────────────────────────
-- Tabla auxiliar para almacenar el input tokenizado durante la ejecución de CYK
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS cyk_input (
    pos   smallint PRIMARY KEY,
    token text
);

-- ─────────────────────────────────────────────────────────────────────────────
-- setear_matriz(fila int)
--
-- Llena todas las celdas del nivel `fila` de la matriz triangular.
--   fila = 1 → celdas (i,i): busca variables que producen el token en posición i
--   fila > 1 → celdas (i, i+fila-1): combina pares de celdas anteriores
-- ─────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION setear_matriz(fila int)
RETURNS void LANGUAGE plpgsql AS $$
DECLARE
    n       int;
    fila_i  int;
    fila_j  int;
    fila_k  int;
    vars    text[];
BEGIN
    SELECT COUNT(*) INTO n FROM cyk_input;

    IF fila = 1 THEN
        -- Fila 1: cada celda (fila_i, fila_i) recibe las variables que producen el token en posición fila_i
        FOR fila_i IN 1..n LOOP
            SELECT ARRAY(
                SELECT g.parte_izq
                FROM GLC_en_FNC g
                JOIN cyk_input t ON t.pos = fila_i
                WHERE g.tipo_produccion = 1
                  AND g.parte_der1 = t.token
            ) INTO vars;

            INSERT INTO matriz_cyk (i, j, x) VALUES (fila_i, fila_i, vars)
            ON CONFLICT (i, j) DO UPDATE SET x = EXCLUDED.x;
        END LOOP;

    ELSE
        -- Fila > 1: celda (fila_i, fila_j) donde fila_j = fila_i + fila - 1
        FOR fila_i IN 1..(n - fila + 1) LOOP
            fila_j := fila_i + fila - 1;
            vars := ARRAY[]::text[];

            -- Probar todas las particiones (fila_i..fila_k) y (fila_k+1..fila_j)
            FOR fila_k IN fila_i..(fila_j - 1) LOOP
                SELECT vars || ARRAY(
                    SELECT g.parte_izq
                    FROM GLC_en_FNC g
                    WHERE g.tipo_produccion = 2
                      AND g.parte_der1 = ANY(
                            SELECT UNNEST(m.x) FROM matriz_cyk m
                            WHERE m.i = fila_i AND m.j = fila_k
                          )
                      AND g.parte_der2 = ANY(
                            SELECT UNNEST(m.x) FROM matriz_cyk m
                            WHERE m.i = fila_k + 1 AND m.j = fila_j
                          )
                ) INTO vars;
            END LOOP;

            -- Deduplicar y guardar
            SELECT ARRAY(SELECT DISTINCT UNNEST(vars)) INTO vars;

            INSERT INTO matriz_cyk (i, j, x) VALUES (fila_i, fila_j, vars)
            ON CONFLICT (i, j) DO UPDATE SET x = EXCLUDED.x;
        END LOOP;
    END IF;
END;
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- cyk(input_str text) → boolean
--
-- Función principal. Tokeniza el string, inicializa la matriz y llama a
-- setear_matriz para cada nivel. Retorna true si S está en la celda (1, n).
-- ─────────────────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION cyk(input_str text)
RETURNS boolean LANGUAGE plpgsql AS $$
DECLARE
    tokens   text[];
    n        int;
    fila     int;
    pos_idx  int;
    inicio   text;
    result   boolean := false;
BEGIN
    -- Tokenizar caracter a caracter
    tokens := regexp_split_to_array(input_str, '');
    n      := array_length(tokens, 1);

    -- Limpiar estado anterior
    TRUNCATE cyk_input;
    DELETE FROM matriz_cyk;

    -- Cargar tokens en tabla auxiliar
    FOR pos_idx IN 1..n LOOP
        INSERT INTO cyk_input (pos, token) VALUES (pos_idx, tokens[pos_idx]);
    END LOOP;

    -- Obtener símbolo inicial
    SELECT parte_izq INTO inicio
    FROM GLC_en_FNC
    WHERE start = true
    LIMIT 1;

    -- Llenar la matriz nivel por nivel
    FOR fila IN 1..n LOOP
        PERFORM setear_matriz(fila);
    END LOOP;

    -- Verificar si el símbolo inicial está en la celda (1, n)
    SELECT inicio = ANY(x) INTO result
    FROM matriz_cyk
    WHERE matriz_cyk.i = 1 AND matriz_cyk.j = n;

    RETURN COALESCE(result, false);
END;
$$;
