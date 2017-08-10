#!/bin/zsh -f

clean() {
  local files
  files=()
  for i in **/*.scr; do
    files+=(${i%%.scr}.html)
  done
  command rm -fv "${files[@]}"
}

depend() {
  printf '%s\n\n' '.PHONY: allfiles'

  local all_files target
  all_files=()

  for i in index.scr */**/*.scr; do
    [[ ! -d $i ]] || continue
    scribe_rule
    all_files+=($target)
  done

  rule allfiles "${all_files[*]}"
  depend_guillaumin
}

rule() {
  echo "$1: $2"; shift 2
  local j
  for j; do printf '\t%s\n' "$j"; done
  echo
}

scribe_rule() {
  local CD top base prereqs
  handle_directory
  set_up_target
  set_up_prereqs
  rule "$target" "$prereqs" "${CD}exscribe -I $top $base.scr -o $base.html"
}

handle_directory() {
  local hdir="$(dirname "$i")"
  if [[ $hdir = . ]]; then
    CD=
    top=.
  else
    CD="cd $(printf %q "$hdir"); "
    top=$(echo "$hdir" | sed -e 's_[^/]*_.._g')
  fi
}

set_up_target() {
  local i_without_extension="${i%.*}"
  target=$(escape_for_make "$i_without_extension").html
  base=$(printf %q "$(basename "$i_without_extension")")
}

set_up_prereqs() {
  prereqs="$(escape_for_make "$i") fare-style.scr bo-style.scr"
  [[ $base != guillaumin ]] || prereqs+=' oeuvres_bastiat.scr'
}

escape_for_make () {
  printf '%s\n' "$1" | sed 's_[\[:space:]*%#$]_\\&_g'
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

DBG() { print -r "$*" >&2; }
abort() { DBG "$2"; exit "$1"; }
no_func_abort() { abort 102 "Unknown function $1"; }

function_p() {
  c=$(command -v "$1") && [[ $c = $1 ]] && [[ $c != */* ]]
}

main() {
  if function_p "$1"; then
    "$@"
  else
    no_func_abort "$@"
  fi
}

main "$@"
