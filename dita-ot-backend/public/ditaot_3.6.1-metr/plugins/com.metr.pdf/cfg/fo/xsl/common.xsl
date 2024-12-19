<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot" version="2.0">

    <!-- Move figure title to top and description to bottom -->
    <xsl:template match="*[contains(@class, ' topic/fig ')]">
        <fo:block text-align="left" xsl:use-attribute-sets="image" keep-together.within-page="always" line-stacking-strategy="max-height">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:call-template name="get-id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
            <xsl:apply-templates
                select="*[not(contains(@class, ' topic/title ') or contains(@class, ' topic/desc '))]"/>
            <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
        </fo:block>
    </xsl:template>

    <xsl:param name="pdf2.ug.chapter.header"/>

    <xsl:param name="pdf2.ug.chapter.minitoc.layout"/>

    <xsl:template match="*" mode="insertChapterFirstpageStaticContent">
        <xsl:param name="type" as="xs:string"/>

        <xsl:attribute name="id">
            <xsl:call-template name="generate-toc-id"/>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="$type = 'chapter'">
                <xsl:choose>
                    <!-- Default DITA-OT rendering -->
                    <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                        <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Chapter with number'"/>
                                <xsl:with-param name="params">
                                    <number>
                                        <fo:block
                                            xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                            <xsl:apply-templates select="key('map-id', @id)[1]"
                                                mode="topicTitleNumber"/>
                                        </fo:block>
                                    </number>
                                </xsl:with-param>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--  title-and-chapter-number - Title aligned in the left part and chapter number in the right -->
                        <!--  <fo:block xsl:use-attribute-sets="pdf2.ug.topic.title" font-size="30pt">
-->
                        <xsl:apply-templates select="key('map-id', @id)[1]" mode="topicTitleNumber"/>
                        <!--</fo:block>-->
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:when>
            <xsl:when test="$type = 'appendix'">
                <xsl:choose>
                    <!-- Default DITA-OT processing -->
                    <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                        <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Appendix with number'"/>
                                <xsl:with-param name="params">
                                    <number>
                                        <fo:block
                                            xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                            <xsl:apply-templates select="key('map-id', @id)[1]"
                                                mode="topicTitleNumber"/>
                                        </fo:block>
                                    </number>
                                </xsl:with-param>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--title-and-appendix-number - Title aligned in the left part and appendix number in the right -->
                        <fo:block
                            xsl:use-attribute-sets="pdf2.ug__chapter__frontmatter__number__container">
                            <xsl:apply-templates select="key('map-id', @id)[1]"
                                mode="topicTitleNumber"/>
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$type = 'appendices'">
                <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Appendix with number'"/>
                        <xsl:with-param name="params">
                            <number>
                                <fo:block
                                    xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                    <xsl:text>&#xA0;</xsl:text>
                                </fo:block>
                            </number>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:block>
            </xsl:when>
            <xsl:when test="$type = 'part'">
                <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Part with number'"/>
                        <xsl:with-param name="params">
                            <number>
                                <fo:block
                                    xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                    <xsl:apply-templates select="key('map-id', @id)[1]"
                                        mode="topicTitleNumber"/>
                                </fo:block>
                            </number>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:block>
            </xsl:when>
            <xsl:when test="$type = 'preface'">
                <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Preface title'"/>
                    </xsl:call-template>
                </fo:block>
            </xsl:when>
            <xsl:when test="$type = 'notices'">
                <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                    <xsl:call-template name="getVariable">
                        <xsl:with-param name="id" select="'Notices title'"/>
                    </xsl:call-template>
                </fo:block>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Bookmap Chapter processing -->
    <xsl:template name="processTopicChapter">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="page-sequence.body">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>

                    <xsl:if test="$level eq 1">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:apply-templates select="." mode="topicTitleNumber"/>
                            </xsl:for-each>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>
                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
                    <xsl:choose>
                        <!-- The default DITA-OT processing -->
                        <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">

                            <!--                             <xsl:apply-templates select="." mode="insertChapterFirstpageStaticContent">
                                <xsl:with-param name="type" select="'chapter'"/>
                            </xsl:apply-templates> 
