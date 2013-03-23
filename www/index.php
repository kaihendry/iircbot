<?php
$irc = '/home/hendry/irc/irc.freenode.net/#foobaztest/in';

$who = gethostbyaddr($_SERVER['REMOTE_ADDR']);
$msg = $_REQUEST['msg'];

if (empty($msg) || (strlen($msg) > 160)) {
	header($_SERVER['SERVER_PROTOCOL'] . ' 400 Bad request', true, 400);
	die();
}

exec("echo [$who] $msg >> $irc", $out, $ret);

if ($ret != 0) {
	header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
}
?>
