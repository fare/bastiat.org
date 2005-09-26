#!/bin/zsh -f
# $Id: script.zsh,v 1.22 2003/03/24 10:37:42 fare Exp $
#
# For security reasons, the actual executable on bespin
# must be updated manually when this file is modified:
: /usr/bin/install -m 755 -o bastiat -g bastiat \
    /serv/bastiat/org/script.zsh /serv/bastiat/bin/script.zsh
# Also, /serv/bastiat/bin/updateweb is but
# #!/bin/sh
# exec /serv/bastiat/bin/script.zsh LOG updateweb

###
### Variables
###

setopt EXTENDED_GLOB
export PATH=/usr/local/bin:/usr/bin:/bin

LOG_FILE=/serv/bastiat/tmp/x.log
MAX_LOG_SIZE=$[2**18]

#: ${SOURCE_DIR:=}
#: ${HOST_DIR:=~bastiat/html}
#: ${TARGET_DIR:=http://bastiat.org/}

: ${BACKUPDIR:=/tmp}


UTSL="UTSL!"

### Helper function library
DBG () { print -r "$*" >&2 }
abort () { DBG "$2" ; exit $1 }
DO () { DBG "$*" ; $@ }
call_if_func () { if function_p "$1" ; then $@ ; else no_func_abort $1 ; fi }
no_func_abort () { abort 102 "Unknown function $1 -- Valid functions: $UTSL" }
push () { LIST=$1 ; shift ; eval "${LIST}=(\$${LIST} \$@)" }

### Generic batch functions
LOG () {
   check_identity
   keep_log_small
   {
   echo
   echo "$USERNAME@$HOST ($UID) $(date)"
   echo "$PROG $ARGS"
   echo "==> $0 $*"
   call_if_func $@
   echo "<== END $(date)"
   } >>& $LOG_FILE
}
check_identity () {
  if [[ "x${USERNAME}" != "xbastiat" ]] ; then # @${HOST} @Samaris
     abort 10 "Must be user bastiat. Aborting." # @Samaris
  fi
}
keep_log_small () {
   if [ "$(sizeof $LOG_FILE)" -gt "$MAX_LOG_SIZE" ] ; then
      mv -f $LOG_FILE ${LOG_FILE}.old
   fi
}
sizeof () {
  if [ -f "$1" ] ; then
    du -sb $1 2> /dev/null | { read A B ; echo $A }
    # on non-GNU systems, try wc -c instead. Or rather, install GNU!
  else
    echo 0 ; return 1
  fi
}
function_p () {
  local WHENCE="$(whence -v $1)"
  case "$WHENCE" in
    "$1 is a shell function")
	return 0 ;;
    *)
        return 1 ;;
  esac
}
oldtouch () {
  touch -d "00:00:00GMT 01 Jan 1970" $@
}

depend () {

SOURCES=( */*.scr~*-style.scr ) # someday, add index.scr (?)

rule () {
    local j
    echo "$1:	$2" ; shift 2
    for j ; do echo "	$j" ; done
    echo
}
id_rule () {
    local S="${SOURCE_DIR}$1" H="${HOST_DIR}$1"
    #rule "$H" "$S" "\$(CP) $S $H"
}
dir_rule () {
    #local S="${SOURCE_DIR}$1" H="${HOST_DIR}$1"
    #rule "$H" "$S" "\$(CP) -av $S $H"
    #rule "$H" "force" "rsync -av $S/ $H/"
    #rule "$S" "$H" ""
    #rule ".PHONY" "$H $S force"
}
scribe_rule () {
      subdir="$(dirname $i)"
      base="$(basename $i .scr)"
      file="${base}.scr"
      style=bo-style.scr
      other=
      id_rule $i
      hdir="${HOST_DIR}$subdir"
      if [ -n "$hdir" ] ; then
        CD="cd $hdir"
      else
        CD=":"
      fi
      if [ "$base" = "guillaumin" ] ; then
	other="oeuvres_bastiat.scr"
      fi
      rule "$b.html" "$i $style $other" \
	"$CD ; scribe -I ${top} $file -o $base.html"
      FILES="$b.html"
      HFILES="$b.html"
}
do_depend_guillaumin () {
  print -l fr/*.scr > fr/.depend.guillaumin
}
depend_guillaumin () {
  if [ -f fr/.depend.guillaumin ] ; then
    mv fr/.depend.guillaumin fr/.depend.guillaumin.bak
    do_depend_guillaumin
    cmp --silent fr/.depend.guillaumin fr/.depend.guillaumin.bak ||
    oldtouch fr/guillaumin.html
    rm fr/.depend.guillaumin.bak
  else
    do_depend_guillaumin
    oldtouch fr/guillaumin.html
  fi
}

cat <<EOF
.PHONY:	allfiles html

CP=cp

EOF

init () {
  ALLFILES=
  ALLHFILES=
}

stuff () {
  b="${i%.*}"
  h=${HOST_DIR}$i
  s=${SOURCE_DIR}$i
  hb=${HOST_DIR}$b
  top="$(echo $i | sed -e 's/[^\/]*\/[^\/]*/..\//g')" ; : ${top:=.}
  FILES=""
  HFILES=""
}

init
for i in $SOURCES ; do
  stuff
  if [ -d $i ] ; then
    dir_rule $i
  else
  case $i in
    *.html)
      id_rule $i
      FILES="$h"
      HFILES="$h"
      ;;
    *.scr)
      scribe_rule
      ;;
    *.txt|*.png|*.jpg)
      id_rule $i
      FILES="$h"
      ;;
    *)
      echo "# Warning: can't handle source file $i"
      echo "# Warning: can't handle source file $i" >&2
      ;;
  esac
  fi
  ALLFILES="$ALLFILES $FILES"
  ALLHFILES="$ALLHFILES $HFILES"
done

rule allfiles: "$ALLFILES"
rule html: "$ALLHFILES"
depend_guillaumin

}

update_bastiat () {
  cd ~bastiat/org
  cvs -q update -dfP
}
make_bastiat () {
  cd ~bastiat/org/
  make depend
  make
}
publish_pages () {
  cd ~bastiat/org
  cmp --silent /serv/bastiat/bin/script.zsh /serv/bastiat/org/script.zsh ||
  { DBG ">>>>>> script.zsh was changed. Please update as applicable. <<<<<<" }
  rsync --delete -av \
	--exclude CVS --exclude '.*' \
	--exclude Makefile --exclude script.zsh --exclude crontab \
	/serv/bastiat/org/ /serv/bastiat/html/
  # do not use -C, or it will exclude .html's!!!!
}
updateweb () { update_bastiat ; make_bastiat ; publish_pages }

default_behavior () {
  : default_behavior $@
  no_func_abort $@
}
main () {
  : main $@
  if function_p "$1" ; then
    $@
  else
    default_behavior $@
  fi
}
PROG=$0
ARGS=($@)
main $@
