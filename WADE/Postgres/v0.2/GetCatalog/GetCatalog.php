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
// variables
	$loctype = 0;
	$loctxt = 0; 
	$orgid = 0;
	$state = 0;	
//test for a query parameter
	if(!empty($_REQUEST["loctype"])) {
		header('Content-type: text/xml');
		$loctype = $_REQUEST["loctype"];
		$loctxt = $_REQUEST["loctxt"];
		$orgid = $_REQUEST["orgid"];
		$state = $_REQUEST["state"];
	}
//pass variables to protected function 'get results'

        echo $this->get_results($loctype, $loctxt, $orgid, $state);
        }
    protected function get_results($loctype, $loctxt, $orgid, $state) {
//import the connection string
	global $dsn;
//connection to the database, exception if the connection fails
	$db = &ADONewConnection($dsn);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT "WADE_R"."GetCatalog"(' . $db->qstr($loctype) . ',' . $db->qstr($loctxt) . ',' . $db->qstr($orgid) . ',' . $db->qstr($state) . ') As answer')->GetRows();
	$result = $rs[0]['answer'];		
	$test = "<WC:WaDE";
	$test2 = substr($result,0,8);	
	if (strcmp($test,$test2)!==0) {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}
// return the results to the webpage
	else {
//	return $result;
	return ('<?xml-stylesheet type="text/xsl" href="../styles/catalog.xsl"?>' . $result);	
	}
	}
}

new WaDESearch_PHP();
?>
