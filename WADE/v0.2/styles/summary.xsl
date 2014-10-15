<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDE">
   <html>
	<head>
	<!--Load the AJAX API-->
    		<script type="text/javascript" src="https://www.google.com/jsapi"></script>   		
   			 
	<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:WaterUseSummary">

		<script type="text/javascript">
      			google.load('visualization', '1', {packages: ['corechart']});
       		</script>
	
       		<script type="text/javascript">

			function drawVisualization() {
          		var data = new google.visualization.arrayToDataTable([
        		['Water Use', 'acre feet per year'],
			<xsl:for-each select="WC:WaterUse">
			<xsl:sort select="WC:WaterUseTypeName"/>
         		  ['<xsl:value-of select="WC:WaterUseTypeName"/>',<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
        		]);
        		var options = {'title':'Water Use','width':400,'height':300,'is3D':true,chma:[0,0,0,0],legend:{position:'bottom'},'colors':['#33CC00', '#00FFFF', '#ec8f6e', '#FF8000', '#BCA9F5']};
        		new google.visualization.PieChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>WaterUse<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data, options);
        		}
			google.setOnLoadCallback(drawVisualization);
		</script>
	
	</xsl:for-each>

	<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:DerivedWaterSupplySummary">
		<script type="text/javascript">
      			google.load('visualization', '1', {packages: ['corechart']});
       		</script>
	
       		<script type="text/javascript">

			function drawVisualization() {
               		var data = new google.visualization.arrayToDataTable([
        		['Water Supply Type', 'acre feet per year'],
			<xsl:for-each select="WC:DerivedWaterSupplyType">
			<xsl:sort select="WC:WaterSupplyTypeName"/>
         		  ['<xsl:value-of select="WC:WaterSupplyTypeName"/>',<xsl:value-of select="WC:SupplyAmountSummary/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
			]);
        		var options = {'title':'Water Supply','width':400,'height':300,'is3D':true,chma:[0,0,0,0],legend:{position:'bottom'},'colors':['#33CC00', '#00FFFF', '#ec8f6e', '#FF8000', '#BCA9F5']};
   		        new google.visualization.BarChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>WaterSupply<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data,options);
   		        }
   		        google.setOnLoadCallback(drawVisualization);
      		</script>
	</xsl:for-each>
	<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:AllocationSummary">
		<script type="text/javascript">
      			google.load('visualization', '1', {packages: ['corechart']});
       		</script>
	
       		<script type="text/javascript">

			function drawVisualization() {
               		var data = new google.visualization.arrayToDataTable([
        		['Allocations', 'acre feet per year'],
			<xsl:for-each select="WC:AllocationUse">
			<xsl:sort select="WC:AllocationUseTypeName"/>
         		  ['<xsl:value-of select="WC:AllocationUseTypeName"/>',<xsl:value-of select="WC:AllocationAmountSummary/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
			]);
        		var options = {'title':'Allocation Percentages','width':400,'height':300,'is3D':true,chma:[0,0,0,0],legend:{position:'bottom'},'colors':['#33CC00', '#00FFFF', '#ec8f6e', '#FF8000', '#BCA9F5']};
   		        new google.visualization.PieChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>Allocation<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data,options);
   		        }
   		        google.setOnLoadCallback(drawVisualization);
      		</script>
	</xsl:for-each>
</head>
<body>
	
        <xsl:apply-templates select="WC:Organization"/>
	
</body>
</html>
</xsl:template> 

<xsl:template match="WC:Organization">
   <h2>Organization Reporting this Information:</h2>
   <table border="1">
     <tr bgcolor="#9acd32">
       <th>Organization ID</th>
       <th>Organization Name</th>
     </tr>
     <tr>
       <td><xsl:value-of select="WC:OrganizationIdentifier"/></td>
       <td><xsl:value-of select="WC:OrganizationName"/></td>
     </tr>
   </table>
   
<xsl:apply-templates select="WC:Report"/>
</xsl:template> 

