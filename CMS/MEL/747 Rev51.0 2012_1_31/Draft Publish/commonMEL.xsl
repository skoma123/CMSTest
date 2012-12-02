<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- This stylesheet contains templates common to airbook, aom, md11aom, and melcdl -->

<!-- FORMAT DATES FROM YYYYMMDD TO MM/DD/YYYY -->
<xsl:template name="format-date">
	<xsl:param name="date" select="99998877"/>
	<xsl:variable name="day">
		<xsl:value-of select="substring($date,7,2)"/>
	</xsl:variable>
	<xsl:variable name="month">
		<xsl:value-of select="substring($date,5,2)"/>
	</xsl:variable>
	<xsl:variable name="year">
		<xsl:value-of select="substring($date,1,4)"/>
	</xsl:variable>

	<xsl:value-of select="$month"/><xsl:text>/</xsl:text>
	<xsl:value-of select="$day"/><xsl:text>/</xsl:text>
	<xsl:value-of select="$year"/>
</xsl:template>


<!--  **************** LEGAL NOTICE TEMPLATES -->

<xsl:template match="proptary | holder | geninfo">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="cpyrght">
	<xsl:if test="year">
	<p>
		<xsl:text>COPYRIGHT </xsl:text><xsl:value-of select="year"/>
		<xsl:text> BY UNITED PARCEL SERVICE</xsl:text>
	</p>
	</xsl:if>
	<xsl:if test="holder">
		<xsl:apply-templates select="holder"/>
	</xsl:if>
</xsl:template>

<!-- **************** CHANGE MARKUP TEMPLATES -->

<xsl:template match="chgdesc"/>

<xsl:template match="revision">
	<span class="revision">
		<xsl:apply-templates/>
<!-- onmouseover="popup('Revised Data.','#FF00FF'); onmouseout="kill()" -->
	</span>
</xsl:template>

<!--************* LINKING TEMPLATES -->
<xsl:template match="refext" priority="0">
	<a>
	<xsl:choose>
	<xsl:when test="@refloc">
		<xsl:attribute name="href">
		<xsl:value-of select="concat('url(',@refloc,')')"/>
                </xsl:attribute>
	</xsl:when>
	<xsl:when test="@docnbr">
		<xsl:attribute name="href">
		<xsl:value-of select="@docnbr"/>
                </xsl:attribute>
	</xsl:when>
	<xsl:otherwise>missing-link-reference</xsl:otherwise>
	</xsl:choose>

	<xsl:apply-templates/>
	</a>
</xsl:template>

<xsl:template match="refint | grphcref">
	<a>
	<xsl:choose>
	<xsl:when test="@reftype">
		<xsl:attribute name="href"><xsl:text>ManualLink.aspx?KeyID=</xsl:text>
      <xsl:value-of select="@refid"/></xsl:attribute>
    <xsl:attribute name="target">_blank</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
		<xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="@refid"/></xsl:attribute>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates/>
	</a>
</xsl:template>

<!-- ******************* FORMAT TEMPLATES -->
<xsl:template match="sub">
	<sub><xsl:apply-templates/></sub>
</xsl:template>

<xsl:template match="super">
	<sup><xsl:apply-templates/></sup>
</xsl:template>

<xsl:template match="emphasis">
	<xsl:choose>
	<xsl:when test="@role='bold'">
		<span class="bold"><xsl:apply-templates/></span>
	</xsl:when>
	<xsl:when test="@role='italic'">
		<span class="italic"><xsl:apply-templates/></span>
	</xsl:when>
	<xsl:when test="@role='underline'">
		<span class="underline"><xsl:apply-templates/></span>
	</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- **************** TITLE STRUCTURE TEMPLATES -->
<!-- This template is only for a generic title structure. Most often templates exist for specific titles. -->

<xsl:template match="title">
        <a>
		<xsl:if test="../@key"><xsl:attribute name="id"><xsl:value-of select="../@key"/></xsl:attribute></xsl:if>
		<xsl:apply-templates/>
        </a>