-->
                            <fo:block xsl:use-attribute-sets="topic.title">
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:when>

                        <xsl:otherwise>
                            <fo:block xsl:use-attribute-sets="topic.title">
                                <xsl:apply-templates select="."
                                    mode="insertChapterFirstpageStaticContent">
                                    <xsl:with-param name="type" select="'chapter'"/>
                                </xsl:apply-templates>
                                <xsl:text>. </xsl:text>

                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>

                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:choose>
                        <xsl:when test="$chapterLayout = 'BASIC'">
                            <xsl:apply-templates select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!-- Process bookmap notices -->
    <xsl:template name="processTopicNotices">
        <xsl:variable name="atts" as="element()">
            <xsl:choose>
                <xsl:when
                    test="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                    <dummy xsl:use-attribute-sets="page-sequence.backmatter.notice"/>
                </xsl:when>
                <xsl:otherwise>
                    <dummy xsl:use-attribute-sets="page-sequence.notice"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:page-sequence master-reference="body-sequence">
            <xsl:copy-of select="$atts/@*"/>
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertPrefaceStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="empty(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:apply-templates select="." mode="topicTitleNumber"/>
                            </xsl:for-each>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>

                    <!-- The default DITA-OT processing -->
                    <xsl:choose>
                        <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                            <xsl:apply-templates select="."
                                mode="insertChapterFirstpageStaticContent">
                                <xsl:with-param name="type" select="'notices'"/>
                            </xsl:apply-templates>
                        </xsl:when>
                    </xsl:choose>

                    <xsl:choose>
                        <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                            <fo:block xsl:use-attribute-sets="topic.title">
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block
                                xsl:use-attribute-sets="pdf2.ug.topic.title pdf2.ug.chapter.name.and.number">
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$noticesLayout = 'BASIC'">
                            <xsl:apply-templates select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>


    <xsl:template match="*[contains(@class, ' topic/topicref/note ')]">
        <fo:table>
            <fo:table-column column-number="1" column-width="50mm"/>
            <fo:table-column column-number="2" column-width="180mm"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <fo:external-graphic xsl:use-attribute-sets="image"/>
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="note">
                            <xsl:choose>
                                <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                                    <xsl:apply-templates select="."
                                        mode="insertChapterFirstpageStaticContent">
                                        <xsl:with-param name="type" select="'notices'"/>
                                    </xsl:apply-templates>
                                </xsl:when>
                            </xsl:choose>

                            <xsl:choose>
                                <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                                    <fo:block font-size="70pt" xsl:use-attribute-sets="topic.title">
                                        <xsl:call-template name="pullPrologIndexTerms"/>
                                        <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                            <xsl:apply-templates select="." mode="getTitle"/>
                                        </xsl:for-each>
                                    </fo:block>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:block
                                        xsl:use-attribute-sets="pdf2.ug.topic.title pdf2.ug.chapter.name.and.number">
                                        <xsl:call-template name="pullPrologIndexTerms"/>
                                        <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                            <xsl:apply-templates select="." mode="getTitle"/>
                                        </xsl:for-each>
                                    </fo:block>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="$noticesLayout = 'BASIC'">
                                    <xsl:apply-templates select="
                                            *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                            contains(@class, ' topic/prolog '))]"/>
                                    <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:apply-templates select="." mode="createMiniToc"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <!--Template to display note icons with notices-->
    <xsl:template match="*[contains(@class, ' topic/note ')]">
        <xsl:variable name="noteImagePath">
            <xsl:apply-templates select="." mode="setNoteImagePath"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($noteImagePath = '')">
                <fo:table xsl:use-attribute-sets="note__table">
                    <fo:table-column column-number="1" column-width="50mm"/>
                    <fo:table-column column-number="2" column-width="150mm"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="image">
                                    <fo:external-graphic
                                        src="url('{concat($artworkPrefix, $noteImagePath)}')"
                                        xsl:use-attribute-sets="image" content-width="12px"
                                        content-height="12px"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="note">
                                <xsl:apply-templates select="." mode="placeNoteContent"/>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="placeNoteContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="createMiniToc">
        <xsl:choose>
            <xsl:when test="$pdf2.ug.chapter.minitoc.layout eq 'dita-ot-default'">
                <fo:table xsl:use-attribute-sets="__toc__mini__table">
                    <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_1"/>
                    <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_2"/>
                    <fo:table-body xsl:use-attribute-sets="__toc__mini__table__body">
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="__toc__mini">
                                    <xsl:if test="*[contains(@class, ' topic/topic ')]">
                                        <fo:block xsl:use-attribute-sets="__toc__mini__header">
                                            <xsl:call-template name="getVariable">
                                                <xsl:with-param name="id" select="'Mini Toc'"/>
                                            </xsl:call-template>
                                        </fo:block>
                                        <fo:list-block xsl:use-attribute-sets="__toc__mini__list">
                                            <xsl:apply-templates
                                                select="*[contains(@class, ' topic/topic ')]"
                                                mode="in-this-chapter-list"/>
                                        </fo:list-block>
                                    </xsl:if>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="__toc__mini__summary">
                                <!--Really, it would be better to just apply-templates, but the attribute sets for shortdesc, body
                        and abstract might indent the text.  Here, the topic body is in a table cell, and should
                        not be indented, so each element is handled specially.-->
                                <fo:block>
                                    <xsl:apply-templates
                                        select="*[contains(@class, ' topic/titlealts ')]"/>
                                    <xsl:if test="
                                            *[contains(@class, ' topic/shortdesc ')
                                            or contains(@class, ' topic/abstract ')]/node()">
                                        <fo:block xsl:use-attribute-sets="p">
                                            <xsl:apply-templates select="
                                                    *[contains(@class, ' topic/shortdesc ')
                                                    or contains(@class, ' topic/abstract ')]/node()"
                                            />
                                        </fo:block>
                                    </xsl:if>
                                    <xsl:apply-templates
                                        select="*[contains(@class, ' topic/body ')]/*"/>

                                    <xsl:if test="
                                            *[contains(@class, ' topic/related-links ')]//
                                            *[contains(@class, ' topic/link ')][not(@role) or @role != 'child']">
                                        <xsl:apply-templates
                                            select="*[contains(@class, ' topic/related-links ')]"/>
                                    </xsl:if>

                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:when>
            <xsl:otherwise>
                <fo:block xsl:use-attribute-sets="pdf2.ug__toc__mini">
                    <xsl:if test="*[contains(@class, ' topic/topic ')]">
                        <!-- <fo:block xsl:use-attribute-sets="__toc__mini__header">
                            <xsl:call-template name="getVariable">
                                <xsl:with-param name="id" select="'Mini Toc'"/>
                            </xsl:call-template>
                        </fo:block> -->
                        <fo:inline font-size="12pt" font-family="arial">
                            <xsl:text>This chapter contains the following sections:</xsl:text>
                        </fo:inline>
                        <fo:list-block xsl:use-attribute-sets="__toc__mini__list">
                            <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"
                                mode="in-this-chapter-list"/>
                        </fo:list-block>
                    </xsl:if>
                </fo:block>

                <fo:block xsl:use-attribute-sets="pdf2.ug__toc__mini__summary">
                    <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]"/>
                    <xsl:if test="
                            *[contains(@class, ' topic/shortdesc ')
                            or contains(@class, ' topic/abstract ')]/node()">
                        <fo:block xsl:use-attribute-sets="p">
                            <xsl:apply-templates select="
                                    *[contains(@class, ' topic/shortdesc ')
                                    or contains(@class, ' topic/abstract ')]/node()"
                            />
                        </fo:block>
                    </xsl:if>
                    <xsl:apply-templates select="*[contains(@class, ' topic/body ')]/*"/>

                    <xsl:if test="
                            *[contains(@class, ' topic/related-links ')]//
                            *[contains(@class, ' topic/link ')][not(@role) or @role != 'child']">
                        <xsl:apply-templates select="*[contains(@class, ' topic/related-links ')]"/>
                    </xsl:if>

                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  Bookmap Appendix processing  -->
    <xsl:template name="processTopicAppendix">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="page-sequence.appendix">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>
                    <xsl:if test="$level eq 1">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:apply-templates select="." mode="topicTitleNumber"/>
                            </xsl:for-each>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
                    <xsl:choose>
                        <!-- The default DITA-OT processing -->
                        <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                            <xsl:apply-templates select="."
                                mode="insertChapterFirstpageStaticContent">
                                <xsl:with-param name="type" select="'appendix'"/>
                            </xsl:apply-templates>

                            <fo:block xsl:use-attribute-sets="topic.title">
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:table inline-progression-dimension="100%" table-layout="fixed"
                                xsl:use-attribute-sets="pdf2.ug.chapter.name.and.number">
                                <fo:table-column column-label="1" column-width="90%"/>
                                <fo:table-column column-label="2" column-width="10%"/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell display-align="center" text-align="left">
                                            <fo:block xsl:use-attribute-sets="pdf2.ug.topic.title">
                                                <xsl:call-template name="pullPrologIndexTerms"/>
                                                <xsl:for-each
                                                  select="*[contains(@class, ' topic/title ')]">
                                                  <xsl:apply-templates select="." mode="getTitle"/>
                                                </xsl:for-each>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell display-align="center" text-align="right"
                                        > </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:choose>
                        <xsl:when test="$appendixLayout = 'BASIC'">
                            <xsl:apply-templates select="
                                    *[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                            <!--xsl:apply-templates select="." mode="buildRelationships"/-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>


    <xsl:template name="processFrontMatterTopic">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="page-sequence.frontmatter">
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                    </xsl:if>
                    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
                    <xsl:choose>
                        <xsl:when test="$pdf2.ug.chapter.header eq 'dita-ot-default'">
                            <fo:block xsl:use-attribute-sets="topic.title">
                                <xsl:attribute name="id">
                                    <xsl:call-template name="generate-toc-id"/>
                                </xsl:attribute>
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block
                                xsl:use-attribute-sets="pdf2.ug.topic.title pdf2.ug.chapter.name.and.number">
                                <xsl:attribute name="id">
                                    <xsl:call-template name="generate-toc-id"/>
                                </xsl:attribute>
                                <xsl:call-template name="pullPrologIndexTerms"/>
                                <xsl:for-each select="child::*[contains(@class, ' topic/title ')]">
                                    <xsl:apply-templates select="." mode="getTitle"/>
                                </xsl:for-each>
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))]"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!-- Reset page numbering at first chapter.-->
    <xsl:template name="startPageNumbering" as="attribute()*">
        <xsl:variable name="id"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
        <xsl:variable name="mapTopic" select="key('map-id', $id)"/>
        <xsl:variable name="firstAncestorChapter"
            select="$mapTopic/ancestor-or-self::*[contains(@class, ' bookmap/chapter ')]"/>
        <xsl:if test="
                exists($firstAncestorChapter) and
                not($firstAncestorChapter/preceding::*[contains(@class, ' bookmap/chapter ')])">
            <xsl:attribute name="initial-page-number">1</xsl:attribute>
        </xsl:if>
    </xsl:template>


    <xsl:template match="*" mode="processTopicTitle">
        <xsl:variable name="level" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:variable name="attrSet1">
            <xsl:apply-templates select="." mode="createTopicAttrsName">
                <xsl:with-param name="theCounter" select="$level"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="attrSet2" select="concat($attrSet1, '__content')"/>
        <fo:block xsl:use-attribute-sets="otherheadings" font-family="roboto" color="#015F74"
            font-weight="bold" font-size="12pt">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="processAttrSetReflection">
                <xsl:with-param name="attrSet" select="$attrSet1"/>
                <xsl:with-param name="path" select="'../attrs/commons-attr.xsl'"/>
            </xsl:call-template>
            <fo:block>
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="$attrSet2"/>
                    <xsl:with-param name="path" select="'../attrs/commons-attr.xsl'"/>
                </xsl:call-template>
                <xsl:if test="$level = 1">
                    <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
                </xsl:if>
                <xsl:if test="$level = 2">
                    <xsl:apply-templates select="." mode="insertTopicHeaderMarker">
                        <xsl:with-param name="marker-class-name" as="xs:string"
                            >current-h2</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:if>
                <fo:wrapper id="{parent::node()/@id}"/>
                <fo:wrapper>
                    <xsl:attribute name="id">
                        <xsl:call-template name="generate-toc-id">
                            <xsl:with-param name="element" select=".."/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:wrapper>
                <xsl:apply-templates select="." mode="customTopicAnchor"/>
                <xsl:call-template name="pullPrologIndexTerms"/>
                <xsl:apply-templates
                    select="preceding-sibling::*[contains(@class, ' ditaot-d/ditaval-startprop ')]"/>
                
                <xsl:if test="ancestor::map">
                    <xsl:number count="*[contains(@class,' topic/topic ')]" level="multiple" format="1."/>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="$level = 4">
                        <xsl:text>&#x2003;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:apply-templates select="." mode="getTitle"/>
            </fo:block>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>
