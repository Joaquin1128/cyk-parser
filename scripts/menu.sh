#!/usr/bin/env bash

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATABASE_DIR="$SCRIPT_DIR/../database"
TESTS_DIR="$SCRIPT_DIR/../tests"

if [[ -f "$SCRIPT_DIR/config.sh" ]]; then
    source "$SCRIPT_DIR/config.sh"
else
    echo "No se encontro scripts/config.sh - usando valores por defecto."
    DB_HOST="${PGHOST:-localhost}"
    DB_PORT="${PGPORT:-5432}"
    DB_NAME="${PGDATABASE:-cyk}"
    DB_USER="${PGUSER:-}"
    DB_PASS="${PGPASSWORD:-}"
fi

pause() {
    read -rp $'\nPresione ENTER para continuar...' _
}

ensure_credentials() {
    if [[ -z "$DB_USER" ]]; then
        read -rp "Usuario de PostgreSQL: " DB_USER
    fi
    if [[ -z "$DB_PASS" ]]; then
        read -rsp "Contrasena de PostgreSQL: " DB_PASS
        echo
    fi
}

run_sql_file() {
    local file="$1"
    ensure_credentials
    PGPASSWORD="$DB_PASS" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$file"
}

run_sql_inline() {
    local query="$1"
    ensure_credentials
    PGPASSWORD="$DB_PASS" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "$query"
}

opt_crear_schema() {
    echo "Cargando schema (tablas GLC_en_FNC y matriz_cyk)..."
    run_sql_file "$DATABASE_DIR/1_schema.sql"
}

opt_cargar_funciones() {
    echo "Cargando funciones (setear_matriz, cyk)..."
    run_sql_file "$DATABASE_DIR/3_functions.sql"
    echo "Cargando funciones de output (print_glc_fnc, print_matriz_cyk)..."
    run_sql_file "$DATABASE_DIR/4_output.sql"
}

opt_cargar_gramatica_json() {
    echo "Cargando gramatica JSON (Partes 1-3)..."
    run_sql_file "$DATABASE_DIR/2_grammar.sql"
}

opt_cargar_gramatica_aritmetica() {
    echo "Cargando gramatica aritmetica (Parte 5)..."
    run_sql_file "$DATABASE_DIR/5_grammar_aritmetica.sql"
}

opt_mostrar_glc() {
    run_sql_inline "SELECT print_glc_fnc();"
}

opt_ejecutar_cyk() {
    read -rp "Ingrese el string a evaluar (sin comillas envolventes): " input_str
    local escaped="${input_str//\'/\'\'}"
    run_sql_inline "SELECT CASE WHEN cyk('$escaped') THEN 'SI, pertenece a la gramatica' ELSE 'NO pertenece a la gramatica' END AS resultado;"
}

opt_mostrar_matriz() {
    run_sql_inline "SELECT print_matriz_cyk();"
}

opt_correr_tests() {
    echo "Corriendo tests..."
    run_sql_file "$TESTS_DIR/tests.sql"
}

opt_reset_completo() {
    read -rp "Esto borra TODAS las tablas (GLC_en_FNC, matriz_cyk, cyk_input). Confirmar? (s/N): " confirm
    if [[ "$confirm" == "s" || "$confirm" == "S" ]]; then
        run_sql_inline "DROP TABLE IF EXISTS GLC_en_FNC, matriz_cyk, cyk_input CASCADE;"
        echo "Tablas eliminadas. Usa las opciones 1 y 2 para recrear schema y funciones."
    else
        echo "Cancelado."
    fi
}

while true; do
    clear
    cat <<'EOF'
+------------------------------------------------------------+
|              TP CYK - PostgreSQL - Menu                    |
+------------------------------------------------------------+
|  1) Crear schema (tablas)                                  |
|  2) Cargar funciones (setear_matriz, cyk, print_*)         |
|  3) Cargar gramatica JSON (Partes 1-3)                     |
|  4) Cargar gramatica aritmetica (Parte 5)                  |
|  5) Mostrar GLC cargada                                    |
|  6) Ejecutar CYK sobre un string                           |
|  7) Mostrar matriz CYK                                     |
|  8) Correr tests                                           |
|  9) Reset (DROP de todas las tablas)                       |
|  0) Salir                                                  |
+------------------------------------------------------------+
EOF
    read -rp "Elija una opcion: " opt

    case "$opt" in
        1) opt_crear_schema ;;
        2) opt_cargar_funciones ;;
        3) opt_cargar_gramatica_json ;;
        4) opt_cargar_gramatica_aritmetica ;;
        5) opt_mostrar_glc ;;
        6) opt_ejecutar_cyk ;;
        7) opt_mostrar_matriz ;;
        8) opt_correr_tests ;;
        9) opt_reset_completo ;;
        0) echo "Chau."; exit 0 ;;
        *) echo "Opcion invalida." ;;
    esac

    pause
done