</xsl:template>

<!-- **************** BASIC STRUCTURE TEMPLATES -->
<xsl:template match="para">
	<xsl:choose>
	<xsl:when test="parent::numlitem | parent::unlitem | parent::warning | parent::note | parent::caution | parent::exception | parent:: example">
		<xsl:apply-templates/>
	</xsl:when>
	<xsl:otherwise>
		<p><xsl:apply-templates/></p>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="example"> 
	<p class="hangindent">
		<xsl:text>EXAMPLE: </xsl:text><xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="exception"> 
	<p class="hangindent">
		<xsl:text>EXCEPTION: </xsl:text><xsl:apply-templates/>
	</p>
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

<xsl:template match="proc"> 
	<p class="hangindent">
		<span class="bold"><xsl:text>PROC: </xsl:text></span><xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="numlist">
	<ol><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="numlitem">
	<li class="nohtmllist">
		<xsl:choose>
		<xsl:when test="ancestor::mel and ancestor::remarks and ../../../remarks">
			<xsl:number format="a"/><xsl:text>)  </xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
			<xsl:when test="parent::numlist/@restart='N' and ancestor::table">
				<xsl:number count="numlitem[not(ancestor::numlitem)]" format="1" from="table" level="any"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:number format="1"/>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:text>.  </xsl:text>
		</xsl:otherwise>
		</xsl:choose>
	<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="*[not(name()='numlitem')]/numlist/numlitem/numlist/numlitem">
	<li class="nohtmllist">
		<xsl:choose>
		<xsl:when test="ancestor::mel and ancestor::remarks and ../../../../../remarks">
			<xsl:number format="1"/><xsl:text>)  </xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:number format="A"/><xsl:text>.  </xsl:text>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="*[not(name()='numlitem')]/numlist/numlitem/numlist/numlitem/numlist/numlitem">
	<li class="nohtmllist">
		<xsl:text>(</xsl:text><xsl:number format="1"/><xsl:text>)  </xsl:text>
		<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="*[not(name()='numlitem')]/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem">
	<li class="nohtmllist">
		<xsl:text>(</xsl:text><xsl:number format="a"/><xsl:text>)  </xsl:text>
		<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="*[not(name()='numlitem')]/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem">
	<li class="nohtmllist">
		<span class="underline"><xsl:number format="1"/></span><xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="*[not(name()='numlitem')]/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem/numlist/numlitem">
	<li class="nohtmllist">
		<span class="underline"><xsl:number format="a"/></span><xsl:text>  </xsl:text>
		<xsl:apply-templates/>
	</li>
</xsl:template>

<xsl:template match="unlist">
	<ul><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="unlitem">
	<li class="nohtmllist">&#x2022;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="*[not(name()='unlitem')]/unlist/unlitem/unlist/unlitem">
	<li class="nohtmllist">&#x2013;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="*[not(name()='unlitem')]/unlist/unlitem/unlist/unlitem/unlist/unlitem">
	<li class="nohtmllist">&#x25A1;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="*[not(name()='unlitem')]/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem">
	<li class="nohtmllist">&#x2022;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="*[not(name()='unlitem')]/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem">
	<li class="nohtmllist">&#x2013;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="*[not(name()='unlitem')]/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem/unlist/unlitem">
	<li class="nohtmllist">&#x25A1;<xsl:text>  </xsl:text><xsl:apply-templates/></li>
</xsl:template>

