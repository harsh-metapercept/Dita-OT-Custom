<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <!--<xsl:output indent="yes"/>-->
    
    <xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:param name="ditamappath"/>
    <xsl:variable name="dir" select="$ditamappath"/>
    <xsl:variable name="adding" select="concat($dir, 'ditamap-bundle/')"/>
    
    
    <!-- <xsl:template match="dita-merge">
        
        <xsl:value-of select="$newline"/>
        <HelpMapPath><xsl:value-of select="$newline"/>
        <xsl:for-each select="//*[contains(@class, ' topic/topic ')][@oid]">
            <Page>
                <xsl:attribute name="path"><xsl:copy-of select="replace(@xtrf, '.dita', '.html')"/></xsl:attribute>
               <xsl:attribute name="helpID"><xsl:copy-of select="@oid"/></xsl:attribute>
            </Page><xsl:value-of select="$newline"/>
        </xsl:for-each>
        </HelpMapPath>
    </xsl:template> -->
    
</xsl:stylesheet>
 