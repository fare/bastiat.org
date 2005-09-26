<?php

$sites = array(
        "bastiat.org",
        "bastiat.net",
        "www.econlib.org", 
        "bastiat.de"
);

$specializer = " Bastiat ";
$flag = true;
foreach( $sites as $s ) {
  if ($flag) { $flag = false; } else { $specializer .= " OR "; }
  $specializer .= "site:$s";
}

#$q = $_POST["q"];

if ($q != "") {
  $searchq = $q . $specializer;
  $esearchq = urlencode($searchq);
  $url = "http://www.google.com/search?num=100&q=$esearchq";
#  $hl = $_POST["hl"];
  if ($hl != "") { $ehl = urlencode($hl); $url .= "&hl=$ehl"; }
  header("Location: $url");
#  exit;
  echo "<meta http-equiv=\"Refresh\" content=\"0;url=$url\">";
#  print("<meta http-equiv=\"Refresh\" content=\"0;url=$url\">");
} else {
  header("Content-Type: text/html");
#  exit;
}
?>
<!DOCTYPE HTML PUBLIC "html.dtd">
<html><head>
<title>Search Bastiat sites on the Web</title>
</head><body>
<h1 align="center">Search Bastiat sites on the Web</h1>
<p align="center">
<table align="center" summary="forms"><tr><td><center>
<form method=get action="http://bastiat.org/search.php">
<input type=text name=q size=31 maxlength=255 value="">
<input type=submit name=btnG value="Bastiat @ Google">
</form></center></td></tr></table>
</p>
<p align="left">
The above form will use <a href="http://www.google.com">Google</a>
to search whatever you're looking for in the Bastiat sites:
<?php
$seps = array(",", ",", " and", ".");
$subdir = array("", "", "/library/classics.html#bastiat", "");
for( $i = 0 ; $i < 4 ; $i ++ ) {
  $site = $sites[$i];
  $url = "http://".$site.$subdir[$i];
  $sep = $seps[$i];
  echo "<a href=\"$url\">$site</a>$sep\n";
#  print("<a href=\"$url\"">$site</a>$sep\n");
}
?>
</p>
</body></html>
