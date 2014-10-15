<?php
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/nostyles/config.inc.php");
	include_once ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/adodb/adodb.inc.php");
	include ($_SERVER['DOCUMENT_ROOT']."/WADE/v0.2/adodb/adodb-exceptions.inc.php");

class WaDESearch_PHP {

//initialize

   function __construct() {

        $this->process_request();
    }
    
//clean-up

    function __destruct() {
        
    }

    protected function process_request() {

//variables

	$loctype = 0;
	$loctxt = 0;
	$orgid = 0;
	$reportid = 0;
	$datatype = 0;

//test for a query parameter

	if(!empty($_REQUEST["loctype"])) {


		header('Content-type: text/xml');
		$loctype = $_REQUEST["loctype"];
		$loctxt = $_REQUEST["loctxt"];
		$orgid = $_REQUEST["orgid"];
		$reportid = $_REQUEST["reportid"];
		$datatype = $_REQUEST["datatype"];
	}
        
	echo $this->get_results($loctype, $loctxt, $orgid, $reportid, $datatype);
        }
	
    protected function get_results($loctype, $loctxt, $orgid, $reportid, $datatype) {

	global $host, $user, $pass, $dbname;

	$db = &ADONewConnection('mssqlnative');
	$db->Connect($host, $user, $pass, $dbname);
	$db->SetFetchMode(ADODB_FETCH_ASSOC);
	$db->debug = false;
	$rs = $db->Execute('SELECT [wade_r].[GetSummaryByLocation] (' . $db->qstr($loctype) . ',' . $db->qstr($loctxt) . ',' . $db->qstr($orgid) .','. $db->qstr($reportid) . ',' . $db->qstr($datatype) . ') As Answer')->GetRows();
	$result = $rs[0]['Answer'];	
	
	$test = "<WC:WaDE";
	$test2 = substr($result,0,8);
	$test3 = "</WC:ReportingUnit>";
	$test4 = strpos($result,$test3);
	
	if (strcmp($test,$test2)!==0) {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}
	elseif ($test4===false)  {
		echo '<WaDEResponse>Connection to database was successful, but query parameters were invalid. Please check query parameters.</WaDEResponse>';
	}

// return the results to the webpage
	return $result;

    }

} 

new WaDESearch_PHP();

?>
