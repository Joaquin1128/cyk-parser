-- Gramática JSON en FNC
-- Terminales encapsulados: T_LA={  T_LC=}  T_CO=,  T_DQ="  T_SQ='  T_DOS=:

TRUNCATE GLC_en_FNC;

-- ─── S (símbolo inicial) ────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (true,  'S',    'T_LA', 'S1',    2);  -- S → { S1
INSERT INTO GLC_en_FNC VALUES (true,  'S',    'T_LA', 'T_LC',  2);  -- S → { }

-- ─── S1 ─────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'S1',   'A',    'T_LC',  2);  -- S1 → A }

-- ─── A ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'A',    'P',    'B',     2);  -- A → P B
INSERT INTO GLC_en_FNC VALUES (false, 'A',    'T_DQ', 'X1',   2);  -- A → " X1   ("D":'V')
INSERT INTO GLC_en_FNC VALUES (false, 'A',    'T_DQ', 'X6',   2);  -- A → " X6   ("D":'')
INSERT INTO GLC_en_FNC VALUES (false, 'A',    'T_DQ', 'X10',  2);  -- A → " X10  ("D":E)
INSERT INTO GLC_en_FNC VALUES (false, 'A',    'T_DQ', 'X13',  2);  -- A → " X13  ("D":S)

-- ─── X1..X5  para  "D":'V' ──────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'X1',   'D',    'X2',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X2',   'T_DQ', 'X3',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X3',   'T_DOS','X4',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X4',   'T_SQ', 'X5',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X5',   'V',    'T_SQ',  2);

-- ─── X6..X9  para  "D":'' ───────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'X6',   'D',    'X7',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X7',   'T_DQ', 'X8',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X8',   'T_DOS','X9',    2);
INSERT INTO GLC_en_FNC VALUES (false, 'X9',   'T_SQ', 'T_SQ',  2);

-- ─── X10..X12  para  "D":E ──────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'X10',  'D',    'X11',   2);
INSERT INTO GLC_en_FNC VALUES (false, 'X11',  'T_DQ', 'X12',   2);
INSERT INTO GLC_en_FNC VALUES (false, 'X12',  'T_DOS','E',     2);

-- ─── X13..X15  para  "D":S ──────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'X13',  'D',    'X14',   2);
INSERT INTO GLC_en_FNC VALUES (false, 'X14',  'T_DQ', 'X15',   2);
INSERT INTO GLC_en_FNC VALUES (false, 'X15',  'T_DOS','S',     2);

-- ─── P ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'P',    'T_DQ', 'X1',   2);  -- P → " X1
INSERT INTO GLC_en_FNC VALUES (false, 'P',    'T_DQ', 'X6',   2);  -- P → " X6
INSERT INTO GLC_en_FNC VALUES (false, 'P',    'T_DQ', 'X10',  2);  -- P → " X10
INSERT INTO GLC_en_FNC VALUES (false, 'P',    'T_DQ', 'X13',  2);  -- P → " X13

-- ─── B ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'B',    'T_CO', 'P',     2);  -- B → , P
INSERT INTO GLC_en_FNC VALUES (false, 'B',    'T_CO', 'X16',   2);  -- B → , X16

-- ─── X16  para  ,PB ─────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'X16',  'P',    'B',     2);  -- X16 → P B

-- ─── D ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'C',    'D',     2);  -- D → C D
-- D → terminal (letras minúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'a',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'b',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'c',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'd',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'e',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'f',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'g',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'h',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'i',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'j',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'k',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'l',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'm',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'n',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'o',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'p',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'r',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    's',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    't',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'u',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'v',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'w',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'x',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'z',    NULL,    1);
-- D → terminal (letras mayúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'A',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'B',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'C',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'D',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'E',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'F',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'G',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'H',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'I',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'J',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'K',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'L',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'M',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'N',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'O',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'P',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'Q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'R',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'S',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'T',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'U',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'V',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'W',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'X',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'Y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    'Z',    NULL,    1);
-- D → terminal (dígitos)
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '0',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '1',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '2',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '3',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '4',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '5',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '6',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '7',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '8',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'D',    '9',    NULL,    1);
-- D → espacio
INSERT INTO GLC_en_FNC VALUES (false, 'D',    ' ',    NULL,    1);

-- ─── V ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'C',    'V',     2);  -- V → C V
-- V → terminal (letras minúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'a',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'b',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'c',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'd',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'e',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'f',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'g',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'h',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'i',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'j',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'k',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'l',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'm',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'n',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'o',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'p',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'r',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    's',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    't',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'u',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'v',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'w',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'x',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'z',    NULL,    1);
-- V → terminal (letras mayúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'A',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'B',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'C',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'D',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'E',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'F',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'G',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'H',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'I',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'J',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'K',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'L',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'M',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'N',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'O',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'P',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'Q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'R',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'S',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'T',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'U',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'V',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'W',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'X',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'Y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    'Z',    NULL,    1);
-- V → terminal (dígitos)
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '0',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '1',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '2',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '3',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '4',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '5',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '6',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '7',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '8',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'V',    '9',    NULL,    1);
-- V → espacio
INSERT INTO GLC_en_FNC VALUES (false, 'V',    ' ',    NULL,    1);

-- ─── C ──────────────────────────────────────────────────────────────────────
-- C → terminal (letras minúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'a',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'b',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'c',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'd',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'e',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'f',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'g',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'h',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'i',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'j',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'k',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'l',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'm',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'n',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'o',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'p',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'r',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    's',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    't',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'u',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'v',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'w',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'x',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'z',    NULL,    1);
-- C → terminal (letras mayúsculas)
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'A',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'B',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'C',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'D',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'E',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'F',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'G',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'H',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'I',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'J',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'K',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'L',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'M',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'N',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'O',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'P',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'Q',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'R',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'S',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'T',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'U',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'V',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'W',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'X',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'Y',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    'Z',    NULL,    1);
-- C → terminal (dígitos)
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '0',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '1',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '2',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '3',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '4',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '5',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '6',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '7',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '8',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'C',    '9',    NULL,    1);
-- C → espacio
INSERT INTO GLC_en_FNC VALUES (false, 'C',    ' ',    NULL,    1);

-- ─── E ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'E',    'F',    'E',     2);  -- E → F E
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '0',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '1',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '2',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '3',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '4',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '5',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '6',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '7',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '8',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'E',    '9',    NULL,    1);

-- ─── F ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '0',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '1',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '2',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '3',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '4',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '5',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '6',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '7',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '8',    NULL,    1);
INSERT INTO GLC_en_FNC VALUES (false, 'F',    '9',    NULL,    1);

-- ─── Variables auxiliares de terminales ─────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'T_LA',  '{',   NULL,    1);  -- {
INSERT INTO GLC_en_FNC VALUES (false, 'T_LC',  '}',   NULL,    1);  -- }
INSERT INTO GLC_en_FNC VALUES (false, 'T_CO',  ',',   NULL,    1);  -- ,
INSERT INTO GLC_en_FNC VALUES (false, 'T_DQ',  '"',   NULL,    1);  -- "
INSERT INTO GLC_en_FNC VALUES (false, 'T_SQ',  '''',  NULL,    1);  -- '
INSERT INTO GLC_en_FNC VALUES (false, 'T_DOS', ':',   NULL,    1);  -- :
