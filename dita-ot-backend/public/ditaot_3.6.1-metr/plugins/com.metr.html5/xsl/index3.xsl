<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output indent="yes"/>
    
    
    <xsl:template match="HelpMapPath">
        <HelpMapPath>
            <xsl:apply-templates/>
        </HelpMapPath>
    </xsl:template>
    
    <xsl:param name="PLUGINPATDIR"/>
    
    
    <xsl:variable name="file" select="document(concat('file:///', $PLUGINPATDIR))"/>
    <!--<xsl:variable name="file" select="document('file:///https://github.com/metapercept/Aurigo/blob/master/HelpMap.xml')"/>-->
    
    
    <xsl:template match="Page">
        <xsl:choose>
            <xsl:when test="@helpID = $file//@helpID"></xsl:when>
            <xsl:otherwise>
                <xsl:element name="not-matching">
                    <xsl:if test="@path">
                        <xsl:attribute name="path"><xsl:value-of select="@path"/></xsl:attribute>
                    </xsl:if>
                    <xsl:attribute name="helpID"><xsl:value-of select="@helpID"/></xsl:attribute>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
