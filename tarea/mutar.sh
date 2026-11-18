#!/usr/bin/env bash
# Mide si las pruebas de un servicio detectan cambios en un archivo.
# Cambia el archivo de a una cosa por vez (un operador en una línea), corre las
# pruebas y deja el archivo como estaba. Un cambio que ninguna prueba nota es un
# mutante que SOBREVIVE.
#
# Uso: tarea/mutar.sh services/catalog/src/shifts.ts
set -u

archivo="${1:?uso: tarea/mutar.sh <archivo>}"
raiz=$(git rev-parse --show-toplevel) || exit 2
cd "$raiz" || exit 2
[ -f "$archivo" ] || { echo "no existe: $archivo" >&2; exit 2; }

case "$archivo" in
  services/catalog/*)       pruebas='cd services/catalog && npm test --silent' ;;
  services/incidents/*)     pruebas='cd services/incidents && uv run pytest -q -x' ;;
  services/notifications/*) pruebas='cd services/notifications && go test ./...' ;;
  *) echo "sin pruebas conocidas para: $archivo" >&2; exit 2 ;;
esac

original=$(mktemp)
cp "$archivo" "$original"
restaurar() { cp "$original" "$archivo"; rm -f "$original"; }
trap restaurar EXIT INT TERM

correr() { bash -c "$pruebas" >/dev/null 2>&1; }

if ! correr; then
  echo "Las pruebas ya fallan sin cambios; no se puede medir." >&2
  exit 2
fi

# Cambios de operador: "original;;reemplazo". Llevan espacios alrededor para no
# tocar genéricos ni flechas.
cambios=(
  " <= ;; < "
  " < ;; <= "
  " >= ;; > "
  " > ;; >= "
  " && ;; || "
  " || ;; && "
  " == ;; != "
  " != ;; == "
  " and ;; or "
  " or ;; and "
)

recortar() { printf '%s' "$1" | sed -e 's/^ *//' -e 's/ *$//'; }

total=0; muertos=0
n=0
while IFS= read -r linea; do
  n=$((n + 1))
  for par in "${cambios[@]}"; do
    de="${par%%;;*}"; a="${par#*;;}"
    case "$linea" in *"$de"*) ;; *) continue ;; esac
    awk -v n="$n" -v de="$de" -v a="$a" '
      NR == n { i = index($0, de); if (i) $0 = substr($0, 1, i - 1) a substr($0, i + length(de)) }
      { print }' "$original" > "$archivo"
    total=$((total + 1))
    if correr; then estado="SOBREVIVE"; else estado="MUERTO   "; muertos=$((muertos + 1)); fi
    printf '%s  línea %-3s  «%s» por «%s»\n' "$estado" "$n" "$(recortar "$de")" "$(recortar "$a")"
  done
done < "$original"

cp "$original" "$archivo"
echo
if [ "$total" -eq 0 ]; then echo "No hay cambios que probar en $archivo."; exit 0; fi
echo "Mutantes: $total   muertos: $muertos   sobreviven: $((total - muertos))   puntaje: $((100 * muertos / total)) %"
