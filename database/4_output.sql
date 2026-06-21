-- Print GLC en FNC por consola
CREATE OR REPLACE FUNCTION print_glc_fnc() RETURNS VOID AS $$
DECLARE
	n       int;
    var     text;
	glc_output text := CHR(10) || '';
	partes_der text[];
	parte_der text;
BEGIN
	FOR var IN 
		SELECT ordenado.parte_izq 
		FROM (
			SELECT parte_izq, start, tipo_produccion 
			FROM GLC_EN_FNC
			ORDER BY start DESC, tipo_produccion DESC, parte_izq DESC
		) AS ordenado
		GROUP BY ordenado.parte_izq
		LOOP
		glc_output :=  glc_output || var || ' --> ';
		partes_der := ARRAY[]::text[];
		SELECT ARRAY(SELECT CONCAT(parte_der1::text, ' ',parte_der2::text) FROM GLC_EN_FNC WHERE parte_izq = var) 
		FROM GLC_EN_FNC WHERE parte_izq = var 
		LIMIT 1 INTO partes_der;
		glc_output := glc_output || array_to_string(partes_der, ' | ') || CHR(10);
	END LOOP;
    RAISE NOTICE '%', glc_output;
END;
$$ LANGUAGE plpgsql;

SELECT print_glc_fnc();
