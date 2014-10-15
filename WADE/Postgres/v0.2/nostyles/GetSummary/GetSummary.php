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
	$loctype = 0; 
	$loctxt = 0;
	$orgid = 0;
	$reportid = 0;
	$datatype = 0;	
//test for a query in the URL
	if(!empty($_REQUEST["loctype"])){
		header('Content-type: text/xml');
		$loctype = $_REQUEST["loctype"];
		$loctxt = $_REQUEST["loctxt"];
		$orgid = $_REQUEST["orgid"];
		$reportid = $_REQUEST["reportid"];
		$datatype = $_REQUEST["datatype"];
	}
//pass variables to protected function 'get results'
        echo $this->get_results($loctype, $loctxt, $orgid, $reportid, $datatype);
        }
    protected function get_results($loctype, $loctxt, $orgid, $reportid, $datatype) {
//import the connection string 
	global $dsn;
//connection to the database
	$db = &ADONewConnection($dsn);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT "WADE_R"."GetSummaryByLocation"(' . $db->qstr($loctype) . ',' . $db->qstr($loctxt) . ',' . $db->qstr($orgid) . ',' . $db->qstr($reportid) . ',' . $db->qstr($datatype) . ') As answer')->GetRows();
	$result = $rs[0]['answer'];	
	$test = "<WC:WaDE";
	$test2 = substr($result,0,8);	
	if (strcmp($test,$test2)!==0) {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}
	else {
// return the results to the webpage
	return $result;
	}
    }
} 

new WaDESearch_PHP();

?>
