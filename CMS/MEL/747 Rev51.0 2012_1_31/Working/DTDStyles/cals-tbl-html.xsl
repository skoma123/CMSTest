<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<xsl:template match="table[./tgroup]|informaltable" priority="-0.1">
<xsl:apply-templates/>
</xsl:template>





<!-- **********************************************************
       tbl.xsl - transforms OASIS Exchange tables into HTML
     ********************************************************** -->

<xsl:template match="tgroup">
  <table>

    <xsl:if test="../@pgwide=1">
      <xsl:attribute name="width">100%</xsl:attribute>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="../@frame='none'">
        <xsl:attribute name="border">0</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="border">1</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates/>

    <xsl:if test=".//footnote">
      <tr>
        <td colspan="{@cols}">
          <xsl:apply-templates select=".//footnote" 
                               mode="table.footnote.mode"/>
        </td>
      </tr>
    </xsl:if>
  </table>
</xsl:template>

<xsl:template match="colspec"></xsl:template>

<xsl:template match="spanspec"></xsl:template>

<xsl:template match="thead">
  <thead>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </thead>
</xsl:template>

<xsl:template match="tbody">
  <tbody>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </tbody>
</xsl:template>

<xsl:template match="row">
  <tr>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </tr>
</xsl:template>

<xsl:template match="thead/row/entry">
  <th>
    <xsl:if test="@morerows">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@morerows+1"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@namest">
      <xsl:attribute name="colspan">
        <xsl:call-template name="calculate.colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </th>
</xsl:template>

<xsl:template match="tbody/row/entry">
  <td>
    <xsl:if test="@morerows">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@morerows+1"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@namest">
      <xsl:attribute name="colspan">
        <xsl:call-template name="calculate.colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </td>
</xsl:template>

<xsl:template name="colspec.colnum">
  <xsl:param name="colname" select="string('')"/>
  <xsl:param name="colspecs" select="../../../../tgroup/colspec"/>
  <xsl:param name="count" select="number(1)"/>
  <xsl:param name="colnum" select="number(1)"/>
  <xsl:choose>
    <xsl:when test="$count&gt;count($colspecs)"></xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
      <xsl:choose>
        <xsl:when test="$colspec/@colname=$colname">
          <xsl:choose>
            <xsl:when test="$colspec/@colnum">
              <xsl:value-of select="$colspec/@colnum"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="number($colnum)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="colspec.colnum">
            <xsl:with-param name="colname" select="$colname"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="number($colspec/@colnum + 1)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="number($colnum + 1)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="calculate.colspan">
  <xsl:variable name="scol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@namest"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="ecol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@nameend"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="number($ecol - $scol + 1)"/>
</xsl:template>

<!-- **********************************************************
       end tbl.xsl
     ********************************************************** -->

</xsl:stylesheet>