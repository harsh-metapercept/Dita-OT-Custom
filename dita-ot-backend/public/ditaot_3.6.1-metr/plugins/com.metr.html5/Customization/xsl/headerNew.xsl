<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  version="2.0"
  exclude-result-prefixes="xs dita-ot"
>

  <!-- Define your component template -->
  <xsl:template name="my-header">
    
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


    <nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top px-3" id="mainHeader">
      <div class="container-fluid header__main ">
        <div class="bd-navbar-toggle hide-print ignore-this">
          <button
            class="navbar-toggler p-2"
            type="button"
            data-bs-toggle="offcanvas"
            data-bs-target="#bdSidebar"
            aria-controls="bdSidebar"
            aria-label="Toggle docs navigation"
          >
            <i class="bi bi-list"/>
          </button>
        </div>
        
        <!-- Logo Code -->
        <a class="navbar-brand text-center dynamicLogo d-block d-lg-none" href="/">
            <!-- headerNew.xsl -->
            <!-- Logo and ditamap title for the small devices  -->
            <img src="{$relpath}/images/Web_logo_W130xH65.png" />
            <div class="mainDitaMapTitle mobileDitaTitle ignore-this no-print"></div>
        </a>

        <button class="navbar-toggler border-0 hide-print no-print ignore-this menuButtonRight" type="button" data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
          aria-expanded="false" aria-label="Toggle navigation">
          <i class="bi bi-three-dots"/>
        </button>
        <div class="collapse navbar-collapse hide-print ignore-this no-print" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <span class="mainDitaMapTitle d-none d-lg-block ignore-this no-print"></span>
            </li>
          </ul>
          <div class="ditasearch w-100" data-searchroot=""></div>


          <div class="d-flex searchBoxWrapper no-print" role="search">
            <input id="headerSearchBox" class="form-control me-2" type="search" placeholder="Search" aria-label="Search" data-bs-toggle="modal" autocomplete="off" data-bs-target="#searchBoxModal" />
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 1024 1024"><path fill="#000" d="M1014.64 969.04L703.71 656.207c57.952-69.408 92.88-158.704 92.88-256.208c0-220.912-179.088-400-400-400s-400 179.088-400 400s179.088 400 400 400c100.368 0 192.048-37.056 262.288-98.144l310.496 312.448c12.496 12.497 32.769 12.497 45.265 0c12.48-12.496 12.48-32.752 0-45.263zM396.59 736.527c-185.856 0-336.528-150.672-336.528-336.528S210.734 63.471 396.59 63.471c185.856 0 336.528 150.672 336.528 336.528S582.446 736.527 396.59 736.527z"/></svg>
          </div>
          
          <!-- <ul class="navbar-nav ms-auto">
            <li class="nav-item d-flex align-items-center">
              <span class="nav-link py-2 pe-2"><i class="bi bi-search"/></span>
              <form class="bd-search position-relative me-auto" onsubmit="return search(this);">
                <input id="search-input" type="search" dir="auto" class="form-control ds-input"
                  placeholder="Search…" aria-label="Search for…"
                  style="position: relative; vertical-align: top;" />
              </form>
            </li>
          </ul> -->
        </div>
      </div>
    </nav>
  </xsl:template>

</xsl:stylesheet>