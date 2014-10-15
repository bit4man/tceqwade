<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDECatalog">
   <html>
   <body>
      	<xsl:apply-templates select="WC:Organization"/>
   </body>
   </html>
</xsl:template> 

<xsl:template match="WC:Organization">
	<p><b>Organization: </b> <xsl:value-of select="WC:OrganizationName"/></p>
<!--	<p>For all of <xsl:value-of select="WC:OrganizationName"/>'s summary datasets (availability, allocations, use, physical water supply, regulatory):
		<a><xsl:attribute name="href">
			<xsl:text disable-output-escaping="yes">http://localhost/WADE/v0.2/GetSummary/GetSummary.php?loctype=</xsl:text>
			<xsl:value-of select="WC:Report/WC:Location/WC:LocationType"/>		
			<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
			<xsl:value-of select="WC:Report/WC:Location/WC:LocationText"/>		
			<xsl:text disable-output-escaping="yes">&amp;orgid=</xsl:text>
			<xsl:value-of select="WC:OrganizationIdentifier"/>		
			<xsl:text disable-output-escaping="yes">&amp;reportid=</xsl:text>
			<xsl:value-of select="WC:Report/WC:ReportIdentifier"/>			
			<xsl:text disable-output-escaping="yes">&amp;datatype=ALL</xsl:text>
		</xsl:attribute>
			<xsl:attribute name="TARGET">
			<xsl:text disable-output-escaping="yes">_blank</xsl:text>
		</xsl:attribute>
		View All Summary Data</a></p>-->
	
<table>
	<tr>
	<td>
	<table border="7" cellpadding="3">
	<tr bgcolor="#9acd32">
		<th>Year</th>
		<th>Data Category</th>
		<th>Data Type</th>
		<th>More Information</th>
	</tr>
<xsl:apply-templates select="WC:Report/WC:Location/WC:DataAvailable"/>
</table>
</td>
</tr>
</table>
</xsl:template> 
<xsl:template match="WC:Report/WC:Location/WC:DataAvailable">
	<xsl:for-each select="WC:DataTypes/WC:DataType">
	<xsl:sort select="../../WC:DataCategory"/>
		<tr>
		<td><xsl:value-of select="../../../../WC:ReportingYear"/></td><td><xsl:value-of select="../../WC:DataCategory"/></td><td><xsl:value-of select="."/></td>
	<xsl:choose>
		<xsl:when test="../../WC:DataCategory='SUMMARY'">
			<td><a><xsl:attribute name="href">
				<xsl:text disable-output-escaping="yes">
						http://localhost/WADE/v0.2/GetSummary/GetSummary.php?loctype=</xsl:text>
						<xsl:value-of select="../../../WC:LocationType"/>
						<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
						<xsl:value-of select="../../../WC:LocationText"/>
						<xsl:text disable-output-escaping="yes">&amp;orgid=</xsl:text>
						<xsl:value-of select="../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;reportid=</xsl:text>
						<xsl:value-of select="../../../../WC:ReportIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;datatype=</xsl:text>
						<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						View Data</a></td>
				</xsl:when>
				<xsl:otherwise>
					<td><a><xsl:attribute name="href">
						<xsl:text disable-output-escaping="yes">
						http://localhost/WADE/v0.2/GetDetail/GetDetail.php?reportid=</xsl:text>
						<xsl:value-of select="../../../../WC:ReportIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;loctype=</xsl:text>
						<xsl:value-of select="../../../WC:LocationType"/>
						<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
						<xsl:value-of select="../../../WC:LocationText"/>
						<xsl:text disable-output-escaping="yes">&amp;datatype=</xsl:text>
						<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						View Data</a></td>
				</xsl:otherwise>
			</xsl:choose>	
	</tr>

</xsl:for-each>
</xsl:template> 
</xsl:stylesheet> 

