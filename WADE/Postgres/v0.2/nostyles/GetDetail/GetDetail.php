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
	$reportid = 0;
	$loctype = 0;
	$loctxt = 0; 
	$datatype = 0;	
//test for a query in the URL
	if(!empty($_REQUEST["reportid"])) {
//if not empty, set page type to XML and set variables = to query values
		header('Content-type: text/xml');
		$reportid = $_REQUEST["reportid"];
		$loctype = $_REQUEST["loctype"];
		$loctxt = $_REQUEST["loctxt"];
		$datatype = $_REQUEST["datatype"];
	}
//pass variables to protected function 'get results'
        echo $this->get_results($reportid,$loctype, $loctxt, $datatype);
        }
    protected function get_results($reportid,$loctype, $loctxt, $datatype) {
//import the connection string 
	global $dsn;
//connection to the database
	$db = &ADONewConnection($dsn);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT "WADE_R"."GetDetailByLocation"(' . $db->qstr($reportid) . ',' . $db->qstr($loctype) . ',' . $db->qstr($loctxt) . ',' . $db->qstr($datatype) . ') As answer')->GetRows();
	$result = $rs[0]['answer'];	
	$test = "<WC:WaDE";
	$test2 = substr($result,0,8);	
	if (strcmp($test,$test2)!==0) {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}
	else
	{
// return the results to the webpage
	return $result;
	}
    }
} 

new WaDESearch_PHP();

?>