<xsl:template match="WC:Report">
   <h3>All Geospatial References for this Report:</h3>
   <table border="1">
      <tr bgcolor="#9acd32">
   	<th>Web Feature Service Type</th>
   	<th>WFS URL Address</th>
   	<th>FeatureID Column</th>
      </tr>
      <xsl:for-each select="WC:GeospatialReference/WC:WFSType">
   	   <tr>
   		<td><xsl:value-of select="WC:WFSTypeName"/></td>
   		<td><a><xsl:attribute name="href">
   			<xsl:value-of select="WC:WFSAddressLink"/>
			</xsl:attribute>
			<xsl:attribute name="TARGET">
			<xsl:text disable-output-escaping="yes">
			_blank</xsl:text>
			</xsl:attribute><xsl:value-of select="WC:WFSAddressLink"/></a></td>
   		<td><xsl:value-of select="WC:WFSFeatureIDFieldText"/></td>
  	   </tr>
       </xsl:for-each>
   </table>

<xsl:for-each select="WC:ReportingUnit">
	 <h2>Summary Information For Reporting Unit:  <xsl:value-of select="WC:ReportingUnitIdentifier"/></h2>
  		<table><tr><td><h3>Other Location Information:</h3></td></tr>
					<tr><td><td><b>State:</b></td><td><xsl:value-of select="WC:Location/WC:StateCode"/></td></td></tr>
					<tr><td><td><b>HUC:</b></td><td><xsl:value-of select="WC:Location/WC:HydrologicUnitCode"/></td></td></tr>
					<tr><td><td><b>County FIPS:</b></td><td><xsl:value-of select="WC:Location/WC:CountyFipsCode"/></td></td></tr>
   		</table>
     		<p><b>This summary is relevant for the reporting year: </b>  <xsl:value-of select="../WC:ReportingYear"/></p>
   		<p><b>These data were reported on: </b>  <xsl:value-of select="../WC:ReportingDate"/></p>
   		
	<xsl:choose>
		<xsl:when test="WC:AvailabilitySummary">	
		<table border="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Availability Type</th>
       		<th>Fresh/Saline</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Amount</th>
       		<th>Units</th>
       		<th>Feature ID</th>
       		<th>Amount Methodology</th>
		<th>Metric Name</th>
       		<th>Metric Value</th>
       		<th>Scale Max</th>
       		<th>Metric Methodology</th>
     		</tr>
     		<xsl:for-each select="WC:AvailabilitySummary">
		<xsl:sort select="WC:AvailabilityTypeName"/>
			<tr>
       			<td><xsl:value-of select="WC:AvailabilityTypeName"/></td>
			<td><xsl:value-of select="WC:FreshSalineIndicator"/></td>
			<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<xsl:choose>
				<xsl:when test="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:AmountNumber">
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:AmountNumber, '#,###.00','num')"/></td>
					<td>acre feet/year</td>
					<td><xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
					<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:Method/WC:MethodName"/></a></td>
				</xsl:when>
				<xsl:otherwise>
					<td></td><td></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricName">
					<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricName"/></td>
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricValue, '#,###.00','num')"/></td>
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricScaleNumber, '#,###.00','num')"/></td>
					<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:Method/WC:MethodName"/></a></td>
				</xsl:when>
				<xsl:otherwise>
					<td></td><td></td><td></td>
				</xsl:otherwise>
			</xsl:choose>
			</tr>
		</xsl:for-each>
		</font></table>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:WaterUseSummary">	
			<p><table border="1">
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>WaterUse<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table border="1"><font face="Times New Roman" size="2">
     			<tr bgcolor="#9acd32">
			<th>Beneficial Use</th>
       			<th>Consumptive Use?</th>
       			<th>Fresh/Saline</th>
       			<th>Source Type</th>
       			<th>Irrigation Type</th>
       			<th>Acres Irrigated</th>
       			<th>Crop Type</th>
       			<th>Population Served</th>
       			<th>Power Generated (MWH)</th>       			
       			<th>Amount</th>
       			<th>Units</th>
       			<th>Start Date</th>
       			<th>End Date</th>
       			<th>Feature ID</th>
       			<th>Water Use Methodology</th>
			</tr>
			<xsl:for-each select="WC:WaterUseSummary/WC:WaterUse">
			<xsl:sort select="WC:WaterUseTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:WaterUseTypeName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:ConsumptiveIndicator"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:FreshSalineIndicator"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:SourceTypeName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:PopulationServedNumber"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:PowerGeneratedNumber"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:AmountNumber"/></td>				
				<td>acre feet/year</td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:TimeFrame/WC:TimeFrameStartName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:TimeFrame/WC:TimeFrameEndName"/></td>	
				<td><xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
				<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:Method/WC:MethodName"/></a></td>
				</tr>
				</xsl:for-each>
				</font></table>
				</td>
				</tr>
				</table></p>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:DerivedWaterSupplySummary">	
			<table border="1">
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>WaterSupply<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table border="1"><font face="Times New Roman" size="2">
     			<tr bgcolor="#9acd32">
			<th>Supply Type</th>
       			<th>Amount</th>
			<th>Units</th>
			<th>Feature ID</th>
       			<th>Water Supply Methodology</th>
       			</tr>
       			<xsl:for-each select="WC:DerivedWaterSupplySummary/WC:DerivedWaterSupplyType">
			<xsl:sort select="WC:WaterSupplyTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:WaterSupplyTypeName"/></td>
				<td><xsl:value-of select="WC:SupplyAmountSummary/WC:AmountNumber"/></td>
				<td>acre feet/year</td>
				<td><xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
				<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:SupplyAmountSummary/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:SupplyAmountSummary/WC:Method/WC:MethodName"/></a></td>
				</tr>
			</xsl:for-each>
			</font></table>
			</td>
			</tr>
			</table>
		</xsl:when>
	</xsl:choose>

	<xsl:choose>
		<xsl:when test="WC:AllocationSummary">	
			<p><table border="1">
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>Allocation<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table border="1"><font face="Times New Roman" size="2">
     			<tr bgcolor="#9acd32">
			<th>Allocation Beneficial Use</th>
       			<th>Fresh/Saline</th>
       			<th>Source Type</th>
       			<th>Irrigation?</th>
       			<th>Irrigated Acres</th>
       			<th>Crop Type</th>
       			<th>Amount</th>
       			<th>Units</th>
       			<th>Feature ID</th>
			</tr>
			<xsl:for-each select="WC:AllocationSummary/WC:AllocationUse">
			<xsl:sort select="WC:AllocationUseTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:AllocationUseTypeName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:FreshSalineIndicator"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:SourceTypeName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:AmountNumber"/></td>				
				<td>acre feet/year</td>
				<td><xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
				</tr>
				</xsl:for-each>
				</font></table>
				</td>
				</tr>
				</table></p>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:RegulatorySummary">	
			<p><table border="1"><font face="Times New Roman" size="2">
     			<tr bgcolor="#9acd32">
			<th>Regulatory Type</th>
       			<th>Regulatory Status</th>
			<th>Oversight Agency</th>
			<th>Feature ID</th>
       			<th>Regulatory Description</th>
       			</tr>
       			<xsl:for-each select="WC:RegulatorySummary/WC:RegulatoryType">
			<xsl:sort select="WC:RegulatoryTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:RegulatoryTypeName"/></td>
				<td><xsl:value-of select="WC:RegulatoryStatusText"/></td>
				<td><xsl:value-of select="WC:OversightAgencyName"/></td>
				<td><xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
				<td><xsl:value-of select="WC:RegulatoryDescriptionText"/></td>
				</tr>
			</xsl:for-each>
			</font></table></p>
		</xsl:when>
	</xsl:choose>

</xsl:for-each>
</xsl:template> 
</xsl:stylesheet> 

