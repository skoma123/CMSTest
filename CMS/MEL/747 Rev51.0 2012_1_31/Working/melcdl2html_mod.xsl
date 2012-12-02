<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version='1.0'
                 xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
                 xmlns:fo='http://www.w3.org/1999/XSL/Format'
                 xmlns:fox='http://xml.apache.org/fop/extensions'
                 xmlns:date='java.util.Date'
                 xmlns:format='java.text.SimpleDateFormat'
exclude-result-prefixes='date'>



<xsl:import href="commonMEL.xsl"/>

<xsl:output 
	method="html" 
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<xsl:include href="cals-tbl-html.xsl"/>

<xsl:template match="/">
	<html>
	<head>
		<style type="text/css">
			.toplevel {font-family: sans-serif; font-size: 10pt; padding: 2em}
			h1 {font-size: 16pt; font-weight: bold; margin-top: 1em; margin-bottom: 0.5em;}
			h2 {font-size: 12pt; font-weight: bold; margin-top: 0.5em; margin-bottom: 0em;}
			h3 {font-size: 10pt; font-weight: bold; margin-top: 0.25em; margin-bottom: 0em;}
			.nohtmllist {list-style-type: none; margin-top: 1em; margin-bottom: 1em; text-indent: -1.5em }
			.hangindent {margin-left: 5em; text-indent: -5em; margin-top: 0.5em; margin-bottom: 0.5em;}
			.caution {margin-left: 5em; text-indent: -5em; font-weight: bold; color: red; margin-top: 0.5em; margin-bottom: 0.5em;}
			.warning {margin-left: 5em; text-indent: -5em; font-weight: bold; background-color: red; color: white; margin-top: 0.5em; margin-bottom: 0.5em;}
			.note {margin-left: 3em; text-indent: -3em; background-color: #A9A9A9; margin-top: 0.5em; margin-bottom: 0.5em;}
			.undercaution {font-weight: bold; color: red; text-decoration: underline;}
			.underwarning {font-weight: bold; background-color: red; color: white; text-decoration: underline;}
			.undernote {background-color: #A9A9A9; text-decoration: underline;}
			.effectivity {font-size: 10pt; background-color: #7CFC00;}
			.sheet {font-weight: bold; font-size: 10pt; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;}
			.revision {background-color: #FF69B4;}
			.bold {font-weight: bold;}
			.italic {font-style: italic;}
			.underline {text-decoration: underline;}
			.act {border-bottom: 3px dotted black; color: white;}
			.challenge {float: left; border: solid white; background-color: white;}
			.response {float: right; border: solid white; background-color: white;}
		</style>
	</head>
	<body class="toplevel">
		<xsl:apply-templates/>
	</body>
	</html>
</xsl:template>

<!-- FRONT MATTER PAGE BODY -->
<xsl:template match="mfmatr">
	<a><xsl:attribute name="id">
    <xsl:value-of select="@key"/></xsl:attribute></a>
	<xsl:apply-templates/>	
</xsl:template>

<xsl:template match="item">
	<xsl:variable name="label">
	<xsl:value-of select="@chapnbr"/>-<xsl:value-of select="@sectnbr"/>-<xsl:value-of select="@itemnbr"/><xsl:text> </xsl:text>
	</xsl:variable>

	<h1>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:copy-of select="$label"/>
		<xsl:apply-templates select="title"/>
	</h1>

	<xsl:apply-templates select="effect"/>

	<table cellpadding="5">
	<colgroup span="2" width="0*"/>
	<tbody>	
	<tr>
	<td>
		<xsl:text>REV: </xsl:text>
		<xsl:value-of select="@revnbr"/>
	</td>
	<td>
		<xsl:text>REV DATE: </xsl:text>
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="@revdate"/>
		</xsl:call-template>
	</td>
	</tr>
	</tbody>
	</table>

	<xsl:apply-templates select="dispcond"/>
	<xsl:apply-templates select="graphic"/>

	<p class="bold">[End of Item]</p>
</xsl:template>

<xsl:template match="cdlblk">
	<xsl:variable name="label">
	<xsl:value-of select="@chapnbr"/>-<xsl:value-of select="@sectnbr"/>-<xsl:value-of select="@blknbr"/><xsl:text> </xsl:text>
	</xsl:variable>

	<h1>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:copy-of select="$label"/>
		<xsl:apply-templates select="title"/>
	</h1>

	<table cellpadding="5">
	<colgroup span="2" width="0*"/>
	<tbody>	
	<tr>
	<td><xsl:text>REV: </xsl:text><xsl:value-of select="@revnbr"/></td>
	<td>
		<xsl:text>REV DATE: </xsl:text>
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="@revdate"/>
		</xsl:call-template>
	</td>
	</tr>
	</tbody>
	</table>

	<table frame="border" rules="all" cellpadding="3" border="5">
	<colgroup span="1" width="0*"/>
	<tbody>
	<tr>
	<td><xsl:text>Required for all flight conditions except for Remarks and/or Exceptions.</xsl:text></td>
	</tr>
	<tr>
	<td><xsl:text>QTY:  </xsl:text><xsl:value-of select="./attribute::qtyreq"/></td>
	</tr>
	</tbody>
	</table>

	<xsl:apply-templates select="*[not(name()='title')]"/>

	<p class="bold">[End of Item]</p>
</xsl:template>

<xsl:template match="textset">
	<h1>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:apply-templates select="title"/>
	</h1>

	<xsl:if test="@revdate">
		<table cellpadding="5">
		<colgroup span="2" width="0*"/>
		<tbody>	
		<tr>
		<td><xsl:text>REV: </xsl:text><xsl:value-of select="@revnbr"/></td>
		<td>
			<xsl:text>REV DATE: </xsl:text>
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="@revdate"/>
			</xsl:call-template>
		</td>
		</tr>
		</tbody>
		</table>
	</xsl:if>

	<xsl:apply-templates select="*[not(name()='title')]"/>

</xsl:template>

<xsl:template match="textgrp">
	<h2>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:apply-templates select="title"/>
	</h2>
	<xsl:apply-templates select="*[not(name()='title')]"/>
</xsl:template>

<!-- IGNORE THESE ELEMENTS -->
<xsl:template match=" mel/title | dmp/title | cdl/title | section/title | legalntc | revdata | dmp"/>

<!-- PASS THESE ELEMENTS WITHOUT ANY ADDITIONAL MARKUP -->
<xsl:template match="title | remarks/para[1] | melcdl | mel | cdl | chapter | melcdl/title | chapter/title | section">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="dispcond">
	<table frame="border" rules="all" border="5" cellpadding="5">
	<colgroup span="3" width="33%"/>
	<tbody>
	<tr>
		<td>Repair Int Category: <xsl:value-of select="@category"/></td>
		<td>Installed: <xsl:value-of select="@nbrins"/></td>
		<td>Required: <xsl:value-of select="@nbrreq"/></td>
	</tr>
	</tbody>
	</table>

	<xsl:apply-templates select="remarks"/>

	<!-- WILL INSERT NONE IF NO OPERATION TAG EXISTS -->
	<xsl:choose>
	<xsl:when test="child::operation">
		<xsl:apply-templates select="operation"/>
	</xsl:when>
	<xsl:otherwise>
		<h2>OPERATIONS PROCEDURES</h2>
		<p><xsl:text>NONE</xsl:text></p>
	</xsl:otherwise>
	</xsl:choose>

	<!-- WILL INSERT NONE IF NO LIMITATION TAG EXISTS -->
	<xsl:choose>
	<xsl:when test="child::limitation">
		<xsl:apply-templates select="limitation"/>
	</xsl:when>
	<xsl:otherwise>
		<h2>OPERATIONAL LIMITATIONS</h2>
		<p><xsl:text>NONE</xsl:text></p>
	</xsl:otherwise>
	</xsl:choose>

	<!-- WILL INSERT NONE IF NO PLACARD TAG EXISTS -->
	<xsl:choose>
	<xsl:when test="child::placard">
		<xsl:apply-templates select="placard"/>
	</xsl:when>
	<xsl:otherwise>
		<h2>PLACARD</h2>
		<p><xsl:text>NONE</xsl:text></p>
	</xsl:otherwise>
	</xsl:choose>

	<!-- WILL INSERT NONE IF NO MAINTENANCE TAG EXISTS -->
	<xsl:choose>
	<xsl:when test="child::maintenance">
		<xsl:apply-templates select="maintenance"/>
	</xsl:when>
	<xsl:otherwise>
		<h2>MAINTENANCE PROCEDURES</h2>
		<p><xsl:text>NONE</xsl:text></p>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="remarks">
	<xsl:if test="ancestor::cdlblk">
		<h2><xsl:text>REMARKS AND/OR EXCEPTIONS</xsl:text></h2>
	</xsl:if>
	<xsl:if test="ancestor::dispcond">
		<h2><xsl:text>REMARKS AND EXCEPTIONS</xsl:text></h2>
	</xsl:if>

	<xsl:if test="ancestor::dispcond/@downgrade">
		<p>
			<xsl:value-of select="ancestor::dispcond/@downgrade"/>
		</p>
	</xsl:if>

	<p>
		<xsl:if test="ancestor::dispcond/@maintenance='YES'">
			<xsl:text>(M)</xsl:text>
		</xsl:if>
		<xsl:if test="ancestor::dispcond/@operation='YES'">
			<xsl:text>(O)</xsl:text>
		</xsl:if>
		<xsl:if test="(ancestor::dispcond/@maintenance='YES') or (ancestor::dispcond/@operation='YES')">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="operation">
	<h2>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:text>OPERATIONS PROCEDURE</xsl:text>
	</h2>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="limitation">
	<h2>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:text>OPERATIONAL LIMITATIONS</xsl:text>
	</h2>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="placard">
	<h2>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:text>PLACARD</xsl:text>
	</h2>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="maintenance">
	<h2>
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:text>MAINTENANCE PROCEDURE</xsl:text>
	</h2>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ops | ops_type | ops_message | ecam | ecam_group | fltmsg_category | ecam_warning | ecam_fltmsg | ecam_dispcond | ecam_remark">
	<p><xsl:apply-templates/></p>
</xsl:template>

</xsl:stylesheet>