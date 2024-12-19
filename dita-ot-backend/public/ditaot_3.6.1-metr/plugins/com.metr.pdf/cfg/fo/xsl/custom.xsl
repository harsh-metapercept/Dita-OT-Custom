<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic" version="2.0">

                <xsl:import href="bookmarks.xsl"/>
                <xsl:import href="frontmatter.xsl"/>
                <xsl:import href="lists.xsl"/>
                <xsl:import href="common.xsl"/>
                <!--<xsl:import href="tables.xsl"/>-->
                <xsl:import href="static-content.xsl"/>
                <xsl:import href="note.xsl"/>
                <!--<xsl:import href="preface.xsl"/>-->
                <xsl:import href="layout-masters.xsl"/>
                <!--<xsl:import href="glossary.xsl"/>-->
                <xsl:import href="toc.xsl"/>
                <xsl:import href="topic.xsl"/>


                <xsl:template match="*" mode="getTitle">
                                <xsl:variable name="topic"
                                                select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
                                <xsl:variable name="id" select="$topic/@id"/>
                                <xsl:variable name="mapTopics" select="key('map-id', $id)"/>
                  <fo:inline xsl:use-attribute-sets="__toc__title">
                                                <xsl:for-each select="$mapTopics[1]">
                                                  <xsl:choose>
                                                  <xsl:when test="parent::opentopic:map"/>
                                                  <xsl:when test="ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ') or contains(@class, ' bookmap/backmatter ')]"/>
                                                  <xsl:when test="ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]">
                                                  <xsl:number count="*[contains(@class, ' map/topicref ')][ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]]"
                                                  format="A.1.1" level="multiple"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                                  <xsl:if test="ancestor::bookmap">
                                                  <xsl:number count="*[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class, ' bookmap/frontmatter ')])]"
                                                  format="1.1." level="multiple"/>
                                                                    <xsl:text> </xsl:text>
                                                                  </xsl:if>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:for-each>
                    
                                </fo:inline>
                                
                                <xsl:apply-templates/>
                </xsl:template>


</xsl:stylesheet>
