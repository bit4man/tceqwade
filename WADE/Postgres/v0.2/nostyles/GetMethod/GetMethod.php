<?php
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/Postgres/v0.2/config.inc.php");
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/Postgres/v0.2/adodb/adodb.inc.php");
	include ($_SERVER['DOCUMENT_ROOT']."/WADE/Postgres/v0.2/adodb/adodb-exceptions.inc.php");

class WaDESearch_PHP {
//initialize
   function __construct() {
        $this->process_request();
    }
//clean-up function
    function __destruct() {
        
    }
    protected function process_request() {
//variables
	$methodid = 0;
	$methodname = 0;
//test for a query parameter
	if(!empty($_REQUEST["methodid"])) {
		header('Content-type: text/xml');
		$methodid = $_REQUEST["methodid"];
		$methodname = $_REQUEST["methodname"];
	}
	echo $this->get_results($methodid, $methodname);
        }
    protected function get_results($methodid, $methodname) {
	global $dsn;
//connection to the database
	$db = &ADONewConnection($dsn);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT "WADE_R"."GetMethod"(' . $db->qstr($methodid) . ',' . $db->qstr($methodname) . ') As answer')->GetRows();
	$result = $rs[0]['answer'];	
	$test = "<WC:Method";
	$test2 = substr($result,0,10);
	if (strcmp($test,$test2)!==0) {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}
// return the results to the webpage
	else {
	return $result;

	}
    }

} 

new WaDESearch_PHP();

?>
