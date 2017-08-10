#!/bin/bash

newline='
'

clean() {
  #local IFS

  IFS=$newline
  set -- $(find . -type f -name \*.scr | cut -c 3-)
  unset IFS

  for i; do
    command rm -fv "${i%%.scr}".html
  done
}

depend() {
  printf '%s\n\n' '.PHONY: allfiles'

  #local IFS all_files target

  IFS=$newline
  set -- index.scr $(find_sources)
  unset IFS

  all_files=

  for i; do
    [ ! -d "$i" ] || continue
    scribe_rule
    all_files=${all_files:+$all_files }$target
  done

  rule allfiles "$all_files"
  depend_guillaumin
}

find_sources() {
  find . -type d \! -name . -exec find {} -type f -name \*.scr \; | cut -c 3-
}

rule() {
  printf '%s\n' "$1: $2"; shift 2
  #local j
  for j; do printf '\t%s\n' "$j"; done
  echo
}

scribe_rule() {
  #local CD top base prereqs
  handle_directory
  set_up_target
  set_up_prereqs
  rule "$target" "$prereqs" "${CD}exscribe -I $top $base.scr -o $base.html"
}

handle_directory() {
  #local hdir
  hdir=$(dirname "$i")
  if [ "$hdir" = . ]; then
    CD=
    top=.
  else
    CD="cd $(printf %q "$hdir"); "
    top=$(printf '%s\n' "$hdir" | sed -e 's_[^/]*_.._g')
  fi
}

set_up_target() {
  #local i_without_extension
  local i_without_extension=${i%.*}
  target=$(escape_for_make "$i_without_extension").html
  base=$(printf %q "$(basename "$i_without_extension")")
}

set_up_prereqs() {
  prereqs="$(escape_for_make "$i") fare-style.scr bo-style.scr"
  [ "$base" != guillaumin ] || prereqs=$prereqs' oeuvres_bastiat.scr'
}

escape_for_make () {
  printf '%s\n' "$1" | sed 's_[\[:space:]*%#$]_\\&_g'
}

do_depend_guillaumin() {
  for f in fr/*.scr; do printf '%s\n' "$f"; done > fr/.depend.guillaumin
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

DBG() { printf '%s\n' "$*" >&2; }
abort() { DBG "$2"; exit "$1"; }
no_func_abort() { abort 102 "Unknown function $1"; }

function_p() {
  c=$(command -v "$1") && [ "$c" = "$1" ] && [ "${c##*/*}" != '' ]
}

main() {
  if function_p "$1"; then
    "$@"
  else
    no_func_abort "$@"
  fi
}

main "$@"
