<?php
$ua = $_SERVER['HTTP_USER_AGENT'];
if(strpos($ua, "curl") !== false || strpos($ua, "Wget") !== false)
	include("get-ipgw.sh");
else
	include("get-ipgw.html");
