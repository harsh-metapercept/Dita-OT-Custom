<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">
    <xsl:attribute-set name="pdf2.ug__chapter__frontmatter__number__container" use-attribute-sets="__chapter__frontmatter__number__container">
        <xsl:attribute name="font-size">60pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="pdf2.ug__frontmatter__pagenumber__style">
        <xsl:attribute name="color">#214570</xsl:attribute>
        <!-- <xsl:attribute name="background-color">#15325F</xsl:attribute> -->
        <xsl:attribute name="padding">2.5mm 3mm</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-family">arial</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="pdf2.ug__frontmatter__header__text">
        <xsl:attribute name="color">#214570</xsl:attribute>
        <xsl:attribute name="font-family">arial</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bolder</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="pdf2.ug__frontmatter__footer__text">
        <xsl:attribute name="color">#214570</xsl:attribute>
        <xsl:attribute name="font-family">arial</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bolder</xsl:attribute>
        <!-- <xsl:attribute name="margin-top">5pt</xsl:attribute> -->
    </xsl:attribute-set>

    <xsl:attribute-set name="footer__text">
        <xsl:attribute name="color">#214570</xsl:attribute>
        <xsl:attribute name="font-family">arial</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <!-- <xsl:attribute name="margin-top">5pt</xsl:attribute> -->
    </xsl:attribute-set>
    
    

    <xsl:attribute-set name='logo'>
                <xsl:attribute name='src'>
                    <xsl:attribute name="background-image">url(Customization/OpenTopic/common/artwork/pdf_logo/PDF_FaviconLogo_W100xH55.png)</xsl:attribute>
                </xsl:attribute>
                <!--<xsl:attribute name="display-align">center</xsl:attribute>-->
                <xsl:attribute name="padding-right">9pt</xsl:attribute>
                <xsl:attribute name="width">100%</xsl:attribute>
                <!-- <xsl:attribute name='border-right-width'>1pt</xsl:attribute>
                <xsl:attribute name='border-right-style'>solid</xsl:attribute>
                <xsl:attribute name='border-right-color'>#15325F</xsl:attribute> -->
                <xsl:attribute name="width">100px</xsl:attribute>
        </xsl:attribute-set>

</xsl:stylesheet>