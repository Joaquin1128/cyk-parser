-- Print GLC en FNC por consola
CREATE OR REPLACE FUNCTION print_glc_fnc() RETURNS VOID AS $$
DECLARE
    registro record;
    glc_output text := CHR(10) || '';
BEGIN
    -- Una sola consulta limpia que hace todo el trabajo
    FOR registro IN 
        SELECT 
            parte_izq,
            string_agg(CONCAT(parte_der1, ' ', parte_der2), ' | ') AS opciones
        FROM GLC_EN_FNC
        GROUP BY parte_izq, start, tipo_produccion
        ORDER BY start DESC, tipo_produccion DESC, parte_izq DESC
    LOOP
        -- El cuerpo del bucle queda sumamente legible
        glc_output := glc_output || registro.parte_izq || ' --> ' || registro.opciones || CHR(10);
    END LOOP;
    
    RAISE NOTICE '%', glc_output;
END;
$$ LANGUAGE plpgsql;

SELECT print_glc_fnc();
