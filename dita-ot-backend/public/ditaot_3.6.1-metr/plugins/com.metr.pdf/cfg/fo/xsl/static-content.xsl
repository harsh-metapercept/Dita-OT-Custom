<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template name="insertBodyFirstFooter">
        <fo:static-content flow-name="first-body-footer">
            <xsl:call-template name="insertFooterContentLeft">
                <xsl:with-param name="addChapterTitle" select="false()"/>
            </xsl:call-template>
        </fo:static-content>
    </xsl:template>


    <!--**** Header ****-->
    <!--Header for Even Pages - Chapter name on right and current topic title on left -->
    <xsl:template name="insertHeaderContentRight">
        <xsl:param name="addChapterTitle" select="true()"/>
        <fo:block text-align="right" start-indent="15mm" font-family="arial" font-weight="bold" end-indent="15mm" margin-top="5mm" margin-bottom="5mm" font-size="2em">
            <xsl:if test="$addChapterTitle">
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__header__text">
                    <fo:retrieve-marker retrieve-class-name="current-header"/>
                </fo:inline>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <!--Header for Odd Pages Chapter name on left and current topic title on right-->
    <xsl:template name="insertHeaderContentLeft">
        <xsl:param name="addChapterTitle" select="true()"/>
        <fo:block text-align="left" start-indent="15mm" end-indent="15mm" font-family="arial" font-weight="bold" margin-top="5mm" margin-bottom="5mm" font-size="2em">
             <xsl:if test="$addChapterTitle">
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__header__text">
                    <fo:retrieve-marker retrieve-class-name="current-header"/>
                </fo:inline>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <xsl:template name="insertBodyOddHeader">
        <fo:static-content flow-name="odd-body-header">
            <!-- <xsl:call-template name="insertHeaderContentLeft">
                <xsl:with-param name="addChapterTitle" select="true()"/>
            </xsl:call-template> -->
            <fo:block  text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm" margin-top="0mm">
                
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text">
                    <fo:external-graphic xsl:use-attribute-sets='logo'/>
                </fo:inline>

                 <fo:leader leader-pattern="space"/>

                <xsl:if test="$title">
                    <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text" font-weight="bold">
                        <xsl:value-of select="$title"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyEvenHeader">
        <xsl:param name="addChapterTitle" select="true()"/>
        <fo:static-content flow-name="even-body-header">
            <fo:block  text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm" margin-top="0mm">
                
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text">
                    <fo:external-graphic xsl:use-attribute-sets='logo'/>
                </fo:inline>
                
                <fo:leader leader-pattern="space"/>
                    <xsl:if test="$addChapterTitle">
                        <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text" font-weight="bold">
                            <fo:retrieve-marker retrieve-class-name="current-header"/>
                        </fo:inline>
                    </xsl:if>
                
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--**** Footer ****-->
    <!--Footer for Even Pages - doc name and number of left and part number on right-->
    <xsl:template name="insertFooterContentLeft">
        <xsl:param name="addChapterTitle" select="false()"/>
        
        <fo:block text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm">
            <xsl:if test="$title">
                <fo:inline xsl:use-attribute-sets="footer__text">
                    <!-- <xsl:value-of select="$title"/> -->
                     <xsl:text>Copyright © 2024 Metapercept Technology Services LLP All Rights Reserved</xsl:text> 
                </fo:inline>
            </xsl:if>

            <fo:leader leader-pattern="space"/>

            <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__pagenumber__style">
                <fo:page-number/>
            </fo:inline>            
        </fo:block>
    </xsl:template>

    <!--Footer for odd Page - doc name and number of right and part number on left-->
    <xsl:template name="insertFooterContentRight">
        <xsl:param name="addChapterTitle" select="false()"/>
        
        <fo:block text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm">
            <xsl:if test="$title">
                <fo:inline xsl:use-attribute-sets="footer__text">
                    <!-- <xsl:value-of select="$title"/> -->
                     <xsl:text>Copyright © 2024 Metapercept Technology Services LLP All Rights Reserved</xsl:text> 
                </fo:inline>
            </xsl:if>

            <fo:leader leader-pattern="space"/>

            <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__pagenumber__style">
                <fo:page-number/>
            </fo:inline>            
        </fo:block>
    </xsl:template>

    <!--Variables-->
    <xsl:variable name="title">
        <xsl:choose>
            <xsl:when test="*[contains(@class, ' bookmap/chapter ')]/*[contains(@class, ' map/topicref/topic ')]">
                <xsl:apply-templates select="*[contains(@class, ' bookmap/chapter ')]/*[contains(@class, ' map/topicref/topic ')]"/>
            </xsl:when> 
            <xsl:when test="$map/*[contains(@class,' topic/title ')][1]">
                <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
            </xsl:when>
            <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
                <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/descendant::*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="partnumber">
         <fo:block>
            <xsl:value-of select="$map//*[contains(@class, ' bookmap/bookid ')]"/>
          </fo:block>
    </xsl:variable>

    <xsl:template name="insertBodyEvenFooter">
        <fo:static-content flow-name="even-body-footer">
            <xsl:call-template name="insertFooterContentLeft">
                <xsl:with-param name="addChapterTitle" select="true()"/>
            </xsl:call-template>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyOddFooter">
        <fo:static-content flow-name="odd-body-footer">
            <xsl:if test="$mirror-page-margins">
                <xsl:call-template name="insertFooterContentRight">
                    <xsl:with-param name="addChapterTitle" select="true()"/>
                </xsl:call-template>
            </xsl:if>
        </fo:static-content>
    </xsl:template>

    <!--TOC Header and Footer-->
    <xsl:template name="insertTocOddHeader">
        <fo:static-content flow-name="odd-toc-header">
            <fo:block  text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm" margin-top="5mm">
                
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text">
                    <fo:external-graphic xsl:use-attribute-sets='logo'/>
                </fo:inline>
                
                <fo:leader leader-pattern="space"/>
                
                <xsl:if test="$title">
                    <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text" font-weight="bold">
                        <xsl:value-of select="$title"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    <xsl:template name="insertTocEvenHeader">
        
        <fo:static-content flow-name="even-toc-header">
            
            <fo:block  text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm" margin-top="5mm">
                
                <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text">
                    <fo:external-graphic xsl:use-attribute-sets='logo'/>
                </fo:inline>
                
                <fo:leader leader-pattern="space"/>
                
                <xsl:if test="$title">
                    <fo:inline xsl:use-attribute-sets="pdf2.ug__frontmatter__footer__text" font-weight="bold">
                        <xsl:value-of select="$title"/>
                    </fo:inline>
                </xsl:if>
            </fo:block>
            
        </fo:static-content>
        
    </xsl:template>

    <xsl:template name="insertTocOddFooter">
        <fo:static-content flow-name="odd-toc-footer">
            <fo:block text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm">
                <xsl:if test="$title">
                    <fo:inline xsl:use-attribute-sets="footer__text">
                        <!-- <xsl:value-of select="$title"/> -->
                        <xsl:text>Copyright © 2024 Metapercept Technology Services LLP All Rights Reserved</xsl:text> 
                    </fo:inline>
                </xsl:if>
                <fo:leader leader-pattern="space"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    
    <xsl:template name="insertTocEvenFooter">
        <fo:static-content flow-name="even-toc-footer">
            <fo:block text-align-last="justify" start-indent="15mm" end-indent="15mm" font-size="1.2em" margin-bottom="5mm">
                <xsl:if test="$title">
                    <fo:inline xsl:use-attribute-sets="footer__text">
                        <!-- <xsl:value-of select="$title"/> -->
                        <xsl:text>Copyright © 2024 Metapercept Technology Services LLP All Rights Reserved</xsl:text> 
                    </fo:inline>
                </xsl:if>
                <fo:leader leader-pattern="space"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!--Index Header and Footer-->
    <xsl:template name="insertIndexOddHeader"/>
    <xsl:template name="insertIndexEvenHeader"/>

    <xsl:template name="insertIndexOddFooter"/>
    <xsl:template name="insertIndexEvenFooter"/>

    <!--Glossary Header and Footer-->
    <xsl:template name="insertGlossaryOddHeader"/>
    <xsl:template name="insertGlossaryEvenHeader"/>

    <xsl:template name="insertGlossaryOddFooter"/>
    <xsl:template name="insertGlossaryEvenFooter"/>

</xsl:stylesheet>
