<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">

    <xsl:import href="toc-attr.xsl"/>
    <xsl:import href="frontmatter-attr.xsl"/>
    <xsl:import href="common-attr.xsl"/>
    <xsl:import href="static-content-attr.xsl"/>
    <xsl:import href="layout-masters-attr.xsl"/>
    <xsl:import href="note-attr.xsl"/>
    <xsl:import href="tables-attr.xsl"/> 
    <xsl:import href="topic-attr.xsl"/>
    <xsl:import href="lists-attr.xsl"/>

    <xsl:variable name="page-width">8.27in</xsl:variable>
    <xsl:variable name="page-height">11.69in</xsl:variable>
    
    <!--The side column width is the amount the body text is indented relative to the margin. -->
    <xsl:variable name="side-col-width">0pt</xsl:variable>
    

    <xsl:variable name="mirror-page-margins" select="true()"/>
    <xsl:variable name="generate-back-cover" select="false()"/>

</xsl:stylesheet>