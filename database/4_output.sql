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

-- Print matriz CYK
ORDER BY i ASC, j ASC;

CREATE OR REPLACE FUNCTION print_matriz_cyk() RETURNS VOID AS $$
DECLARE
 fila_i int;
 fila_j int;
 fila int;
 size_matriz int;
 matriz_output text := CHR(10) || '';
 variables_celda_matriz text[];
BEGIN
	SELECT MAX(j) into size_matriz FROM matriz_cyk;
	FOR fila IN REVERSE size_matriz..1 LOOP
		IF fila = 1 THEN
			FOR fila_i in 1..size_matriz LOOP
				SELECT x INTO variables_celda_matriz FROM matriz_cyk WHERE i = fila_i;
				matriz_output := matriz_output || 'X' || fila_i || fila_i || '={' || array_to_string(variables_celda_matriz, ',') || '} ';
			END LOOP;
		ELSE
			FOR fila_i IN 1..(size_matriz - fila + 1) LOOP
            	fila_j := fila_i + fila - 1;
				SELECT x INTO variables_celda_matriz FROM matriz_cyk WHERE i = fila_i and j = fila_j;
				matriz_output := matriz_output || 'X' || fila_i || fila_j || '={' || array_to_string(variables_celda_matriz, ',') || '} ';
			END LOOP;
		END IF;
		matriz_output := matriz_output || CHR(10);
	END LOOP;
	RAISE NOTICE '%', matriz_output;
END;
$$ LANGUAGE plpgsql;




