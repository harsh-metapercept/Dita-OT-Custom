<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="2.0">

                <xsl:attribute-set name="base-font">
    <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
  </xsl:attribute-set>


          <!--Chapter's summary section that is displayed immediately after the chapter's minitoc.-->
        <xsl:attribute-set name="pdf2.ug__toc__mini__summary">
            <xsl:attribute name="space-before">20pt</xsl:attribute>
        </xsl:attribute-set>
        
        <!-- Attribute set used when rendering the chapter's MINITOC for ug customization.-->
        <!--Heading for mini toc-->
        <xsl:attribute-set name="pdf2.ug__toc__mini">
            <xsl:attribute name="font-size">9pt</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="end-indent">5pt</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="pdf2.ug.chapter.name.and.number">
            <xsl:attribute name="space-before">0pt</xsl:attribute>
            <xsl:attribute name="space-after">16.8pt</xsl:attribute>
        </xsl:attribute-set>

        <!--FO attributes for chapter name.-->
        <xsl:attribute-set name="pdf2.ug.topic.title">
            <xsl:attribute name="font-size">24pt</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="font-weight">bold</xsl:attribute>
            <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
             <xsl:attribute name="color">#015F74</xsl:attribute>
            <!-- <xsl:attribute name="color">#15325F</xsl:attribute> -->
        </xsl:attribute-set>

        <xsl:attribute-set name="topic.title">
             <xsl:attribute name="font-size">18px</xsl:attribute> 
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="font-weight">bold</xsl:attribute> 
            <xsl:attribute name="color">#015F74</xsl:attribute>
            <xsl:attribute name="page-break-before">always</xsl:attribute>
        </xsl:attribute-set>

        <!--Common Borders-->
        <xsl:attribute-set name="common.border__top">
            <xsl:attribute name="border-before-style">none</xsl:attribute>
            <xsl:attribute name="border-before-width">1pt</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="common.border__bottom">
            <xsl:attribute name="border-after-style">none</xsl:attribute>
            <xsl:attribute name="border-after-width">1pt</xsl:attribute>
            <xsl:attribute name="border-after-color">white</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="common.border__right">
            <xsl:attribute name="border-end-style">solid</xsl:attribute>
            <xsl:attribute name="border-end-width">1pt</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="common.border__left">
            <xsl:attribute name="border-start-style">solid</xsl:attribute>
            <xsl:attribute name="border-start-width">1pt</xsl:attribute>
        </xsl:attribute-set>

        <!--Chapter Topic Title-->
        <xsl:attribute-set name="topic.topic.title" use-attribute-sets="topic.border__bottom">
            <xsl:attribute name="color">#015F74</xsl:attribute>
            <xsl:attribute name="font-weight">bold</xsl:attribute>
            <xsl:attribute name="font-size">18px</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="padding-top">0pt</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="topic.border__bottom">
            <xsl:attribute name="border-after-style">none</xsl:attribute>
        </xsl:attribute-set>

        <!--Style for chatper topic's Sub-topic-->
        <xsl:attribute-set name="topic.topic.topic.title">
            <xsl:attribute name="font-size">16px</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="color">#015F74</xsl:attribute>
            <xsl:attribute name="font-weight">bold</xsl:attribute>
        </xsl:attribute-set>
    
        <xsl:attribute-set name="topic.topic.topic.topic.title">
            <xsl:attribute name="font-size">14px</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="color">#015F74</xsl:attribute>
            <xsl:attribute name="font-weight">bold</xsl:attribute>
        </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">14px</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">14px</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">14px</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.title__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.title__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.topic.title__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.topic.topic.topic.topic.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="otherheadings">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">pink</xsl:attribute>
    </xsl:attribute-set>
    
    <!--<xsl:attribute-set name="p_child" use-attribute-sets="common.block">
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="space-after">0em</xsl:attribute>
    </xsl:attribute-set>-->

        <!-- paragraph-like blocks -->
<!--        <xsl:attribute-set name="common.block">
            <xsl:attribute name="space-before">1em</xsl:attribute>
            <xsl:attribute name="font-size">12pt</xsl:attribute>
            <xsl:attribute name="font-family">roboto</xsl:attribute>
            <xsl:attribute name="space-after">1em</xsl:attribute>
        </xsl:attribute-set>
-->
        <xsl:attribute-set name="__force__page__count">
            <xsl:attribute name="force-page-count">auto</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="page-sequence.notice" use-attribute-sets="__force__page__count page-sequence.frontmatter">
            <xsl:attribute name="text-align">center</xsl:attribute>
        </xsl:attribute-set>

        <xsl:attribute-set name="page-sequence.preface" use-attribute-sets="__force__page__count page-sequence.frontmatter">
            <xsl:attribute name="text-align">center</xsl:attribute>
        </xsl:attribute-set>
    
    
    

        <!-- section title -->
        <xsl:attribute-set name="section.title">
         <xsl:attribute name="font-weight">bold</xsl:attribute>
         <xsl:attribute name="color">#015F74</xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
        <xsl:attribute name="font-size">14px</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        </xsl:attribute-set>
    
    
    <!--Unordered list-->
    <xsl:attribute-set name="ul" use-attribute-sets="common.block">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="margin-left">8pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label__content">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
    </xsl:attribute-set>
    
    <!--Ordered list-->
    <xsl:attribute-set name="ol" use-attribute-sets="common.block">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="margin-left">8pt</xsl:attribute>
        <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="color">#015F74</xsl:attribute>
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="ol.li__content">
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">roboto</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="common.link">
        <xsl:attribute name="color">#2E5C94</xsl:attribute>
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>    
    
    
</xsl:stylesheet>
