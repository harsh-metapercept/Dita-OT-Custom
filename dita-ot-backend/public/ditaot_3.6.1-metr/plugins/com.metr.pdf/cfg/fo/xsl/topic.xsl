<?xml version='1.0'?>

<!--
Copyright ? 2004-2006 by Idiom Technologies, Inc. All rights reserved.
IDIOM is a registered trademark of Idiom Technologies, Inc. and WORLDSERVER
and WORLDSTART are trademarks of Idiom Technologies, Inc. All other
trademarks are the property of their respective owners.

IDIOM TECHNOLOGIES, INC. IS DELIVERING THE SOFTWARE "AS IS," WITH
ABSOLUTELY NO WARRANTIES WHATSOEVER, WHETHER EXPRESS OR IMPLIED,  AND IDIOM
TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE AND WARRANTY OF NON-INFRINGEMENT. IDIOM TECHNOLOGIES, INC. SHALL NOT
BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, COVER, PUNITIVE, EXEMPLARY,
RELIANCE, OR CONSEQUENTIAL DAMAGES (INCLUDING BUT NOT LIMITED TO LOSS OF
ANTICIPATED PROFIT), ARISING FROM ANY CAUSE UNDER OR RELATED TO  OR ARISING
OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF IDIOM
TECHNOLOGIES, INC. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

Idiom Technologies, Inc. and its licensors shall not be liable for any
damages suffered by any person as a result of using and/or modifying the
Software or its derivatives. In no event shall Idiom Technologies, Inc.'s
liability for any damages hereunder exceed the amounts received by Idiom
Technologies, Inc. as a result of this transaction.

These terms and conditions supersede the terms and conditions in any
licensing agreement to the extent that such terms and conditions conflict
with those set forth herein.

