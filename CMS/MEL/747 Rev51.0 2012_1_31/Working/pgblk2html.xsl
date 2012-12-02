<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="cals-tbl-html.xsl"/>

<xsl:output method="html"/>

<xsl:template match="pgblk">
	<html>
	<head>
		<title><xsl:value-of select="title"/></title>
    <script language="javascript" type="text/javascript" >

    function showZoom(a,r) {
    z = a.getZoom();  <!--// get current zoom setting-->
    r[Math.round((r.length-1)*Math.log(z)/Math.log(16))].checked = true; 
    <!--// indicate zoom setting-->
}
function zoomin(a,r) {
        z = a.getZoom();  <!--// get current zoom setting-->
    f = a.getZoomFactor();  <!--// get zoom factor-->
        a.zoom(z*f); <!--// set new zoom-->
    showZoom(a,r);
    a.render();  <!--// now display it-->
}
function fixedZoom(a,f) {
    a.zoom(f);  <!--// set fix zoom factor-->
    a.render();  <!--// now display it-->
}
function pan(a) {
    if (a.getZoom() > 1) {
            a.setModifiers(5,1); 
            <!--// set modifiers to meta+shift (force pan)-->
    }
}
function scroll(a,x,y) {
        z = a.getZoom();  <!--// get current zoom setting-->
        a.scroll(50*x/z,50*y/z); 
        <!--// scroll distance depends on zoom setting-->
    a.render();  <!--// now display it-->
}
function zoomout(a,r) {
        z = a.getZoom(); <!--// get current zoom setting-->
    f = a.getZoomFactor(); <!--// get zoom factor-->
        a.zoom(z/f); <!--// set new zoom-->
    showZoom(a,r)
    a.render(); <!--// now display it-->
}
function zoomreset(a,r) {
        a.zoom(1);  <!--// reset zoom to 1-->
    showZoom(a,r)
    a.render();  <!--// now display it-->
}
function mouseMode(a,m) {
    if (m == 0) 
        a.setModifiers(0,0)
    else if (m == 1)
        a.setModifiers(0,2)
    else if (m == 2)
        a.setModifiers(4,2)
    else if (m == 3) {
        a.setModifiers(1,2)
    }
}
function find(a,t) {
        n = a.findText(t);  <!--// search for text, returns image name-->
    if (n > '') {
        l = a.getLayer(); <!--// get the layer-->
        c = a.getComponent();  <!--// get component number-->
        z = a.getZoom();  <!--// get zoom setting-->
        x = a.getX(l,n,c);  <!--// get x-position of component-->
        y = a.getY(l,n,c); <!--// get y-position of component-->
        a.zoom(z,x,y); <!--// position to component-->
    }
    a.render();
}
function findText(a,t) {
    if ( t > '' ) find(a,t);
}
// this function handles events from applet "afr".
function afrEvent(task,device,ev) {
    showZoom(document.afr,document.nav.zoom)
}

    </script>
		<style type="text/css">
			.toplevel {font-family: monospace; font-size: 10pt;}
			.pgblktitle {font-size: 16pt; font-weight: bold; margin-top: 2em; margin-bottom: 2em; text-align: center;}
			.tasktitle {font-size: 14pt; font-weight: bold; margin-top: 1.5em; margin-bottom: 1.5em;}
			.title {font-size: 12pt; font-weight: bold; margin-top: 1em; margin-bottom: 1em;}
			.lev1 {list-style-type: decimal; margin-top: 1em; margin-bottom: 1em;}
			.lev2 {list-style-type: upper-alpha; margin-top: 1em; margin-bottom: 1em;}
			.lev3 {list-style-type: decimal; margin-top: 1em; margin-bottom: 1em;} 		<!-- surrounded by paren -->
			.lev4 {list-style-type: lower-alpha; margin-top: 1em; margin-bottom: 1em;}	<!-- surrounded by paren -->
			.lev5 {list-style-type: decimal; margin-top: 1em; margin-bottom: 1em;}		<!-- paren following -->
			.lev6 {list-style-type: lower-alpha; margin-top: 1em; margin-bottom: 1em;}	<!-- paren following -->
			.lev7 {list-style-type: decimal; margin-top: 1em; margin-bottom: 1em;}		<!-- underline -->
			.lev8 {list-style-type: lower-alpha; margin-top: 1em; margin-bottom: 1em;}	<!-- underline -->
			.listitem {margin-top: 0.5em; margin-bottom: 0.5em;}
			.u1 {list-style-type: disc; margin-top: 1em; margin-bottom: 1em;}
			.caution {margin-left: 5em; text-indent: -5em; font-weight: bold; color: red; margin-top: 0.5em; margin-bottom: 0.5em;}
			.warning {margin-left: 5em; text-indent: -5em; font-weight: bold; background-color: red; color: white; margin-top: 0.5em; margin-bottom: 0.5em;}
			.note {margin-left: 3.5em; text-indent: -3.5em; background-color: #808080; margin-top: 0.5em; margin-bottom: 0.5em;}
			.undercaution {font-weight: bold; color: red; text-decoration: underline;}
			.underwarning {font-weight: bold; background-color: red; color: white; text-decoration: underline;}
			.undernote {background-color: #808080; text-decoration: underline;}
			.effectivity {font-size: 10pt; background-color: #7CFC00;}
			.sheet {font-weight: bold; font-size: 12pt; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;}
		</style>
	</head>
	<body class="toplevel">
		<xsl:apply-templates select="title"/>
		<xsl:apply-templates select="effect"/>
		<ol class="lev1">
			<xsl:apply-templates select="*[not(name()='title')][not(name()='effect')]"/>
		</ol>
	</body>
	</html>
</xsl:template>

<xsl:template match="pgblk/title">
	<xsl:variable name="label">
		<xsl:value-of select="../@CHAPNBR"/><xsl:text>-</xsl:text><xsl:value-of select="../@SECTNBR"/><xsl:text>-</xsl:text><xsl:value-of select="../@SUBJNBR"/><xsl:text>-</xsl:text><xsl:value-of select="../@PGBLKNBR"/>
	</xsl:variable>

	<p class="pgblktitle">
		<a>
			<xsl:attribute name="name"><xsl:value-of select="parent::pgblk/@KEY"/></xsl:attribute>
			<xsl:copy-of select="$label"/>
			<xsl:text>&#160;</xsl:text>
			<xsl:apply-templates/>
		</a>
	</p>
</xsl:template>

<xsl:template match="task">
	<xsl:variable name="label">
		<xsl:value-of select="@CHAPNBR"/><xsl:text>-</xsl:text><xsl:value-of select="@SECTNBR"/><xsl:text>-</xsl:text><xsl:value-of select="@SUBJNBR"/><xsl:text>-</xsl:text><xsl:value-of select="@FUNC"/>-<xsl:value-of select="@SEQ"/>
	</xsl:variable>

	<p class="tasktitle">
		<xsl:attribute name="id"><xsl:value-of select="@KEY"/></xsl:attribute>
		<xsl:text>TASK </xsl:text><xsl:copy-of select="$label"/>		
	</p>
	<xsl:apply-templates select="effect"/>
	<xsl:apply-templates select="title"/>
</xsl:template>

<xsl:template match="pbfmatr">
	<xsl:apply-templates select="effect"/>
	<xsl:apply-templates select="title"/>
</xsl:template>

<xsl:template match="subtask">
	<xsl:variable name="label">
		<xsl:value-of select="@FUNC"/>-<xsl:value-of select="@SEQ"/>
	</xsl:variable>

	<p class="title">
		<xsl:text>SUBTASK </xsl:text><xsl:copy-of select="$label"/>
	</p>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="pbfmatr/title | task/title">
	
	<li class="listitem">
		<xsl:apply-templates/>
		<ol class="lev2">
			<xsl:apply-templates select="following-sibling::node()"/>
		</ol>
	</li>
</xsl:template>

<xsl:template match="topic | pretopic">
	<xsl:apply-templates select="effect"/>
	<xsl:apply-templates select="title"/>
</xsl:template>

<xsl:template match="subtask/list1 | pbfmatr/list1">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="pretopic/title">
	<li class="listitem">
		<p><xsl:apply-templates/></p>

		<xsl:apply-templates select="following-sibling::node()"/>

	</li>
</xsl:template>


<xsl:template match="topic/title">
	<li class="listitem">
		<xsl:apply-templates/>
		<ol class="lev3">
			<xsl:apply-templates select="following-sibling::node()"/>
		</ol>
	</li>
</xsl:template>

<xsl:template match="pbfmatr//list2">
	<ol class="lev3">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="pretopic//list1">
	<ol class="lev3">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="list2 | pbfmatr//list3">
	<ol class="lev4">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="list3 | pbfmatr//list4">
	<ol class="lev5">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="list4 | pbfmatr//list5">
	<ol class="lev6">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="list5 | pbfmatr//list6">
	<ol class="lev7">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="list6 | pbfmatr//list7">
	<ol class="lev8">
		<xsl:apply-templates/>
	</ol>
</xsl:template>

<xsl:template match="l1item | l2item | l3item | l4item | l5item | l6item | unlitem">
	<li class="listitem"><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="unlist">
	<ul class="u1">
		<xsl:apply-templates/>
	</ul>
</xsl:template>

<xsl:template match="warning">
	<p class="warning">
		<span class="underwarning"><xsl:text>WARNING:</xsl:text></span><xsl:text> </xsl:text><xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="caution">
	<p class="caution">
		<span class="undercaution"><xsl:text>CAUTION:</xsl:text></span><xsl:text> </xsl:text><xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="note">
	<p class="note">
		<span class="undernote"><xsl:text>NOTE:</xsl:text></span><xsl:text> </xsl:text><xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="effect">
	<span class="effectivity">
		<xsl:variable name="tailstart">
			<xsl:text>N</xsl:text><xsl:value-of select="substring(@EFFRG, 1, 3)"/><xsl:text>UP</xsl:text>
		</xsl:variable>
		<xsl:variable name="tailend">
			<xsl:text>N</xsl:text><xsl:value-of select="substring(@EFFRG, 4, 3)"/><xsl:text>UP</xsl:text>
		</xsl:variable>
		<xsl:value-of select="$tailstart"/>
		<xsl:if test="$tailstart != $tailend">
			<xsl:text>-</xsl:text><xsl:value-of select="$tailend"/>
		</xsl:if>
		<xsl:if test="@EFFTEXT">
			<xsl:text>  </xsl:text><xsl:value-of select="@EFFTEXT"/>
		</xsl:if>
	</span>
</xsl:template>

<xsl:template match="graphic">
		<xsl:apply-templates select="sheet"/>
</xsl:template>

<xsl:template match="sheet">
	<p class="sheet">
		<xsl:attribute name="id"><xsl:value-of select="parent::graphic/@KEY"/></xsl:attribute>
    <applet id="afr1" archive="cgmva/cgmVA.zip" width="400"
                height="400" >
      <param name="code" value="CgmViewApplet.class" />
      <param name="filename" >
        <xsl:attribute name="value">
          <xsl:value-of select="@GNBR"/>
          <xsl:text>.cgm</xsl:text>
        </xsl:attribute>
      </param>
      <param name="imagebase" value="images/" />
      <param name="imagemap" value="Afrimap,nil.html,fullscr.html" />
      <param name="showHotspots" value="true" />
      <param name="controls" value="Click for full screen" />
      <param name="eventHandler" value="afrEvent" />
      <param name="bgcolor" value="#ffffff" />
      <param name="mayscript" value="yes" />
      <param name="scriptable" value="true" />
      <param name="allowScriptAccess" value="always" />
      Your browser does not support Java.
      <xsl:attribute name="value">
        <xsl:value-of select="@GNBR"/>
        <xsl:text>.cgm</xsl:text>
      </xsl:attribute>

    </applet>
    <p class="sheet">
      <xsl:value-of select="parent::graphic/title"/>
    </p>
    
    <!-- Use this if right frame enabled and Isoview or any other control is used to display images-->
    <!--<a>
			<xsl:attribute name="href"><xsl:text>images/</xsl:text><xsl:value-of select="@GNBR"/><xsl:text>.cgm</xsl:text></xsl:attribute>
			<xsl:attribute name="target"><xsl:text>rightFrame</xsl:text></xsl:attribute>
				<xsl:value-of select="parent::graphic/title"/>
		</a>-->
		<p class="sheet"><xsl:text> Sheet Number: </xsl:text><xsl:value-of select="@SHEETNBR"/></p>
		<p class="sheet"><xsl:apply-templates select="effect"/></p>
	</p>
</xsl:template>


<xsl:template match="refint | grphcref">
	<a>
	<xsl:choose>
	<xsl:when test="@REFTYPE='pgblk'">
		<xsl:attribute name="href">
      <xsl:text>DocScreen.aspx?KeyID=</xsl:text><xsl:value-of select="@REFID"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
		<xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="@REFID"/></xsl:attribute>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<xsl:template match="refblock">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="chgdesc"/>

</xsl:stylesheet>