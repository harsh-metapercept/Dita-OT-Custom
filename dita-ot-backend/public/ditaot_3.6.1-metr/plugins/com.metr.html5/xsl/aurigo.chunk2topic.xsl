<?xml version="1.0" encoding="UTF-8"?>
<!-- for Prog manual -->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                exclude-result-prefixes="xs opentopic">

<!-- ===================== INCLUDES/IMPORTS ====================== -->

<!-- ================== PARAMETERS / VARIABLES =================== -->
<xsl:variable name="gChunk2Content" select="'to-content'"/>

<!-- ======================= TEMPLATES =========================== -->

<!-- =================================================
 /// @brief   root
 /// @todo    
     ================================================= -->
<xsl:template match="/">
  <xsl:apply-templates/>
  <xsl:apply-templates select="@href"/>
</xsl:template>

<!-- =================================================
 /// @brief   default action
 /// @todo    
     ================================================= -->
<xsl:template match="*|@*|processing-instruction()">
  <xsl:apply-templates select="." mode="copy"/>
</xsl:template>

<xsl:template match="*|@*|processing-instruction()" mode="copy">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<!-- =================================================
 /// @brief   [OVERWROTE] topic/title
 /// @author  YIT
 /// @since   2013/08/23
 /// @note    処理切り分けのため
 /// @todo    
     ================================================= -->
  <xsl:template match="*[contains(@class,' map/map ')]">
  <xsl:variable name="isChunk">
    <xsl:choose>
      <!-- 第1階層 (for Service Information) -->
      <xsl:when test="not(ancestor::*[contains(@class,' map/map ')])">
        <xsl:value-of select="true()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="false()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:if test="$isChunk=true()">
      <xsl:attribute name="chunk"><xsl:value-of select="$gChunk2Content"/></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>
     
</xsl:stylesheet>
