CREATE TABLE IF NOT EXISTS GLC_en_FNC (
    start           boolean,
    parte_izq       text,
    parte_der1      text,
    parte_der2      text,
    tipo_produccion smallint  -- 1: Var→terminal, 2: Var→Var1 Var2
);

CREATE TABLE IF NOT EXISTS matriz_cyk (
    i   smallint,
    j   smallint,
    x   text[],
    CONSTRAINT matriz_cyk_unique UNIQUE (i, j)
);
