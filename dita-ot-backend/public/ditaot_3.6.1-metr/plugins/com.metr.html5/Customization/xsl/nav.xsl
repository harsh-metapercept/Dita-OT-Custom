<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA Bootstrap plug-in for DITA Open Toolkit.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  version="2.0"
  exclude-result-prefixes="xs dita-ot ditamsg"
>
  <xsl:param name="nav-toc" as="xs:string?"/>
  <xsl:param name="FILEDIR" as="xs:string?"/>
  <xsl:param name="FILENAME" as="xs:string?"/>
  <xsl:param name="BOOTSTRAP_CSS_ACTIVE_NAV_PARENT" select="'active'"/>
  <xsl:param name="input.map.url" as="xs:string?"/>

  <xsl:variable name="input.map" as="document-node()?">
    <xsl:apply-templates select="document($input.map.url)" mode="normalize-map"/>
  </xsl:variable>

  <!-- A topic is active if it is currently selected -->
  <xsl:template name="get-active-class">
    <xsl:choose>
      <xsl:when test=". is $current-topicref">
        <xsl:value-of select="' active'"/>
      </xsl:when>
      <xsl:when test="$nav-toc = ('collapsible')">
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="descendant::*">
          <xsl:if test=". is $current-topicref">
            <xsl:value-of select="concat(' ', $BOOTSTRAP_CSS_ACTIVE_NAV_PARENT)"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- A collapsed list is shown if it is currently selected -->
  <xsl:template name="get-show-menu">
    <xsl:choose>
      <xsl:when test=". is $current-topicref">
        <xsl:value-of select="'show'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="descendant::*">
          <xsl:if test=". is $current-topicref">
            <xsl:value-of select="'show'"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="nav-icon">
      <xsl:if
      test="./*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/othermeta ') and (@name='icon')]"
    >
        <i>
          <xsl:attribute name="class">
            <xsl:text>me-2 </xsl:text>
            <xsl:value-of
            select="./*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/othermeta ') and (@name='icon')]/@content"
          />
          </xsl:attribute>
          <xsl:attribute name="style">
             <xsl:value-of
            select="./*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/othermeta ') and (@name='icon-style')]/@content"
          />
          </xsl:attribute>
        </i>
      </xsl:if>
  </xsl:template>

  <!-- Add bootstrap classes and href to a link -->
  <xsl:template name="nav-attributes">
    <xsl:param name="class" as="xs:string"/>
    <xsl:param name="pathFromMaplist" as="xs:string"/>

    <xsl:attribute name="class">
      <xsl:value-of select="$class"/>
    </xsl:attribute>
    <xsl:attribute name="href">
      <xsl:if test="not(@scope = 'external')">
        <xsl:value-of select="$pathFromMaplist"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when
          test="@copy-to and not(contains(@chunk, 'to-content')) and
                            (not(@format) or @format = 'dita' or @format = 'ditamap') "
        >
          <xsl:call-template name="replace-extension">
            <xsl:with-param name="filename" select="@copy-to"/>
            <xsl:with-param name="extension" select="$OUTEXT"/>
          </xsl:call-template>
          <xsl:if test="not(contains(@copy-to, '#')) and contains(@href, '#')">
            <xsl:value-of select="concat('#', substring-after(@href, '#'))"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="not(@scope = 'external') and (not(@format) or @format = 'dita' or @format = 'ditamap')">
          <xsl:call-template name="replace-extension">
            <xsl:with-param name="filename" select="@href"/>
            <xsl:with-param name="extension" select="$OUTEXT"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Generate a menubar-toc - a menubar as part of the static header -->
  <xsl:template match="*" mode="gen-user-toptoc">
    <div class="container">
      <nav xsl:use-attribute-sets="menubar-toc">
        <ul class="nav nav-pills" role="menubar">
          <xsl:apply-templates select="$input.map" mode="menubar-toc">
            <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
          </xsl:apply-templates>
        </ul>
      </nav>
    </div>
  </xsl:template>

  <xsl:template name="offcanvas-sidebar">
    <div class="offcanvas-lg offcanvas-start " tabindex="-1" id="bdSidebar" aria-labelledby="bdSidebarOffcanvasLabel" aria-modal="true" role="dialog">
      <!-- <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="bdSidebarOffcanvasLabel">
          <xsl:choose>
            <xsl:when test="$input.map//*[contains(@class,' topic/title ')][1]">
              <xsl:for-each select="$input.map//*[contains(@class,' topic/title ')][1]">
                <xsl:if test="position() = 1">
                  <xsl:value-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="$input.map//*[contains(@class,' bookmap/mainbooktitle ')][1]">
              <xsl:for-each select="$input.map//*[contains(@class,' bookmap/mainbooktitle ')][1]">
                <xsl:if test="position() = 1">
                  <xsl:value-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
              <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"/>
            </xsl:otherwise>
          </xsl:choose>
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" data-bs-target="#bdSidebar"></button>
      </div> -->
      <div class="offcanvas-body mt-lg-0 offcanvasForMain">
        <xsl:call-template name="sidebar-content"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="sidebar-content">
    <xsl:choose>
      <xsl:when test="$nav-toc = ('list-group-partial', 'list-group-full')">
        <nav xsl:use-attribute-sets="toc">
          <!-- ↓ Remove <ul> and add <div> element from Bootstrap list-group ↓ -->
          <div class="list-group me-3">
          <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
            <xsl:choose>
              <xsl:when test="$nav-toc = 'list-group-partial'">
                <xsl:apply-templates select="$current-topicref" mode="list-group-toc-pull">
                  <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                  <xsl:with-param name="children" as="element()*">
                    <xsl:apply-templates
                      select="$current-topicref/*[contains(@class, ' map/topicref ')]"
                      mode="list-group-toc"
                    >
                      <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                    </xsl:apply-templates>
                  </xsl:with-param>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:when test="$nav-toc = 'list-group-full'">
                <xsl:apply-templates select="$input.map" mode="list-group-toc">
                  <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                </xsl:apply-templates>
              </xsl:when>
            </xsl:choose>
          <!-- ↓ Close <div> element from Bootstrap list-group ↑ -->
          </div>
          <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
        </nav>
      </xsl:when>


      <xsl:when test="$nav-toc = ('nav-pill-partial', 'nav-pill-full')">
        <nav xsl:use-attribute-sets="toc">
          <!-- ↓ Remove <ul> and add nested <nav> element with Bootstrap classes ↓ -->
          <nav class="nav nav-pills flex-column navbar-light bg-body-tertiary">
          <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
            <xsl:choose>
              <xsl:when test="$nav-toc = 'nav-pill-partial'">
                <xsl:apply-templates select="$current-topicref" mode="nav-pill-toc-pull">
                  <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                  <xsl:with-param name="children" as="element()*">
                    <xsl:apply-templates
                      select="$current-topicref/*[contains(@class, ' map/topicref ')]"
                      mode="nav-pill-toc"
                    >
                      <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                    </xsl:apply-templates>
                  </xsl:with-param>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:when test="$nav-toc = 'nav-pill-full'">
                <xsl:apply-templates select="$input.map" mode="nav-pill-toc">
                  <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                </xsl:apply-templates>
              </xsl:when>
            </xsl:choose>
          <!-- ↓ Close Bootstrap <nav> element -->
          </nav>
          <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
        </nav>
      </xsl:when>
      <xsl:when test="$nav-toc = ('collapsible')">
        <nav role="navigation" id="bs-sidebar-nav" class="flex-column bd-links">
          <xsl:if test="$BIDIRECTIONAL_DOCUMENT = 'yes'">
            <xsl:attribute name="direction" select="$defaultDirection"/>
          </xsl:if>
          <ul class="list-unstyled mb-0 py-3 pt-md-1" id=" ">
            <xsl:apply-templates select="$input.map" mode="collapsible-toc">
              <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
            </xsl:apply-templates>
          </ul>
        </nav>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:variable name="relpath">
    <xsl:choose>
      <xsl:when test="$FILEDIR='.'">
        <xsl:text>.</xsl:text>
      </xsl:when>
      <xsl:when test="contains($FILEDIR,'\')" >
         <xsl:value-of select=" replace($FILEDIR,'[^\\]+','..')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select=" replace($FILEDIR,'[^/]+','..')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Override to add Bootstrap list-group, nav-pill and collapse classes -->
  <xsl:template match="*" mode="gen-user-sidetoc">
    <xsl:choose>
      <xsl:when test="$nav-toc = 'none'">
        <xsl:call-template name="sidebar-content"/>
      </xsl:when>
      <xsl:otherwise>
        <div class="bs-sidebar ms-0">
          <div class="logo_sidebar d-none d-lg-block sticky-top">
            <!-- nav.xsl -->
            <!-- Header logo for the big screens  -->
            <a class="navbar-brand dynamicLogo" href="/">   
              <img src="{$relpath}/images/Web_logo_W130xH65.png" />
             </a>
          </div> 
          <xsl:call-template name="offcanvas-sidebar"/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- list-group sidebar toc processing to add Bootstrap list-group menu -->
  <!-- https://getbootstrap.com/docs/5.3/components/list-group/ -->

  <!-- partial list-group sidebar toc processing -->
  <xsl:template match="*[contains(@class, ' map/map ')]" mode="list-group-toc-pull">
    <xsl:param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:copy-of select="$children"/>
  </xsl:template>

  <!-- partial list-group sidebar toc processing -->
  <xsl:template match="*" mode="list-group-toc-pull" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:apply-templates select="$parent" mode="list-group-toc-pull">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
      <xsl:with-param name="children" select="$children"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- full list-group sidebar toc processing -->
  <xsl:template match="*" mode="list-group-toc" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="list-group-toc">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- nav-pill sidebar toc processing to add Bootstrap nav-pills menu -->
  <!-- https://getbootstrap.com/docs/5.3/components/navs-tabs/ -->

  <!-- partial nav-pill sidebar toc processing -->
  <xsl:template match="*[contains(@class, ' map/map ')]" mode="nav-pill-toc-pull">
    <xsl:param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:copy-of select="$children"/>
  </xsl:template>

  <!-- partial nav-pill sidebar toc processing -->
  <xsl:template match="*" mode="nav-pill-toc-pull" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:apply-templates select="$parent" mode="nav-pill-toc-pull">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
      <xsl:with-param name="children" select="$children"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- full nav-pill sidebar toc processing -->
  <xsl:template match="*" mode="nav-pill-toc" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="nav-pill-toc">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- collapsible sidebar toc processing to add Bootstrap collapsing menu classes -->
  <!-- https://getbootstrap.com/docs/5.3/components/collapse/ -->
  <xsl:template match="*" mode="collapsible-toc" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="collapsible-toc">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- nav-pill menubar-toc submenu toc processing - a navbar with dropdowns -->
  <!-- https://getbootstrap.com/docs/5.3/components/dropdowns/ -->
  <xsl:template match="*" mode="menubar-toc" priority="-10">
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="menubar-toc">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- list-group-toc-pull mode to add Bootstrap list-group-item classes to a sidebar -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="list-group-toc-pull"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>
    <xsl:apply-templates select="$parent" mode="list-group-toc-pull">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
      <xsl:with-param name="children" as="element()*">
        <xsl:apply-templates select="preceding-sibling::*[contains(@class, ' map/topicref ')]" mode="list-group-toc">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
        <xsl:choose>
          <xsl:when test="normalize-space($title)">
            <xsl:choose>
              <xsl:when test="normalize-space(@href)">
                <a>
                  <!-- ↓ Add Bootstrap list-group-item and action classes -->
                  <xsl:call-template name="nav-attributes">
                    <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                    <xsl:with-param name="class">
                      <xsl:text>list-group-item list-group-item-action</xsl:text>
                      <xsl:if test=". is $current-topicref">
                        <xsl:text> active</xsl:text>
                      </xsl:if>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </a>
              </xsl:when>
              <!--xsl:otherwise>
                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </xsl:otherwise-->
            </xsl:choose>
            <xsl:if test="exists($children)">
              <xsl:copy-of select="$children"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="list-group-toc">
              <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="following-sibling::*[contains(@class, ' map/topicref ')]" mode="list-group-toc">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <!-- list-group-toc mode to add Bootstrap list-group-item classes to a sidebar -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="list-group-toc"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param
      name="children"
      select="if ($nav-toc = 'list-group-full') then *[contains(@class, ' map/topicref ')] else ()"
      as="element()*"
    />
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>

    <xsl:variable name="active-class">
      <xsl:call-template name="get-active-class"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when
        test="$BOOTSTRAP_MENUBAR_TOC = 'yes' and count(ancestor::*/@href) eq 0 and not($active-class = ' active')"
      >
        <!-- no-op - if a menubar-toc is present, the list-group is reduced to current decendents only -->
      </xsl:when>
      <xsl:when test="normalize-space($title)">
        <xsl:choose>
          <xsl:when test="normalize-space(@href)">
            <a>
              <!-- ↓ Add Bootstrap list-group-item and action classes ↓ -->
              <xsl:call-template name="nav-attributes">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                <xsl:with-param name="class">
                  <xsl:text>list-group-item list-group-item-action</xsl:text>
                  <xsl:if test="parent::* is $current-topicref">
                    <xsl:text> bg-body-tertiary</xsl:text>
                  </xsl:if>
                  <xsl:if test=". is $current-topicref">
                    <xsl:text> active</xsl:text>
                  </xsl:if>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="nav-icon"/>
              <xsl:value-of select="$title"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <!-- ↓ Add Bootstrap list-group-item class and light background color ↓ -->
            <span class="list-group-item bg-body-tertiary">
              <xsl:call-template name="nav-icon"/>
              <xsl:value-of select="$title"/>
            </span>
            <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="exists($children)">
          <!--ul-->
          <xsl:apply-templates select="$children" mode="#current">
            <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
          </xsl:apply-templates>
          <!--/ul-->
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- nav-pill-toc-pull mode to add Bootstrap nav-link classes to a sidebar -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="nav-pill-toc-pull"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="()" as="element()*"/>
    <xsl:param name="parent" select="parent::*" as="element()?"/>
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>

    <xsl:variable name="active-class">
      <xsl:call-template name="get-active-class"/>
    </xsl:variable>

    <xsl:apply-templates select="$parent" mode="nav-pill-toc-pull">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
      <xsl:with-param name="children" as="element()*">
        <xsl:apply-templates select="preceding-sibling::*[contains(@class, ' map/topicref ')]" mode="nav-pill-toc">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
        <xsl:choose>
          <xsl:when test="normalize-space($title)">
            <xsl:choose>
              <xsl:when test="normalize-space(@href)">
                <a>
                  <!-- ↓ Add Bootstrap nav-link and action classes -->
                  <xsl:call-template name="nav-attributes">
                    <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                    <xsl:with-param name="class">
                      <xsl:text>my-1 nav-link</xsl:text>
                      <xsl:value-of select="$active-class"/>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </a>
              </xsl:when>
              <!--xsl:otherwise>
                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </xsl:otherwise-->
            </xsl:choose>
            <xsl:if test="exists($children)">
              <nav class="nav nav-pills flex-column ps-3">
                <xsl:copy-of select="$children"/>
              </nav>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="nav-pill-toc">
              <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="following-sibling::*[contains(@class, ' map/topicref ')]" mode="nav-pill-toc">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <!-- nav-pill-toc mode to add Bootstrap nav-link classes to a sidebar -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="nav-pill-toc"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param
      name="children"
      select="if ($nav-toc = 'nav-pill-full') then *[contains(@class, ' map/topicref ')] else ()"
      as="element()*"
    />
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>

    <xsl:variable name="active-class">
      <xsl:call-template name="get-active-class"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when
        test="$BOOTSTRAP_MENUBAR_TOC = 'yes' and count(ancestor::*/@href) eq 0 and not($active-class = ' active')"
      >
        <!-- no-op - if a menubar-toc is present, the nav-bar is reduced to current decendents only -->
      </xsl:when>
      <xsl:when test="normalize-space($title)">
        <xsl:choose>
          <xsl:when test="normalize-space(@href)">
            <a>
              <!-- ↓ Add Bootstrap nav-link and action classes ↓ -->
              <xsl:call-template name="nav-attributes">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                <xsl:with-param name="class">
                  <xsl:text>my-1 nav-link</xsl:text>
                  <xsl:value-of select="$active-class"/>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="nav-icon"/>
              <xsl:value-of select="$title"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <!-- ↓ Add Bootstrap nav-brand class ↓ -->
            <span class="my-1 ps-3 navbar-brand">
              <xsl:call-template name="nav-icon"/>
              <xsl:value-of select="$title"/>
            </span>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="exists($children)">
          <nav class="nav nav-pills flex-column ps-3">
            <xsl:apply-templates select="$children" mode="#current">
              <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
            </xsl:apply-templates>
          </nav>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- collapsible-toc mode to add Bootstrap collapsing menu classes to a sidebar -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="collapsible-toc"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="*[contains(@class, ' map/topicref ')]" as="element()*"/>
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>

    <xsl:variable name="active-class">
      <xsl:call-template name="get-active-class"/>
    </xsl:variable>
    <xsl:variable name="show-menu">
      <xsl:call-template name="get-show-menu"/>
    </xsl:variable>
    <li class="list_style_border">
      <xsl:choose>
        <xsl:when test="$BOOTSTRAP_MENUBAR_TOC = 'yes' and count(ancestor::*/@href) eq 0 and not($show-menu = 'show')">
          <!-- no-op - if a menubar-toc is present, the nav-bar is reduced to current decendents only -->
        </xsl:when>
        <xsl:when test="not(.)">
        </xsl:when>
        <xsl:when test="normalize-space($title)">
          <xsl:variable name="id" select="generate-id(.)"/>
          <xsl:choose>
            <xsl:when test="normalize-space(@href)">
              <div>
            
                <!-- <xsl:if test="exists($children)"> -->
                
                <xsl:attribute name="class" select="'d-flex flex-row justify-content-between'"/>
                    
                <xsl:attribute name="id" select="concat('menu-collapse-trigger-',$id)"/>
                  <!-- ↓ Add Toggle without text ↓ -->
                  
                <!-- </xsl:if> -->
                <!-- ↓ Add Bootstrap classes to topic link ↓ -->
                <a>
                  <xsl:call-template name="nav-attributes">
                    <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                    <xsl:with-param name="class">
                      <xsl:text>d-inline-flex align-items-center flex-shrink-1 </xsl:text>
                      <xsl:choose>
                        <xsl:when test="exists($children)">
                          <xsl:text>ps-0</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>ps-0</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:value-of select="$active-class"/>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </a>
                <button data-bs-toggle="collapse">
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="exists($children)">
                        <xsl:text>btn d-inline-flex align-items-center pe-0</xsl:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>btn d-inline-flex align-items-center pe-0 invisible</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                   
                    <xsl:if test="$show-menu='show'">
                      <xsl:text> active</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:attribute name="data-bs-target" select="concat('#menu-collapse-',$id)"/>
                  <xsl:if test="$show-menu='show'">
                    <xsl:attribute name="aria-expanded" select="'true'"/>
                    <xsl:attribute name="aria-current" select="'true'"/>
                  </xsl:if>
                  <xsl:attribute name="aria-labelledby" select="concat('menu-collapse-trigger-',$id)"/>
                  <xsl:attribute name="aria-controls" select="concat('menu-collapse-',$id)"/>
                  <svg xmlns="http://www.w3.org/2000/svg" class="menu__icon2" width="25" height="25" viewBox="0 0 24 24"><path fill="currentColor" d="M11.7 15.3q-.475.475-1.087.213T10 14.575v-5.15q0-.675.613-.938T11.7 8.7l2.6 2.6q.15.15.225.325T14.6 12q0 .2-.075.375t-.225.325l-2.6 2.6Z"/></svg>
                </button>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <!-- ↓ Add Toggle with title text ↓ -->
              <div class="d-flex flex-row justify-content-between">
                <div class="d-flex align-items-center iconAndTitle">
                <span data-bs-toggle="collapse">
                  <xsl:attribute name="class">
                    <xsl:text>d-inline-flex align-items-center flex-shrink-1 ps-0 menuWithOutContent</xsl:text>
                    <xsl:if test="$show-menu='show'">
                      <xsl:text> active</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:attribute name="data-bs-target" select="concat('#menu-collapse-',$id)"/>
                  <xsl:if test="$show-menu='show'">
                    <xsl:attribute name="aria-expanded" select="'true'"/>
                    <xsl:attribute name="aria-current" select="'true'"/>
                  </xsl:if>

                  <xsl:call-template name="nav-icon"/>
                  <xsl:value-of select="$title"/>
                </span>
              </div>
                <button data-bs-toggle="collapse">
                  <xsl:attribute name="class">
                    <xsl:text>btn d-inline-flex align-items-center pe-0</xsl:text>
                    <xsl:if test="$show-menu='show'">
                      <!-- <xsl:text> active</xsl:text> -->
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:attribute name="data-bs-target" select="concat('#menu-collapse-',$id)"/>
                  <xsl:if test="$show-menu='show'">
                    <xsl:attribute name="aria-expanded" select="'true'"/>
                    <xsl:attribute name="aria-current" select="'true'"/>
                  </xsl:if>
                  <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" class="menu__icon2" viewBox="0 0 24 24"><path fill="currentColor" d="M11.7 15.3q-.475.475-1.087.213T10 14.575v-5.15q0-.675.613-.938T11.7 8.7l2.6 2.6q.15.15.225.325T14.6 12q0 .2-.075.375t-.225.325l-2.6 2.6Z"/></svg>
                </button>
                
              </div>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="exists($children)">
            <div>
              <xsl:attribute name="id" select="concat('menu-collapse-',$id)"/>
              <xsl:attribute name="class" select="concat('collapse ', $show-menu)"/>
              <ul class="list-unstyled fw-normal ps-5-custom">
                <xsl:apply-templates select="$children" mode="#current">
                  <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                </xsl:apply-templates>
              </ul>
            </div>
          </xsl:if>
        </xsl:when>
      </xsl:choose>
    </li>
  </xsl:template>

  <!-- menubar-toc mode to add Bootstrap nav-link classes to a menubar-toc - a submenu as part of the header -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
                        [not(@toc = 'no')]
                        [not(@processing-role = 'resource-only')]"
    mode="menubar-toc"
    priority="10"
  >
    <xsl:param name="pathFromMaplist" as="xs:string"/>
    <xsl:param name="children" select="*[contains(@class, ' map/topicref ')]"/>
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="normalize-space($title)">
        <xsl:choose>
          <xsl:when test="normalize-space(@href)">
            <li class="nav-item" role="none">
              <a role="menuitem">
                <!-- ↓ Add Bootstrap nav-link classes -->
                <xsl:call-template name="nav-attributes">
                  <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                  <xsl:with-param name="class" select="'nav-link'"/>
                </xsl:call-template>
                <xsl:call-template name="nav-icon"/>
                <xsl:value-of select="$title"/>
              </a>
            </li>
          </xsl:when>
          <xsl:otherwise>
            <!-- ↓ Add Bootstrap nav-item class and dropdown ↓ -->
            <li class="nav-item dropdown" role="none">
              <a
                class="nav-link dropdown-toggle"
                data-bs-toggle="dropdown"
                href="#"
                role="menuitem"
                aria-expanded="false"
                aria-haspopup="true"
              >
                <xsl:call-template name="nav-icon"/>
                <xsl:value-of select="$title"/>
              </a>
              <ul class="dropdown-menu" role="menu">
                <!-- menubar-toc dropdown menu items must be active links -->
                <xsl:for-each select="$children">
                  <xsl:variable name="title">
                    <xsl:apply-templates select="." mode="get-navtitle"/>
                  </xsl:variable>
                  <li role="none">
                    <a role="menuitem">
                      <xsl:call-template name="nav-attributes">
                        <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
                        <xsl:with-param name="class" select="'dropdown-item'"/>
                      </xsl:call-template>
                      <xsl:call-template name="nav-icon"/>
                      <xsl:value-of select="$title"/>
                    </a>
                  </li>
                </xsl:for-each>
              </ul>
            </li>
            <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
