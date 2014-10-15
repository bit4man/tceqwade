<?php
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/config.inc.php");
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/adodb/adodb.inc.php");
	include ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/adodb/adodb-exceptions.inc.php");

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

	global $host, $user, $pass, $dbname;

	$db = ADONewConnection('mssqlnative');
	$db->Connect($host, $user, $pass, $dbname);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT [wade_r].[GetMethod] (' . $db->qstr($methodid) . ',' . $db->qstr($methodname) . ') As Answer')->GetRows();
	$result = $rs[0]['Answer'];	
	
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
