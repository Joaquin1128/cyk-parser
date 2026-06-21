-- Gramática de expresiones aritméticas en FNC (Parte 5)
-- S → SA | BG | ND | dígito
-- A → OS
-- O → + | - | * | /
-- G → SC
-- B → (
-- C → )
-- N → ND | dígito
-- D → dígito
--
-- Esta gramática ya está en FNC (sin epsilon, sin unitarias, binarizada),
-- no requiere variables auxiliares de terminales.

TRUNCATE GLC_en_FNC;

-- ─── S (símbolo inicial) ────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (true,  'S', 'S', 'A', 2);  -- S → S A
INSERT INTO GLC_en_FNC VALUES (true,  'S', 'B', 'G', 2);  -- S → B G
INSERT INTO GLC_en_FNC VALUES (true,  'S', 'N', 'D', 2);  -- S → N D
INSERT INTO GLC_en_FNC VALUES (true,  'S', '0', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '1', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '2', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '3', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '4', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '5', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '6', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '7', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '8', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (true,  'S', '9', NULL, 1);

-- ─── A ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'A', 'O', 'S', 2);  -- A → O S

-- ─── O ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'O', '+', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'O', '-', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'O', '*', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'O', '/', NULL, 1);

-- ─── G ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'G', 'S', 'C', 2);  -- G → S C

-- ─── B / C (paréntesis) ─────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'B', '(', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'C', ')', NULL, 1);

-- ─── N ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'N', 'N', 'D', 2);  -- N → N D
INSERT INTO GLC_en_FNC VALUES (false, 'N', '0', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '1', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '2', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '3', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '4', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '5', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '6', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '7', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '8', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'N', '9', NULL, 1);

-- ─── D ──────────────────────────────────────────────────────────────────────
INSERT INTO GLC_en_FNC VALUES (false, 'D', '0', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '1', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '2', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '3', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '4', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '5', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '6', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '7', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '8', NULL, 1);
INSERT INTO GLC_en_FNC VALUES (false, 'D', '9', NULL, 1);
