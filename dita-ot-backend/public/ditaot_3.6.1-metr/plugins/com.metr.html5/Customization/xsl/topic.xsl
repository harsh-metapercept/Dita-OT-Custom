<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA Bootstrap plug-in for DITA Open Toolkit.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="2.0"
  exclude-result-prefixes="xs dita-ot dita2html"
>

  <xsl:param name="defaultLanguage" select="'en'" as="xs:string"/>
  <xsl:param name="BIDIRECTIONAL_DOCUMENT" select="'no'" as="xs:string"/>

  <xsl:variable name="defaultDirection">
    <xsl:apply-templates select="." mode="get-render-direction">
      <xsl:with-param name="lang" select="$defaultLanguage"/>
    </xsl:apply-templates>
  </xsl:variable>

  <!-- Define a newline character -->
  <xsl:variable name="newline">
<xsl:text>
</xsl:text>
  </xsl:variable>

  <xsl:template name="bidi-auto-code">
    <!-- ↓ Ensure code is rendered LTR in RTL documents ↓ -->
    <xsl:if test="$BIDIRECTIONAL_DOCUMENT='yes' and not(@dir)">
      <xsl:choose>
        <xsl:when test="contains(@class,' pr-d/')">
          <xsl:attribute name="dir">auto</xsl:attribute>
        </xsl:when>
        <xsl:when test="contains(@class,' sw-d/')">
          <xsl:attribute name="dir">auto</xsl:attribute>
        </xsl:when>
        <xsl:when test="contains(@class,' xml-d/')">
          <xsl:attribute name="dir">auto</xsl:attribute>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- Customized templates from `org.dita.html5/xsl/topic.xsl` -->

  <xsl:template name="chapter-setup">
  <html>
    <!-- ↓ Add check for bi-directional content ↓ -->
    <xsl:if test="$BIDIRECTIONAL_DOCUMENT = 'no'">
      <xsl:call-template name="setTopicLanguage"/>
    </xsl:if>
    <xsl:if test="$BIDIRECTIONAL_DOCUMENT = 'yes'">
      <xsl:attribute name="dir" select="$defaultDirection"/>
      <xsl:attribute name="lang" select="$defaultLanguage"/>
    </xsl:if>
    <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
    <xsl:call-template name="chapterHead"/>
    <xsl:call-template name="chapterBody"/>
  </html>
  </xsl:template>

  <xsl:template match="*" mode="addContentToHtmlBodyElement">
    <div style="background-color:white" >
      <xsl:call-template name="my-header"/>
    
    <main xsl:use-attribute-sets="main" id="mainArea">
      <article role="article" class="bs-content px-4" style="padding-top:15px">
        <!-- ↓ Add check for bi-directional content ↓ -->
        <xsl:if test="$BIDIRECTIONAL_DOCUMENT = 'yes'">
          <xsl:variable name="direction">
            <xsl:apply-templates select="." mode="get-render-direction">
              <xsl:with-param name="lang" select="dita-ot:get-current-language(.)"/>
            </xsl:apply-templates>
          </xsl:variable>
          <xsl:attribute name="dir" select="$direction"/>
          <xsl:attribute name="lang" select="dita-ot:get-current-language(.)"/>
        </xsl:if>
        <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
        <xsl:attribute name="aria-labelledby">
          <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
                                       self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="return-aria-label-id"/>
        </xsl:attribute>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <!-- ↓ Add Bootstrap breadcrumb ↓ -->
        <xsl:if test="$BREADCRUMBS = 'yes'">
          <xsl:apply-templates select="$current-topicref" mode="gen-user-breadcrumb"/>
        </xsl:if>
        <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
        <xsl:apply-templates/> <!-- this will include all things within topic; therefore, -->
                               <!-- title content will appear here by fall-through -->
                               <!-- followed by prolog (but no fall-through is permitted for it) -->
                               <!-- followed by body content, again by fall-through in document order -->
                               <!-- followed by related links -->
                               <!-- followed by child topics by fall-through -->
        <xsl:call-template name="gen-endnotes"/>    <!-- include footnote-endnotes -->

        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
     
        <!-- ↓ Next and Prevous Button - Data is dynamic  ↓ -->
        <div class="nextPrevious my-5 ignore-this hide-print" id="nextPreviusButtons">
          <div class="row">
            <div class="col-6" id="previousBtn"></div>
            <div class="col-6 d-flex justify-content-end" id="nextBtn"></div>
          </div>
        </div>
        <!-- ↓ Feedback Comment Box  ↓ -->
        <div class="container-fluid my-5 ignore-this hide-print d-none" id="feedbackCommentBox">
          <div class="feedback_comment"><span class="borderLine"></span><span class="commentTitle">Did you find this page helpful?</span><span class="borderLine"></span></div>
          <div class="likeBox">
             <button class="reviewBtn" id="likeBtn" name="Liked">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" width="22" height="22" stroke="#5feb9e" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-up block w-full h-full">
                   <path d="M14 9V5a3 3 0 0 0-3-3l-4 9v11h11.28a2 2 0 0 0 2-1.7l1.38-9a2 2 0 0 0-2-2.3zM7 22H4a2 2 0 0 1-2-2v-7a2 2 0 0 1 2-2h3"></path>
                </svg>
             </button>
             <button class="reviewBtn" id="dislikeBtn" name="Disliked">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" width="22" height="22" stroke="#f4495d" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-thumbs-down block w-full h-full">
                   <path d="M10 15v4a3 3 0 0 0 3 3l4-9V2H5.72a2 2 0 0 0-2 1.7l-1.38 9a2 2 0 0 0 2 2.3zm7-13h2.67A2.31 2.31 0 0 1 22 4v7a2.31 2.31 0 0 1-2.33 2H17"></path>
                </svg>
             </button>
          </div>

          <div class="commentForm form-content ignore-this">
            <form class="requires-validation" id="comment__form" novalidate="">
              <input type="hidden" name="REVIEW" />
              <input type="hidden" name="POST_URL" />
              <div class="col-md-12">
                  <input class="form-control" type="email" id="EMAIL" name="email" placeholder="Email Address" required="" />
                   <div class="valid-feedback">Email field is valid!</div>
                   <div class="invalid-feedback">Email field cannot be blank!</div>
              </div>   
              <div class="col-md-12">
                 <textarea rows="5"  class="form-control" id="DESCRIPTION" name="DESCRIPTION" placeholder="Enter your feedback here!" required="" />
                 <div class="valid-feedback">Comment field is valid!</div>
                 <div class="invalid-feedback">Comment field cannot be blank!</div>
              </div>

              <div class="form-button mt-3 d-flex justify-content-center">
                  <button id="submit" type="submit" class="btn btn-primary">Submit</button>
              </div>
          </form>
          </div>

          <div class="thankYou">
            <div class="fs-4 fw-bold">Thanks for submitting!</div>
            <div>Your message has been sent!</div>
          </div>   
        </div>

        <button id="scrollButtonDown">
          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 20 20" fill="var(--primary-600)" ><path d="M7 10V2h6v8h5l-8 8-8-8h5z"/></svg>
        </button>

        <button id="scrollButtonUp">
          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="var(--primary-600)" viewBox="0 0 20 20"><path d="M7 10v8h6v-8h5l-8-8-8 8h5z"/></svg>
        </button>

        <!-- Modal -->
        <div class="modal fade" id="searchBoxModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog modal-dialog-scrollable modal-fullscreen-lg-down">
            <div class="modal-content">
              <div class="modal-header">
                <div class="serachAndIcon styleSearch d-flex justify-content-between align-items-start">
                  <div class="d-flex align-items-start w-100">
                    <!-- <input class="form-control me-2" type="search" placeholder="Search docs" aria-label="Search" id="search-input" autocomplete="off" /> -->
                    <div class="ditasearch w-100" data-searchroot=""></div>
                  </div>
                  <button class="searchButton mt-2" type="button" data-bs-dismiss="modal" aria-label="Close">Cancel</button>
                </div>   
                <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
              </div>
              <div class="modal-body" id="search-results">
                <div class="loader" id="loader"></div>
              </div>
              <div id="nosearch" style="display: none; padding: 2rem 0; text-align:center;"></div>
            </div>
          </div>
        </div>

      </article>
      <xsl:if test="$BOOTSTRAP_SCROLLSPY_TOC != 'none'">
        <xsl:if test="count(*[contains(@class, ' topic/topic ')])&gt;0">
          <div class="bs-scrollspy mt-3 mb-5 my-lg-0 mb-lg-5 px-sm-1 text-body-secondary">
            <xsl:call-template name="scrollspy-content"/>
          </div>
        </xsl:if>
      </xsl:if>
    </main>
  </div>
  </xsl:template>

  <!-- Override to add Bootstrap classes and roles -->
  <xsl:template match="@* | node()" mode="commonattributes">
    <xsl:param name="default-output-class" as="xs:string*"/>
    <xsl:apply-templates select="@xml:lang"/>
    <xsl:apply-templates select="@dir"/>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@style" mode="add-ditaval-style"/>
     <!-- ↓ Add Bootstrap role template ↓ -->
    <xsl:call-template name="bootstrap-role"/>
     <!-- ↓ Set Bidi to auto for code ↓ -->
    <xsl:call-template name="bidi-auto-code"/>
    <!-- ↓ Add Bootstrap class attributes template ↓ -->
    <xsl:variable name="bootstrap-class">
      <xsl:call-template name="bootstrap-class"/>
      <xsl:value-of select="$default-output-class"/>
    </xsl:variable>
    <!-- ↓ Remove DITA-OT styling from titles since Bootstrap does this ↓ -->
    <xsl:choose>
      <xsl:when test="starts-with($default-output-class[1] , 'topictitle')">
        <xsl:apply-templates select="." mode="set-output-class">
          <xsl:with-param name="default" select="replace($bootstrap-class, 'topictitle\d+', '')"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="starts-with($default-output-class[1] , 'sectiontitle')">
        <xsl:apply-templates select="." mode="set-output-class">
          <xsl:with-param name="default" select="replace($bootstrap-class, 'sectiontitle', '')"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="set-output-class">
          <xsl:with-param name="default" select="$bootstrap-class"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
    <xsl:choose>
      <xsl:when test="exists($passthrough-attrs[empty(@att) and empty(@value)])">
        <xsl:variable name="specializations" as="xs:string*">
          <xsl:for-each select="ancestor-or-self::*[@domains][1]/@domains">
            <xsl:analyze-string select="normalize-space(.)" regex="a\(props (.+?)\)">
              <xsl:matching-substring>
                <xsl:sequence select="tokenize(regex-group(1), '\s+')"/>
              </xsl:matching-substring>
            </xsl:analyze-string>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="@props |
                              @audience |
                              @platform |
                              @product |
                              @otherprops |
                              @deliveryTarget |
                              @*[local-name() = $specializations]">
          <xsl:attribute name="data-{name()}" select="."/>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="exists($passthrough-attrs)">
        <xsl:for-each select="@*">
          <xsl:if test="$passthrough-attrs[@att = name(current()) and (empty(@val) or (some $v in tokenize(current(), '\s+') satisfies $v = @val))]">
            <xsl:attribute name="data-{name()}" select="."/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Override to add Bootstrap Alert classes and roles to Note elements -->
  <!-- https://getbootstrap.com/docs/5.3/components/alerts/ -->
  <xsl:template match="*" mode="process.note.common-processing">
    <xsl:param name="type" select="@type"/>
    <xsl:param name="title">
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="concat(upper-case(substring($type, 1, 1)), substring($type, 2))"/>
      </xsl:call-template>
    </xsl:param>
    <!-- ↓ Add Bootstrap class attributes template ↓ -->
    <xsl:variable name="bootstrap-class">
      <xsl:if test="not(contains(@outputclass, 'alert-'))">
        <xsl:call-template name="bootstrap-note"/>
      </xsl:if>
    </xsl:variable>
    <div role="alert">
      <xsl:call-template name="commonattributes">
        <xsl:with-param name="default-output-class" select="$bootstrap-class"/>
        <!--xsl:with-param name="default-output-class" select="string-join(($type, concat('note_', $type)), ' ')"/-->
      </xsl:call-template>
      <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
      <xsl:call-template name="setidaname"/>
      <!-- Normal flags go before the generated title; revision flags only go on the content. -->
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/prop" mode="ditaval-outputflag"/>
      <span class="note__title">
        <!-- ↓ Add Bootstrap icon ↓ -->
        <xsl:if test="$BOOTSTRAP_ICONS_INCLUDE = 'yes'">
          <xsl:call-template name="bootstrap-icon"/>
        </xsl:if>
        <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
        <xsl:copy-of select="$title"/>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'ColonSymbol'"/>
        </xsl:call-template>
      </span>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/revprop" mode="ditaval-outputflag"/>
      <xsl:apply-templates/>
      <!-- Normal end flags and revision end flags both go out after the content. -->
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </div>
  </xsl:template>

  <!-- Customization to add Bootstrap Figure Content -->
  <!-- https://getbootstrap.com/docs/5.3/content/figures/ -->
  <xsl:template
    match="*[contains(@class, ' topic/fig ') and not(contains(@class,' pr-d/syntaxdiagram '))]"
    name="topic.fig"
  >
    <xsl:variable name="default-fig-class">
      <xsl:apply-templates select="." mode="dita2html:get-default-fig-class"/>
    </xsl:variable>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
    <figure>
      <xsl:if test="$default-fig-class != ''">
        <xsl:attribute name="class" select="$default-fig-class"/>
      </xsl:if>
      <xsl:call-template name="commonattributes">
        <xsl:with-param name="default-output-class" select="$default-fig-class"/>
      </xsl:call-template>
      <xsl:call-template name="setscale"/>
      <xsl:call-template name="setidaname"/>
      <!--xsl:call-template name="place-fig-lbl"/-->
      <xsl:apply-templates
        select="node() except *[contains(@class, ' topic/title ') or contains(@class, ' topic/desc ')]"
      />
      <!-- ↓ Move Figure title below image ↓ -->
      <xsl:call-template name="place-fig-lbl"/>
      <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
    </figure>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    <xsl:value-of select="$newline"/>
  </xsl:template>

  <!-- Figure caption -->
  <xsl:template name="place-fig-lbl">
    <xsl:param name="stringName"/>
    <!-- Number of fig/title's including this one -->
    <xsl:variable name="fig-count-actual" select="count(preceding::*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')])+1"/>
    <xsl:variable name="ancestorlang">
      <xsl:call-template name="getLowerCaseLang"/>
    </xsl:variable>
    <xsl:choose>
      <!-- title -or- title & desc -->
      <xsl:when test="*[contains(@class, ' topic/title ')]">
        <figcaption>
          <!-- ↓ Add Bootstrap figure caption class ↓ -->
          <xsl:variable name="fig-caption-class">
            <xsl:choose>
              <xsl:when test="*[contains(@class, ' topic/lq ')]">
                <xsl:value-of select="concat('blockquote-footer ', $BOOTSTRAP_CSS_FIGURE_CAPTION)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('figure-caption ', $BOOTSTRAP_CSS_FIGURE_CAPTION)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:apply-templates select="." mode="set-output-class">
            <xsl:with-param
              name="default"
              select="concat($fig-caption-class, ./*[contains(@class, ' topic/title ')][1]/@outputclass)"
            />
          </xsl:apply-templates>
          <!-- ↑ End customization · Continue with DITA-OT defaults ↓ -->
          <span class="fig--title-label">
            <xsl:choose>
              <!-- Blockquote - figure -->
              <xsl:when test="*[contains(@class, ' topic/lq ')]">
              </xsl:when>
              <!-- Hungarian: "1. Figure " -->
              <xsl:when test="$ancestorlang = ('hu', 'hu-hu')">
                <xsl:value-of select="$fig-count-actual"/>
                <xsl:text>. </xsl:text>
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id" select="'Figure'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id" select="'Figure'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$fig-count-actual"/>
                <xsl:text>. </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </span>
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="figtitle"/>
          <xsl:if test="*[contains(@class, ' topic/desc ')]">
            <xsl:text>. </xsl:text>
          </xsl:if>
          <xsl:for-each select="*[contains(@class, ' topic/desc ')]">
            <span class="figdesc">
              <xsl:call-template name="commonattributes"/>
              <xsl:apply-templates select="." mode="figdesc"/>
            </span>
          </xsl:for-each>
        </figcaption>
      </xsl:when>
      <!-- desc -->
      <xsl:when test="*[contains(@class, ' topic/desc ')]">
        <xsl:for-each select="*[contains(@class, ' topic/desc ')]">
          <figcaption>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="figdesc"/>
          </figcaption>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Customization to add Bootstrap Borders to Codeblock elements-->
  <!-- https://getbootstrap.com/docs/5.3/utilities/borders/ -->
  <xsl:template match="*[contains(@class, ' topic/pre ') and @frame]">
    <xsl:variable name="default-fig-class">
      <xsl:apply-templates select="." mode="dita2html:get-default-fig-class"/>
    </xsl:variable>
    <figure>
      <xsl:if test="$default-fig-class != ''">
        <xsl:attribute name="class">
          <xsl:value-of select="$default-fig-class"/>
          <xsl:text> figure </xsl:text>
          <xsl:value-of select="$BOOTSTRAP_CSS_FIGURE"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
      <xsl:call-template name="spec-title-nospace"/>
      <pre>
        <xsl:attribute name="class" select="name()"/>
        <xsl:call-template name="commonattributes"/>
        <xsl:call-template name="setscale"/>
        <xsl:call-template name="setidaname"/>
        <xsl:apply-templates/>
      </pre>
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </figure>
  </xsl:template>

  <!-- Customization to add Bootstrap Borders to Lines elements-->
  <!-- https://getbootstrap.com/docs/5.3/utilities/borders/ -->
  <xsl:template match="*[contains(@class, ' topic/lines ') and @frame]">
    <xsl:variable name="default-fig-class">
      <xsl:apply-templates select="." mode="dita2html:get-default-fig-class"/>
    </xsl:variable>
    <figure>
      <xsl:if test="$default-fig-class != ''">
        <xsl:attribute name="class">
          <xsl:value-of select="$default-fig-class"/>
          <xsl:text> figure </xsl:text>
          <xsl:value-of select="$BOOTSTRAP_CSS_FIGURE"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="spec-title-nospace"/>
      <p>
        <xsl:call-template name="commonattributes"/>
        <xsl:call-template name="setscale"/>
        <xsl:call-template name="setidaname"/>
        <xsl:apply-templates/>
      </p>
    </figure>
  </xsl:template>

  <!-- Determine the default Bootstrap class attribute for a figure -->
  <xsl:template match="*" mode="dita2html:get-default-fig-class">
    <xsl:choose>
      <xsl:when test="@frame = 'all'">border</xsl:when>
      <xsl:when test="@frame = 'sides'">border-start border-end</xsl:when>
      <xsl:when test="@frame = 'top'">border-top</xsl:when>
      <xsl:when test="@frame = 'bottom'">border-bottom</xsl:when>
      <xsl:when test="@frame = 'topbot'">border-top border-bottom</xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' topic/ph ') and contains(@otherprops, 'title(')  and (contains(@outputclass, 'initialism') or contains(@outputclass, 'abbreviation'))]"
  >
    <abbr>
      <xsl:attribute name="title">
        <xsl:analyze-string select="@otherprops" regex="[a-z]*\([^\)]*\)">
          <xsl:matching-substring>
            <xsl:variable name="var">
              <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:variable name="attr">
              <xsl:value-of select="substring-before($var, '(')"/>
            </xsl:variable>
            <xsl:attribute name="{$attr}">
              <xsl:value-of select="substring-before(substring-after($var, '('),')')"/>
            </xsl:attribute>
          </xsl:matching-substring>
        </xsl:analyze-string>
      </xsl:attribute>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setidaname"/>
      <xsl:apply-templates/>
    </abbr>
  </xsl:template>
</xsl:stylesheet>
