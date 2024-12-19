<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    exclude-result-prefixes="xs opentopic-index opentopic opentopic-func ot-placeholder"
    version="2.0">

    <xsl:template name="createBookmarks">
        <xsl:variable name="bookmarks" as="element()*">
            <xsl:choose>
                <xsl:when test="$retain-bookmap-order">
                    <xsl:apply-templates select="/" mode="bookmark" />
                </xsl:when>
                <xsl:otherwise>

                    <!-- Generate front cover bookmark if applicable -->
                    <xsl:if test="$generate-front-cover">
                        <xsl:variable name="frontCoverDest"
                            select="$map/*[contains(@class,' topic/title ')]/@id" />
                        <xsl:if
                            test="$frontCoverDest">
                            <fo:bookmark internal-destination="{$frontCoverDest}">
                                <fo:bookmark-title>
                                    <xsl:value-of select="$map/*[contains(@class,' topic/title ')]" />
                                </fo:bookmark-title>
                            </fo:bookmark>
                        </xsl:if>
                    </xsl:if>

                    <!-- Create bookmarks for topics -->
                    <xsl:for-each
                        select="/*/*[contains(@class, ' topic/topic ')]">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType" />
                        </xsl:variable>
                        <xsl:variable
                            name="topicId" select="@id" />

                        <!-- Check if topicType is topicNotices -->
                        <xsl:if
                            test="$topicType = 'topicNotices' and $topicId">
                            <fo:bookmark internal-destination="{$topicId}">
                                <fo:bookmark-title>
                                    <xsl:value-of select="*[contains(@class, ' topic/title ')]" />
                                </fo:bookmark-title>
                            </fo:bookmark>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- Generate Table of Contents bookmark -->
                    <xsl:choose>
                        <xsl:when test="$map//*[contains(@class,' bookmap/toc ')][@href]" />
                        <xsl:when
                            test="$map//*[contains(@class,' bookmap/toc ')]
                            | /*[contains(@class,' map/map ')][not(contains(@class,' bookmap/bookmap '))]">
                            <xsl:if test="$generate-toc">
                                <fo:bookmark internal-destination="{$id.toc}">
                                    <fo:bookmark-title>
                                        <xsl:call-template name="getVariable">
                                            <xsl:with-param name="id" select="'Table of Contents'" />
                                        </xsl:call-template>
                                    </fo:bookmark-title>
                                </fo:bookmark>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>

                    <!-- Create bookmarks for other content (glossary, tables, figures) -->
                    <xsl:for-each
                        select="/*/*[contains(@class, ' topic/topic ')] |
                        /*/ot-placeholder:glossarylist |
                        /*/ot-placeholder:tablelist |
                        /*/ot-placeholder:figurelist">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType" />
                        </xsl:variable>
                        <xsl:variable
                            name="topicId" select="@id" />
                        <xsl:if
                            test="not($topicType = 'topicNotices') and $topicId">
                            <fo:bookmark internal-destination="{$topicId}">
                                <fo:bookmark-title>
                                    <xsl:value-of select="*[contains(@class, ' topic/title ')]" />
                                </fo:bookmark-title>
                            </fo:bookmark>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- Apply bookmarks for the index -->
                    <xsl:apply-templates
                        select="/*" mode="bookmark-index" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Output bookmark tree if bookmarks exist -->
        <xsl:if
            test="exists($bookmarks)">
            <fo:bookmark-tree>
                <xsl:copy-of select="$bookmarks" />
            </fo:bookmark-tree>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>