<!-- ************* CHECKLIST TEMPLATES -->
<xsl:template match="act">
	<table width="100%">
		<xsl:if test="@memory='Y' and not(ancestor::actblock[@memory='Y'])">
			<xsl:attribute name="rules">all</xsl:attribute>
			<xsl:attribute name="frame">border</xsl:attribute>
		</xsl:if>
	<colgroup>
		<col width="70%"/>
		<col width="30%"/>
	</colgroup>
	<tbody>

	<tr>
	<xsl:choose>
	<xsl:when test="@leader='N'">
		<td colspan="2">
			<xsl:value-of select="challenge"/><xsl:text> - </xsl:text><xsl:value-of select="response"/>
		</td>
	</xsl:when>
	<xsl:otherwise>
		<xsl:apply-templates select="challenge"/>
		<xsl:apply-templates select="response[1]"/>
	</xsl:otherwise>
	</xsl:choose>
	</tr>

	<tr>	
	<td colspan="2">
		<xsl:apply-templates select="comment|qrhexclude"/>
	</td></tr>
	</tbody>
	</table>
</xsl:template>

<xsl:template match="challenge">
	<td>
		
		<p><xsl:attribute name="class">challenge</xsl:attribute>
		<xsl:apply-templates/>
		</p>
		<p class="act"><xsl:text>-</xsl:text></p>
	</td>
</xsl:template>

<xsl:template match="response[1]">
	<td>

		<p><xsl:attribute name="class">response</xsl:attribute>
		<xsl:apply-templates/>
		</p>
		<p class="act"><xsl:text>-</xsl:text></p>
		<xsl:apply-templates select="following-sibling::response"/>
	</td>
</xsl:template>

<xsl:template match="response">
	<span class="response"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="comment">
	<p><xsl:apply-templates/></p>
</xsl:template>

<!-- *********** ATOS ELEMENTS ARE NOT DISPLAYED ************** -->

<xsl:template match="srr"/>
<xsl:template match="sai"/>


<!-- *********** ILLUSTRATION TEMPLATES -->
<xsl:template match="graphic">
	<p class="sheet">
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:apply-templates select="title"/>
		<xsl:apply-templates select="effect"/>
	</p>

	<xsl:apply-templates select="sheet|revision"/>
</xsl:template>

<xsl:template match="sheet">
	<p class="sheet">
	<img width="80%">
		<xsl:attribute name="src">
        <xsl:text>images/</xsl:text>
        <xsl:value-of select="@gnbr"/>
        <xsl:text>.png</xsl:text>
		</xsl:attribute>
        </img>
	</p>
	<p class="sheet">
		<xsl:attribute name="id"><xsl:value-of select="@key"/></xsl:attribute>
		<xsl:apply-templates select="effect"/>
		<xsl:apply-templates select="title"/>
	</p>
</xsl:template>

<!-- *********** EFFECT TEMPLATES -->
<xsl:template match="effect">
	<span>
		<xsl:choose>
		<xsl:when test="@chg != 'U'">
			<xsl:attribute name="class">revision</xsl:attribute>
			<xsl:attribute name="style">{font-size: 10pt;}</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="class">effectivity</xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
		<xsl:when test="@effrg='001999' and @efftext='ALL'">
			<xsl:text>Effectivity: ALL</xsl:text>			
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>Effectivity: </xsl:text>
			<xsl:if test="@effrg != '' and @effrg != '001999'">
				<xsl:variable name="tailstart">
					<xsl:text>N</xsl:text><xsl:value-of select="substring(@effrg, 1, 3)"/><xsl:text>UP</xsl:text>
				</xsl:variable>
				<xsl:variable name="tailend">
					<xsl:text>N</xsl:text><xsl:value-of select="substring(@effrg, 4, 3)"/><xsl:text>UP</xsl:text>
				</xsl:variable>	
				<xsl:value-of select="$tailstart"/>
				<xsl:if test="$tailstart != $tailend">
					<xsl:text>-</xsl:text><xsl:value-of select="$tailend"/>
				</xsl:if>
				<xsl:text>  </xsl:text>
			</xsl:if>
			<xsl:if test="@efftext != '' and @efftext != 'ALL'">
				<xsl:value-of select="@efftext"/>
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
	</span>
</xsl:template>

</xsl:stylesheet>