This file is part of the DITA Open Toolkit project.
See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:local="http://example.com/local"
    exclude-result-prefixes="dita-ot ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs local"
    version="2.0">


    <xsl:template
        match="*[contains(@class, ' topic/p ')][ancestor::*[contains(@class, ' topic/li ')]]">
        <fo:block xsl:use-attribute-sets="liitemgrouppara">
            <xsl:call-template name="commonattributes"/>
            <xsl:if
                test="*[contains(@class, ' ui-d/uicontrol ')]/*[contains(@class, ' topic/image ')]">
                <xsl:attribute name="line-stacking-strategy">font-height</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' topic/section ')][not(child::*[contains(@class, ' topic/p ')])]">
        <fo:block xsl:use-attribute-sets="p">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' topic/section ')][(child::*[contains(@class, ' topic/p ')])]">

        <fo:block xsl:use-attribute-sets="p">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>



    <!--<xsl:template match="*[contains(@class, ' topic/p ')]">
        <fo:block xsl:use-attribute-sets="p">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="child::image and not(parent::*[contains(@class, ' topic/li ')])">
                <xsl:attribute name="line-stacking-strategy">max-height</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>-->



    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height" as="xs:string?"/>
        <xsl:param name="width" as="xs:string?"/>
        <xsl:param name="scale" as="xs:string?">
            <xsl:choose>
                <xsl:when test="@scale">
                    <xsl:value-of select="@scale"/>
                </xsl:when>
                <xsl:when test="ancestor::*[@scale]">
                    <xsl:value-of select="ancestor::*[@scale][1]/@scale"/>
                </xsl:when>
            </xsl:choose>
        </xsl:param>
        <!--Using align attribute set according to image @align attribute-->
        <xsl:call-template name="processAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
            <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
        </xsl:call-template>
        <fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image">
            <xsl:if test="parent::*[contains(@class, ' topic/fig ')]">
                <xsl:attribute name="border">3px #E1E2E8 solid</xsl:attribute>
            </xsl:if>

            <!--Setting image height if defined-->
            <xsl:if test="$height">
                <xsl:attribute name="content-height">
                    <!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
                    <xsl:choose>
                        <!--xsl:when test="not(string(number($height)) = 'NaN')">
                        <xsl:value-of select="concat($height div 72,'in')"/>
                      </xsl:when-->
                        <xsl:when test="not(string(number($height)) = 'NaN')">
                            <xsl:value-of select="concat($height, 'px')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$height"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <!--Setting image width if defined-->
            <xsl:if test="$width">
                <xsl:attribute name="content-width">
                    <xsl:choose>
                        <!--xsl:when test="not(string(number($width)) = 'NaN')">
                        <xsl:value-of select="concat($width div 72,'in')"/>
                      </xsl:when-->
                        <xsl:when test="not(string(number($width)) = 'NaN')">
                            <xsl:value-of select="concat($width, 'px')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$width"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="not($width) and not($height) and $scale">
                <xsl:attribute name="content-width">
                    <xsl:value-of select="concat($scale, '%')"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@scalefit = 'yes' and not($width) and not($height) and not($scale)">
                <xsl:attribute name="width">100%</xsl:attribute>
                <xsl:attribute name="height">100%</xsl:attribute>
                <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                <xsl:attribute name="scaling">uniform</xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/alt ')]">
                    <xsl:apply-templates select="*[contains(@class, ' topic/alt ')]"
                        mode="graphicAlternateText"/>
                </xsl:when>
                <xsl:when test="@alt">
                    <xsl:apply-templates select="@alt" mode="graphicAlternateText"/>
                </xsl:when>
            </xsl:choose>

            <xsl:apply-templates select="
                    node() except (text(),
                    *[contains(@class, ' topic/alt ') or
                    contains(@class, ' topic/longdescref ')])"/>
        </fo:external-graphic>
    </xsl:template>


    <xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="fig.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="customTitleAnchor"/>
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Figure.title'"/>
                <xsl:with-param name="params">
                    <!--<number>
                        <xsl:apply-templates select="." mode="fig.title-number"/>
                    </number>-->
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>


    <xsl:template match="*[contains(@class, ' task/prereq ')]">
        <fo:block xsl:use-attribute-sets="prereq">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                        <xsl:with-param name="pdf2-string">Task Prereq</xsl:with-param>
                        <xsl:with-param name="common-string">task_prereq</xsl:with-param>
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="prereq__content">
                <fo:block xsl:use-attribute-sets="overview">Before You Begin</fo:block>
                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>



    <xsl:template match="*[contains(@class, ' task/context ')]">
        <xsl:choose>
            <xsl:when test="ancestor::*[contains(@class, ' task/taskbody ')]">

                <fo:block xsl:use-attribute-sets="context">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                        <xsl:with-param name="use-label">
                            <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                                <xsl:with-param name="pdf2-string">Task Context</xsl:with-param>
                                <xsl:with-param name="common-string">task_context</xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:with-param>
                    </xsl:apply-templates>
                    <fo:block xsl:use-attribute-sets="p">
                        <fo:block xsl:use-attribute-sets="overview">Overview</fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block>

            </xsl:when>
            <xsl:otherwise>
                <fo:block xsl:use-attribute-sets="context">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                        <xsl:with-param name="use-label">
                            <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                                <xsl:with-param name="pdf2-string">Task Context</xsl:with-param>
                                <xsl:with-param name="common-string">task_context</xsl:with-param>
                            </xsl:apply-templates>
                        </xsl:with-param>
                    </xsl:apply-templates>
                    <fo:block xsl:use-attribute-sets="p">
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <xsl:template match="*[contains(@class, ' task/steps ')]" name="steps">
        <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
            <xsl:with-param name="use-label">
                <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                    <xsl:with-param name="pdf2-string">Task Steps</xsl:with-param>
                    <xsl:with-param name="common-string">task_procedure</xsl:with-param>
                </xsl:apply-templates>
            </xsl:with-param>
        </xsl:apply-templates>

        <fo:block xsl:use-attribute-sets="overview">Steps</fo:block>
        <fo:list-block xsl:use-attribute-sets="steps">
            <xsl:call-template name="commonattributes"/>

            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>




    <!--<xsl:template match="*[contains(@class,' topic/topic ')][preceding-sibling::*[contains(@class,' topic/topic ')]] |
        *[contains(@class,' topic/topic ')][preceding-sibling::*[contains(@class,' topic/body ')]]">
        <fo:block page-break-before="always">
            <xsl:apply-templates select="*"/>
        </fo:block>
    </xsl:template>-->


</xsl:stylesheet>
