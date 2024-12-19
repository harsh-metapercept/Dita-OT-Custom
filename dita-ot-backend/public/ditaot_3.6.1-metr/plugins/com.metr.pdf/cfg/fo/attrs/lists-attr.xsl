<?xml version='1.0'?>

<!-- 
Copyright © 2004-2006 by Idiom Technologies, Inc. All rights reserved. 
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
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <!-- Common attributes for list items -->
    <xsl:attribute-set name="li.itemgroup">
        <xsl:attribute name="space-after">12pt</xsl:attribute> <!-- Increased space-after -->
        <xsl:attribute name="space-before">12pt</xsl:attribute> <!-- Increased space-before -->
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="clear">both</xsl:attribute> <!-- Added clear -->
    </xsl:attribute-set>

    <!-- Unordered list -->
    <xsl:attribute-set name="ul">
        <xsl:attribute name="provisional-distance-between-starts">6mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute> <!-- Increased space-after -->
        <xsl:attribute name="space-before">12pt</xsl:attribute> <!-- Increased space-before -->
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ul.li">
        <xsl:attribute name="space-after">6pt</xsl:attribute> <!-- Increased space-after -->
        <xsl:attribute name="space-before">6pt</xsl:attribute> <!-- Increased space-before -->
        <xsl:attribute name="line-height">20pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- Ordered list -->
    <xsl:attribute-set name="ol">
        <xsl:attribute name="provisional-distance-between-starts">6mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">2mm</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute> <!-- Increased space-after -->
        <xsl:attribute name="space-before">12pt</xsl:attribute> <!-- Increased space-before -->
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="margin-left">6mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="ol.li">
        <xsl:attribute name="space-after">6pt</xsl:attribute> <!-- Increased space-after -->
        <xsl:attribute name="space-before">6pt</xsl:attribute> <!-- Increased space-before -->
        <xsl:attribute name="line-height">20pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- Image attribute set for handling images -->
    <xsl:attribute-set name="image">
        <xsl:attribute name="content-width">scale-down-to-fit</xsl:attribute>
        <xsl:attribute name="content-height">auto</xsl:attribute>
        <xsl:attribute name="space-before">15pt</xsl:attribute> <!-- Increased spacing before the
        image -->
        <xsl:attribute name="space-after">15pt</xsl:attribute> <!-- Increased spacing after the image -->
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="clear">both</xsl:attribute> <!-- Added clear -->
        <xsl:attribute name="margin-top">15pt</xsl:attribute> <!-- Margin on top -->
        <xsl:attribute name="margin-bottom">15pt</xsl:attribute> <!-- Margin on bottom -->
    </xsl:attribute-set>

</xsl:stylesheet>