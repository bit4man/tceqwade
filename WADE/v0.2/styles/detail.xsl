<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDE">
   <html>
   <body>
        <xsl:apply-templates select="WC:Organization"/>
   </body>
   </html>
</xsl:template> 

<xsl:template match="WC:Organization">
   <h2>Organization Reporting this Information</h2>
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

   <p><b>This information is relevant for the reporting year: </b>  <xsl:value-of select="WC:ReportingYear"/></p>
   <p><b>These data were reported on: </b>  <xsl:value-of select="WC:ReportingDate"/></p>

   <xsl:if test="not(WC:ReportDetails/WC:WaterAllocation/WC:Diversion) and not(WC:ReportDetails/WC:WaterAllocation/WC:ConsumptiveUse) and not(WC:ReportDetails/WC:WaterAllocation/WC:ReturnFlow)">
   	<xsl:choose>   
   		<xsl:when test="WC:ReportDetails/WC:WaterAllocation">
   		<p><table border="1" cellpadding="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
       		<th>Feature ID</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Fresh/Saline</th>
       		<th>Total Volume for Allocation</th>
       		<th>Units</th>
       		<th>Total Rate for Allocation</th>
       		<th>Units</th>
       		<th>Allocation Start Date</th>
       		<th>Allocation End Date</th>
       		<th>Source Name</th>
       		<th>Actual Volume Utilized*</th>
       		<th>Units</th>
       		<th>Estimated From?</th>
       		<th>Method</th>
       		<th>Actual Rate Utilized*</th>
       		<th>Units</th>
       		<th>Estimated From?</th>
       		<th>Method</th>
       		<th>Actual Start Date</th>
       		<th>Actual End Date</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:AllocationAmount/WC:WaterAllocated/WC:BeneficialUse/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../../WC:LegalStatusCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../../WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../../WC:SourceName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/></a></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:Method/WC:MethodName"/></a></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:TimeFrame/WC:TimeFrameEndName"/></td>			
		</tr>
		</xsl:for-each>
	</font></table></p>
	<p><b>* Indicates the total amount of water actually diverted from all diversions associated with this allocation
	OR the total amount of water that flowed for the allocation if no diversion, e.g. an instream flow allocation.</b></p>	
	</xsl:when>
	</xsl:choose>
</xsl:if>

<xsl:choose>
   <xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:Diversion">	
   <p><table border="1" cellpadding="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Diversion ID</th>
       		<th>Diversion Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
       		<th>Feature ID</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Fresh/Saline</th>
       		<th>Allocated Volume for Diversion</th>
       		<th>Units</th>
       		<th>Allocated Rate for Diversion</th>
       		<th>Units</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Source Name</th>
       		<th>Actual Volume Diverted</th>
       		<th>Units</th>
       		<th>Actual Rate Diverted</th>
       		<th>Units</th>
     		</tr>
	<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:Diversion/WC:DiversionAmount/WC:WaterAllocated/WC:BeneficialUse/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../../../WC:LegalStatusCode"/></td>
			<td><xsl:value-of select="../../../../WC:DiversionIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DiversionName"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../../WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../../WC:SourceName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountUnitsCode"/></td>
		</tr>
	</xsl:for-each>
	</font></table></p>
	</xsl:when>
	<xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:ConsumptiveUse">	
		<p><table border="1" cellpadding="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Consumptive Use ID</th>
       		<th>Consumptive User Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
      		<th>Feature ID</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Source Name</th>
       		<th>Fresh/Saline</th>
       		<th>Irrigation Method</th>
       		<th>Acres Irrigated</th>
       		<th>Crop Type</th>
       		<th>Energy Generation</th>
       		<th>Power Capacity</th>
       		<th>Volume of Use</th>
       		<th>Units</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Estimated From?</th>
       		<th>Method</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:ConsumptiveUse/WC:UseEstimate/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../WC:LegalStatusCode"/></td>			
			<td><xsl:value-of select="../../WC:UserIdentifier"/></td>
			<td><xsl:value-of select="../../WC:UserName"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:SourceName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:ThermoElectricWaterSupply/WC:GeneratorTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:ThermoElectricWaterSupply/WC:PowerCapacityNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:AmountUnitsCode"/></td>		
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:Method/WC:MethodName"/></a></td>
		</tr>
	</xsl:for-each>
	</font></table></p>
	</xsl:when>
	<xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:ReturnFlow">	
		<p><table border="1" cellpadding="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Return Flow ID</th>
       		<th>Return Flow Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
      		<th>Feature ID</th>
       		<th>Volume of Return Flow</th>
       		<th>Units</th>
       		<th>Estimated From?</th>
       		<th>Method</th>
       		<th>Rate of Return Flow</th>
       		<th>Units</th>       		
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Estimated From?</th>
       		<th>Method</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:ReturnFlow/WC:ReturnFlowName">
		<xsl:sort select="../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../WC:LegalStatusCode"/></td>			
			<td><xsl:value-of select="../WC:ReturnFlowIdentifier"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowName"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:ValueTypeCode"/></td>
			<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
							http://localhost/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:Method/WC:MethodName"/></a>
						</td>			
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:AmountUnitsCode"/></td>		
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:ValueTypeCode"/></td>			
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:Method/WC:MethodName"/></td>
		</tr>
		</xsl:for-each>
		</font></table></p>
	</xsl:when>
</xsl:choose>
</xsl:template> 
</xsl:stylesheet> 

