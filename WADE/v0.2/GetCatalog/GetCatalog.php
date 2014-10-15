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
        
	echo $this->get_results($loctype, $loctxt, $orgid, $state);
        }
	
    protected function get_results($loctype, $loctxt, $orgid, $state) {

	global $host, $user, $pass, $dbname;

	$db = ADONewConnection('mssqlnative');
	$db->Connect($host, $user, $pass, $dbname);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT [wade_r].[GetCatalog] (' . $db->qstr($loctype) . ',' . $db->qstr($loctxt) . ',' . $db->qstr($orgid) .','. $db->qstr($state) . ') As Answer')->GetRows();
	$result = $rs[0]['Answer'];	
	
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
