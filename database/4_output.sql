-- Print GLC en FNC por consola
CREATE OR REPLACE FUNCTION print_glc_fnc() RETURNS VOID AS $$
DECLARE
    variable record;
    glc_output text := CHR(10) || '';
BEGIN
    FOR variable IN 
        SELECT 
            parte_izq,
            string_agg(CONCAT(parte_der1, ' ', parte_der2), ' | ') AS partes_der
        FROM GLC_EN_FNC
        GROUP BY parte_izq, start, tipo_produccion
        ORDER BY start DESC, tipo_produccion DESC, parte_izq DESC
    LOOP
        glc_output := glc_output || variable.parte_izq || ' --> ' || variable.partes_der || CHR(10);
    END LOOP;
    
    RAISE NOTICE '%', glc_output;
END;
$$ LANGUAGE plpgsql;

SELECT print_glc_fnc();
