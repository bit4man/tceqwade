<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:MethodDescriptor">
<html>
<head>
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
   
<xsl:apply-templates select="WC:Method"/>

</xsl:template> 

<xsl:template match="WC:Method">
 <p><h3>Methodology Description for estimating:  <xsl:value-of select="WC:MethodName"/></h3></p>

<xsl:choose>   
   	<xsl:when test="WC:MethodName">
		<table border="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Method Name</th>
       		<th>Method Description</th>
       		<th>Development Date</th>
       		<th>Method Type</th>
       		<th>Timescale</th>
       		<th>URL for More Information</th>
       		<th>Resource Type</th>
       		<th>Applicable Areas</th>
     		</tr>
     		<xsl:for-each select="WC:MethodName">
			<tr>
       			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../WC:MethodDescriptionText"/></td>
			<td><xsl:value-of select="../WC:MethodDevelopmentDate"/></td>
			<td><xsl:value-of select="../WC:MethodTypeText"/></td>
			<td><xsl:value-of select="../WC:TimeScaleText"/></td>
			<td><a><xsl:attribute name="href">
						<xsl:value-of select="../WC:MethodLinkText"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						More Information</a></td>
			<td><xsl:value-of select="../WC:ResourceType/WC:ResourceTypeText"/></td>
			<td><xsl:value-of select="../WC:ApplicableAreas/WC:LocationNameText"/></td>
			</tr>
		</xsl:for-each>
		</font></table>
	</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:DataSource">		
		<p><table border="1"><font face="Times New Roman" size="2">
     		<tr bgcolor="#9acd32">
       		<th>Data Source Name</th>
       		<th>Data Source Description</th>
       		<th>Data Source Time Period - Start</th>
       		<th>Data Source Time Period - End</th>
       		<th>Data Source Information</th>
     		</tr>
     		<xsl:for-each select="WC:DataSource/WC:DataSourceName">
     		<xsl:sort select="WC:DataSource/WC:DataSourceName"/>
			<tr>
       			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceDescription"/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceTimePeriod/WC:TimePeriodStartDate"/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceTimePeriod/WC:TimePeriodEndDate"/></td>
			<td><a><xsl:attribute name="href">
						<xsl:value-of select="../../WC:DataSource/WC:DataSourceLinkText"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						More Information</a></td>
			</tr>
		</xsl:for-each>
		</font></table></p>
		</xsl:when>		
</xsl:choose>
</xsl:template> 
</xsl:stylesheet> 

