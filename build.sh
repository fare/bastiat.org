#!/bin/zsh -f

clean() {
  FILES=()
  for i in **/*.scr; do
    FILES+=(${i%%.scr}.html)
  done
  command rm -fv "${FILES[@]}"
}

depend() {

SOURCES=(index.scr */*.scr)

rule() {
    local j
    echo "$1:	$2"; shift 2
    for j; do echo "	$j"; done
    echo
}

scribe_rule() {
      subdir=$(dirname "$i")
      base=$(basename "$i" .scr)
      file=$base.scr
      style='fare-style.scr bo-style.scr'
      other=
      hdir=$HOST_DIR$subdir
      [[ -n $hdir ]] && CD="cd $hdir; " || CD=
      [[ $base != guillaumin ]] || other=oeuvres_bastiat.scr
      rule "$b.html" "$i $style $other" \
	"${CD}exscribe -I $top $file -o $base.html"
      FILES=$b.html
      HFILES=$b.html
      CFILES=$b.html
}

do_depend_guillaumin() {
  print -l fr/*.scr > fr/.depend.guillaumin
}

oldtouch() {
  touch -d '00:00:00GMT 01 Jan 1970' "$@"
}

depend_guillaumin() {
  if [ -f fr/.depend.guillaumin ]; then
    mv fr/.depend.guillaumin fr/.depend.guillaumin.bak
    do_depend_guillaumin
    cmp --silent fr/.depend.guillaumin fr/.depend.guillaumin.bak ||
    oldtouch fr/guillaumin.html
    command rm -f fr/.depend.guillaumin.bak
  else
    do_depend_guillaumin
    oldtouch fr/guillaumin.html
  fi
}

cat <<EOF
.PHONY:	allfiles html

CP=cp

EOF

init() {
  ALLFILES=
  ALLHFILES=
  ALLCFILES=
}

stuff() {
  b=${i%.*}
  h=$HOST_DIR$i
  s=$SOURCE_DIR$i
  hb=$HOST_DIR$b
  top=$(echo "$i" | sed -e 's/[^\/]*\/[^\/]*/..\//g')
  FILES=
  HFILES=
  CFILES=
}

init
for i in "${SOURCES[@]}"; do
  stuff
  if [[ ! -d $i ]]; then
  case $i in
    *.html)
      FILES=$h
      HFILES=$h
      ;;
    *.scr)
      scribe_rule
      ;;
    *.txt|*.png|*.jpg)
      FILES=$h
      ;;
    *)
      echo "# Warning: can't handle source file $i"
      echo "# Warning: can't handle source file $i" >&2
      ;;
  esac
  fi
  ALLFILES="$ALLFILES $FILES"
  ALLHFILES="$ALLHFILES $HFILES"
  ALLCFILES="$ALLCFILES $CFILES"
done

rule allfiles: "$ALLFILES"
rule html: "$ALLHFILES"
depend_guillaumin
}

. ./script.zsh
