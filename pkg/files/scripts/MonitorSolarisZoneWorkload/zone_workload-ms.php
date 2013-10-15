<?php

require('rcs_function.php');

// get all the variables from the environmental variable
$agent_hostname = getenv('UPTIME_HOSTNAME');
$agent_port     = getenv('UPTIME_PORT');
$agent_password = getenv('UPTIME_PASSWORD');
$remote_script  = getenv('UPTIME_REMOTE_SCRIPT');


// "contains()" function
// http://www.jonasjohn.de/snippets/php/contains.htm
function contains($str, $content, $ignorecase=true){
    if ($ignorecase){
        $str = strtolower($str);
        $content = strtolower($content);
    }  
    return strpos($str,$content) ? true : false;
}


// determine if the agent is a Windows or other (posix) agent since the Windows agent requires special handling
/*function is_agent($veroutput, $agenttype) {
	$rv = 0;
	// check if the agent is on Windows or anything else (Posix)
	if (contains($veroutput, $agenttype, true)) {
		$rv = 1;
	}
	if (strlen($veroutput) == 0) {
		$rv = 0;
		print "Error: no lines returned from 'ver'. Is the agent running?";
		exit(1);
	}
	return $rv;
}*/

$agent_output = uptime_remote_custom_monitor($agent_hostname, $agent_port, $agent_password, $remote_script);
if (strlen($agent_output) == 0) {
	print "Error: No lines returned from agent. Make sure the script is configured properly on the remote system.";
	exit(1);
}
if ($agent_output == "ERR") {
	print "Error: Output received: 'ERR'. The agent may not be configured correctly. Check the password?";
	exit(2);
}

print $agent_output;
exit(0);

?>