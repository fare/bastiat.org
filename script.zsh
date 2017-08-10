#!/bin/zsh -f

# The following environment variables may be set:
#
#   SOURCE_DIR (usually the empty string)
#   HOST_DIR   (perhaps set to ~bastiat/html)
#
# For security reasons, the actual executable on bespin
# must be updated manually when this file is modified:
# /usr/bin/install -m 755 -o bastiat -g bastiat \
#   /serv/bastiat/org/script.zsh /serv/bastiat/bin/script.zsh
# Also, /serv/bastiat/bin/update_bespin is but
# #!/bin/sh
# exec /serv/bastiat/bin/script.zsh LOG update_bespin

### Variables

LOG_FILE=/serv/bastiat/tmp/x.log
((MAX_LOG_SIZE = 2**18))

### Helper function library

DBG() { print -r "$*" >&2; }
abort() { DBG "$2"; exit "$1"; }
no_func_abort() { abort 102 "Unknown function $1"; }
DO() { DBG "$@"; "$@"; }
push() { LIST=$1; shift; eval "$LIST+=(\"\$@\")"; }

function_p() {
  case $(whence -v "$1") in
    "$1 is a shell function"*)
	return 0
	;;
    *)
        return 1
        ;;
  esac
}

call_if_func() {
  if function_p "$1"; then
    "$@"
  else
    no_func_abort "$1"
  fi
}

### Generic batch functions

LOG() {
   check_identity
   keep_log_small
   {
   echo
   echo "$USERNAME@$HOST ($UID) $(date)"
   echo "$PROG $ARGS"
   echo "==> $0 $*"
   call_if_func "$@"
   echo "<== END $(date)"
   } >>& "$LOG_FILE"
}

check_identity() {
  if [[ $USERNAME != bastiat ]]; then
     abort 10 'Must be user bastiat. Aborting.'
  fi
}

keep_log_small() {
   if (( $(sizeof "$LOG_FILE") > MAX_LOG_SIZE )); then
      mv -f "$LOG_FILE" "$LOG_FILE".old
   fi
}

sizeof() {
  if [[ -f $1 ]]; then
    du -sb "$1" 2> /dev/null | { read A B; echo "$A"; }
  else
    echo 0; return 1
  fi
}

update_bespin() {
    make dep &&
    make &&
    rsync -av --delete --exclude .git ./ bastiat@bastiat.org:html/
}

txt2scr() {
perl -e '
   $_ = join("",<>);
   s/\r\n?/\n/gs;
   s/XXX\:sic\:/(XXX sicYYY)/gs;
   s/XXX\:sic/(XXX YYYsic)/gs;
   s/\s*([,.:;?!])/$1/gs;
   s/([,.:;?!])([A-Za-zÀ-ÿ])/$1 $2/gs;
   s/YYY/:/gs;
   s/ +/ /gs;
   s/ \n/\n/gs;
   s/^ //gm;
   s/\n{3,}/\n\]\n(nbsp)\n[\n/gs;
   s/\n\n/\n\]\[\n/gs;
   # Gérer les itemize avec s/^\- /...
   # Gérer les blockquotes avec s/^\i/...
   s/\[\*+([^\]]*)\]/,(footnote[$1\])/gs;
   s/\/([^0-9\/]*)\//,(emph\[$1\])/gs;
   s/(\W)l,\(emph\[/$1\,\(inlatin\[/gs;
   s/(\W)i,\(emph\[/$1\,\(initalian\[/gs;
   s/(\W)e,\(emph\[/$1\,\(inenglish\[/gs;
   s/(\W)t,\(emph\[/$1\,\(cite-title\[/gs;
   s/\*([^\*]*)\*/,(strong\[$1\])/gs;
   s/\"\s*([^\"]*?\S)?\s*\"/,(q\[$1\])/gs;
   s/\«\s*([^\"]*?\S)?\s*\»/,(q\[$1\])/gs;
   s/\x93\s*([^\"]*?\S)?\s*\x94/,(q\[$1\])/gs;
   s/oe([uil])/,(oe)$1/gs;
   s/\-\-/,(--)/gs;
   s/NdEEO/,(NdEEO)/gs;
   s/NdEEE/,(NdEBO)/gs;
   s/NdEBO/,(NdEBO)/gs;
   s/\(XXX ([^\)]+)\)/,(XXX [$1])/gs;
   s/XXX/,(XXX)/gs;
   s/\,\(\,\(XXX\)/,(XXX/gs;
   s/\(footnote/\(footnote\*/gs;
   s/\)\;/),(pv)/gs;
   s/\x9C/,(oe)/gs;
   s/\x8C/,(OE)/gs;
   s/\x91/\'\''/gs; # Note the shell quoting of a single quote here
   s/\x92/\'\''/gm; # Note the shell quoting of a single quote here
   s/\x97/,(--)/gm;
   s/\x96/,(--)/gm;
   s/\xFF//gm;
   s/\x85/.../gm; # \&hellip\;
   print;
' -- "$@"
}

main() {
  if function_p "$1"; then
    "$@"
  else
    no_func_abort "$@"
  fi
}

PROG=$0
ARGS=("$@")
main "$@"
