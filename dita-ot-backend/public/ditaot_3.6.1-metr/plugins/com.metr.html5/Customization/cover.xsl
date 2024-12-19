<?xml version="1.0" encoding="UTF-8"?>
<!--
This file is part of the DITA Open Toolkit project.

Copyright 2014 Jarno Elovirta

See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  version="2.0"
  exclude-result-prefixes="xs dita-ot ditamsg">


  <xsl:template match="*[contains(@class, ' map/map ')]" mode="toc">
    <xsl:param name="pathFromMaplist" />
    <xsl:if
      test="descendant::*[contains(@class, ' map/topicref ')]
      [not(@toc = 'no')]
      [not(@processing-role = 'resource-only')]">

      <div class="imgback d-none"></div>
      <div
        class="bs-container container-fluid bd-gutter halpBgColor hideSidebarInLandingPage">

        <div class="bs-sidebar bs-sidebarTOC d-none d-lg-block">
          <div class="logo_sidebar d-none d-lg-block sticky-top">

            <!-- cover.xsl -->
            <!-- Landing page logo for big screen  -->
            <a class="navbar-brand dynamicLogo" href="/">
              <img src="images/Web_logo_W130xH65.png" />
            </a>
          </div>
          <nav id="myUL" class="myUL">
            <ul>
              <xsl:call-template name="commonattributes" />
              <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist" />
              </xsl:apply-templates>
            </ul>
          </nav>
        </div>


        <div class="h-100">
          <nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top" id="mainHeaderTOC">
            <div class="container-fluid cover__header px-3">
              <div class="bd-navbar-toggle hide-print ignore-this">
                <button
                  class="navbar-toggler p-2"
                  type="button"
                  aria-label="Toggle docs navigation"
                  data-bs-toggle="offcanvas"
                  data-bs-target="#offcanvasExample"
                  aria-controls="offcanvasExample"
                >
                  <i class="bi bi-list" />
                </button>
              </div>

              <!-- cover.xsl -->
              <!-- Landing page Logo and title for the small devices -->
              <a class="navbar-brand text-center dynamicLogo d-block d-lg-none" href="/">
                <!-- LOGO -->
                <img src="images/Web_logo_W130xH65.png" />
                <!-- title -->
                <div class="mainDitaMapTitle mobileDitaTitle  ignore-this no-print"></div>
              </a>

              <button
                class="navbar-toggler border-0 hide-print no-print ignore-this menuButtonRight"
                type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <i class="bi bi-three-dots" />
              </button>
              <div class="collapse navbar-collapse hide-print ignore-this no-print"
                id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <span class="mainDitaMapTitle d-none d-lg-block  ignore-this no-print"></span>
                  </li>

                </ul>

                <div class="d-flex searchBoxWrapper no-print" role="search">
                  <input autocomplete="off" id="headerSearchBox" class="form-control me-2"
                    type="search" placeholder="Search" aria-label="Search" data-bs-toggle="modal"
                    data-bs-target="#searchBoxModal" />

                </div>
              </div>
            </div>
          </nav>
          <div class="bs-main bs-mainWithoutFR" id="tocContent"
            style="min-height:calc(100vh - 112px);">
            <article role="article">
              <div class="coverImage"></div>
              <div class="landingPageCards d-none">
                <div class="bigCard d-flex flex-column-reverse flex-lg-row">
                  <div class="leftCard h-100 me-0 me-md-4">
                    <div class="content_wrapper">
                      <!-- <h1 id="tocPageHeading"></h1> -->
                      <h2>Introduction</h2>
                      <p class="para1 mb-4"> This documentation only pertains to upgrading to metR
    from ProcessComposer 12.13 and all earlier versions. <br />
                        <br /> When upgrading to the latest
    version of the metR, you must change the metR App's logo to reflect current branding. Current
    Salesforce functionality does not allow the installed package to automatically update the logo.
    Follow the steps below to change the metR application's logo in Lightning and in Classic after
    upgrading. </p>
                      <!-- <a href="/" class="readmoreBtn">Read More</a>  -->
                    </div>
                    <div class="small__card">

                    </div>


                    <!-- <div class="menu__wrapper hidecard">
                    <div class="card mb-5 landingPageCard">
                      <div class="card-body d-flex align-items-start">
                        <svg style="margin-right:10px;" width="20" height="21" viewBox="0 0 25 26" fill="#12636A"><path
                    d="M11.25 15.2867H13.75C14.1042 15.2867 14.401 15.1695 14.6406 14.9348C14.8803
                    14.7003 15 14.4096 15 14.0629C15 13.7162 14.8803 13.4256 14.6406 13.1909C14.401
                    12.9564 14.1042 12.8391 13.75 12.8391H11.25C10.8958 12.8391 10.599 12.9564
                    10.3594 13.1909C10.1198 13.4256 9.99999 13.7162 9.99999 14.0629C9.99999 14.4096
                    10.1198 14.7003 10.3594 14.9348C10.599 15.1695 10.8958 15.2867 11.25
                    15.2867ZM11.25 11.6154H18.75C19.1041 11.6154 19.4011 11.4981 19.6407
                    11.2635C19.8802 11.029 20.0001 10.7383 20.0001 10.3916C20.0001 10.0448 19.8802
                    9.75421 19.6407 9.51964C19.4011 9.28509 19.1041 9.16781 18.75
                    9.16781H11.25C10.8958 9.16781 10.599 9.28509 10.3594 9.51964C10.1198 9.75421
                    9.99999 10.0448 9.99999 10.3916C9.99999 10.7383 10.1198 11.029 10.3594
                    11.2635C10.599 11.4981 10.8958 11.6154 11.25 11.6154ZM11.25
                    7.94404H18.75C19.1041 7.94404 19.4011 7.82676 19.6407 7.59219C19.8802 7.35764
                    20.0001 7.06699 20.0001 6.72025C20.0001 6.37352 19.8802 6.08287 19.6407
                    5.84831C19.4011 5.61376 19.1041 5.49648 18.75 5.49648H11.25C10.8958 5.49648
                    10.599 5.61376 10.3594 5.84831C10.1198 6.08287 9.99999 6.37352 9.99999
                    6.72025C9.99999 7.06699 10.1198 7.35764 10.3594 7.59219C10.599 7.82676 10.8958
                    7.94404 11.25 7.94404ZM7.5 20.1819C6.81249 20.1819 6.22395 19.9422 5.73436
                    19.4629C5.24478 18.9835 4.99999 18.4073 4.99999 17.7343V3.04892C4.99999 2.37585
                    5.24478 1.79966 5.73436 1.32034C6.22395 0.841029 6.81249 0.601379 7.5
                    0.601379H22.5C23.1876 0.601379 23.776 0.841029 24.2656 1.32034C24.7552 1.79966
                    25 2.37585 25 3.04892V17.7343C25 18.4073 24.7552 18.9835 24.2656 19.4629C23.776
                    19.9422 23.1876 20.1819 22.5 20.1819H7.5ZM7.5
                    17.7343H22.5V3.04892H7.5V17.7343ZM2.49999 25.0769C1.81249 25.0769 1.22395
                    24.8373 0.73437 24.3579C0.244785 23.8786 0 23.3025 0 22.6293V6.72025C0 6.37352
                    0.11979 6.08287 0.35937 5.84831C0.59895 5.61376 0.89583 5.49648 1.24999
                    5.49648C1.60416 5.49648 1.90104 5.61376 2.14062 5.84831C2.3802 6.08287 2.49999
                    6.37352 2.49999 6.72025V22.6293H18.75C19.1041 22.6293 19.4011 22.7467 19.6407
                    22.9812C19.8802 23.2157 20.0001 23.5063 20.0001 23.8532C20.0001 24.1999 19.8802
                    24.4905 19.6407 24.7251C19.4011 24.9596 19.1041 25.0769 18.75
                    25.0769H2.49999Z"></path></svg>
                        <div class="w-100" id="bigCardText">         
                        </div>
                      </div>
                    </div>
                  </div> -->
                    <!-- <div class="mainCategoryFistTime hidecard">
                    <div class="card">
                        <div class="card-body d-flex align-items-start">
                          <svg style="margin-right:10px;" width="20" height="21" viewBox="0 0 25 26" fill="#12636A">
                          <path d="M11.25 15.2867H13.75C14.1042 15.2867 14.401 15.1695 14.6406 14.9348C14.8803 14.7003 15
                    14.4096 15 14.0629C15 13.7162 14.8803 13.4256 14.6406 13.1909C14.401 12.9564
                    14.1042 12.8391 13.75 12.8391H11.25C10.8958 12.8391 10.599 12.9564 10.3594
                    13.1909C10.1198 13.4256 9.99999 13.7162 9.99999 14.0629C9.99999 14.4096 10.1198
                    14.7003 10.3594 14.9348C10.599 15.1695 10.8958 15.2867 11.25 15.2867ZM11.25
                    11.6154H18.75C19.1041 11.6154 19.4011 11.4981 19.6407 11.2635C19.8802 11.029
                    20.0001 10.7383 20.0001 10.3916C20.0001 10.0448 19.8802 9.75421 19.6407
                    9.51964C19.4011 9.28509 19.1041 9.16781 18.75 9.16781H11.25C10.8958 9.16781
                    10.599 9.28509 10.3594 9.51964C10.1198 9.75421 9.99999 10.0448 9.99999
                    10.3916C9.99999 10.7383 10.1198 11.029 10.3594 11.2635C10.599 11.4981 10.8958
                    11.6154 11.25 11.6154ZM11.25 7.94404H18.75C19.1041 7.94404 19.4011 7.82676
                    19.6407 7.59219C19.8802 7.35764 20.0001 7.06699 20.0001 6.72025C20.0001 6.37352
                    19.8802 6.08287 19.6407 5.84831C19.4011 5.61376 19.1041 5.49648 18.75
                    5.49648H11.25C10.8958 5.49648 10.599 5.61376 10.3594 5.84831C10.1198 6.08287
                    9.99999 6.37352 9.99999 6.72025C9.99999 7.06699 10.1198 7.35764 10.3594
                    7.59219C10.599 7.82676 10.8958 7.94404 11.25 7.94404ZM7.5 20.1819C6.81249
                    20.1819 6.22395 19.9422 5.73436 19.4629C5.24478 18.9835 4.99999 18.4073 4.99999
                    17.7343V3.04892C4.99999 2.37585 5.24478 1.79966 5.73436 1.32034C6.22395 0.841029
                    6.81249 0.601379 7.5 0.601379H22.5C23.1876 0.601379 23.776 0.841029 24.2656
                    1.32034C24.7552 1.79966 25 2.37585 25 3.04892V17.7343C25 18.4073 24.7552 18.9835
                    24.2656 19.4629C23.776 19.9422 23.1876 20.1819 22.5 20.1819H7.5ZM7.5
                    17.7343H22.5V3.04892H7.5V17.7343ZM2.49999 25.0769C1.81249 25.0769 1.22395
                    24.8373 0.73437 24.3579C0.244785 23.8786 0 23.3025 0 22.6293V6.72025C0 6.37352
                    0.11979 6.08287 0.35937 5.84831C0.59895 5.61376 0.89583 5.49648 1.24999
                    5.49648C1.60416 5.49648 1.90104 5.61376 2.14062 5.84831C2.3802 6.08287 2.49999
                    6.37352 2.49999 6.72025V22.6293H18.75C19.1041 22.6293 19.4011 22.7467 19.6407
                    22.9812C19.8802 23.2157 20.0001 23.5063 20.0001 23.8532C20.0001 24.1999 19.8802
                    24.4905 19.6407 24.7251C19.4011 24.9596 19.1041 25.0769 18.75
                    25.0769H2.49999Z"></path></svg>
                            <div class="2ndBigCard w-100">
                                <div class="map" id="firsTimeCategory"></div>
                            </div>
                    </div>
                    </div>
                  </div> -->
                  </div>
                  <div class="rightCard mx-auto" id="leftSmallCard">
                    <div class="rightCardContent__wrapper d-flex pb-5">
                      <div class="left">
                        <div
                          class="smallCard d-flex flex-column justify-content-center align-items-center">
                          <div class="cardIcon">
                            <svg width="55" height="55" viewBox="0 0 55 55" fill="none"
                              xmlns="http://www.w3.org/2000/svg">
                              <path
                                d="M24.75 32.9999H30.25C31.0291 32.9999 31.6822 32.7366 32.2092 32.2092C32.7366 31.6822 32.9999 31.0291 32.9999 30.25C32.9999 29.4709 32.7366 28.8178 32.2092 28.2905C31.6822 27.7635 31.0291 27.5 30.25 27.5H24.75C23.9708 27.5 23.3177 27.7635 22.7906 28.2905C22.2635 28.8178 22 29.4709 22 30.25C22 31.0291 22.2635 31.6822 22.7906 32.2092C23.3177 32.7366 23.9708 32.9999 24.75 32.9999ZM24.75 24.75H41.2499C42.029 24.75 42.6824 24.4865 43.2094 23.9594C43.7364 23.4323 44.0001 22.7791 44.0001 22C44.0001 21.2208 43.7364 20.5677 43.2094 20.0406C42.6824 19.5135 42.029 19.25 41.2499 19.25H24.75C23.9708 19.25 23.3177 19.5135 22.7906 20.0406C22.2635 20.5677 22 21.2208 22 22C22 22.7791 22.2635 23.4323 22.7906 23.9594C23.3177 24.4865 23.9708 24.75 24.75 24.75ZM24.75 16.5H41.2499C42.029 16.5 42.6824 16.2365 43.2094 15.7094C43.7364 15.1823 44.0001 14.5291 44.0001 13.75C44.0001 12.9708 43.7364 12.3177 43.2094 11.7906C42.6824 11.2635 42.029 11 41.2499 11H24.75C23.9708 11 23.3177 11.2635 22.7906 11.7906C22.2635 12.3177 22 12.9708 22 13.75C22 14.5291 22.2635 15.1823 22.7906 15.7094C23.3177 16.2365 23.9708 16.5 24.75 16.5ZM16.5 44.0001C14.9875 44.0001 13.6927 43.4616 12.6156 42.3844C11.5385 41.3073 11 40.0124 11 38.5V5.49998C11 3.98749 11.5385 2.6927 12.6156 1.61561C13.6927 0.538527 14.9875 0 16.5 0H49.4999C51.0126 0 52.3072 0.538527 53.3843 1.61561C54.4614 2.6927 55 3.98749 55 5.49998V38.5C55 40.0124 54.4614 41.3073 53.3843 42.3844C52.3072 43.4616 51.0126 44.0001 49.4999 44.0001H16.5ZM16.5 38.5H49.4999V5.49998H16.5V38.5ZM5.49998 55C3.98749 55 2.6927 54.4614 1.61561 53.3843C0.538527 52.3072 0 51.0126 0 49.4999V13.75C0 12.9708 0.263538 12.3177 0.790614 11.7906C1.31769 11.2635 1.97083 11 2.74999 11C3.52915 11 4.18229 11.2635 4.70936 11.7906C5.23644 12.3177 5.49998 12.9708 5.49998 13.75V49.4999H41.2499C42.029 49.4999 42.6824 49.7636 43.2094 50.2906C43.7364 50.8176 44.0001 51.4707 44.0001 52.2501C44.0001 53.0292 43.7364 53.6823 43.2094 54.2093C42.6824 54.7363 42.029 55 41.2499 55H5.49998Z"
                                fill="#12636A" />
                            </svg>
                          </div>
                          <div class="cardTitle">
                            Masterwork
                          </div>
                        </div>

                        <div
                          class="smallCard d-flex flex-column justify-content-center align-items-center">
                          <div class="cardIcon">
                            <svg width="55" height="55" viewBox="0 0 55 55" fill="none"
                              xmlns="http://www.w3.org/2000/svg">
                              <path
                                d="M24.75 32.9999H30.25C31.0291 32.9999 31.6822 32.7366 32.2092 32.2092C32.7366 31.6822 32.9999 31.0291 32.9999 30.25C32.9999 29.4709 32.7366 28.8178 32.2092 28.2905C31.6822 27.7635 31.0291 27.5 30.25 27.5H24.75C23.9708 27.5 23.3177 27.7635 22.7906 28.2905C22.2635 28.8178 22 29.4709 22 30.25C22 31.0291 22.2635 31.6822 22.7906 32.2092C23.3177 32.7366 23.9708 32.9999 24.75 32.9999ZM24.75 24.75H41.2499C42.029 24.75 42.6824 24.4865 43.2094 23.9594C43.7364 23.4323 44.0001 22.7791 44.0001 22C44.0001 21.2208 43.7364 20.5677 43.2094 20.0406C42.6824 19.5135 42.029 19.25 41.2499 19.25H24.75C23.9708 19.25 23.3177 19.5135 22.7906 20.0406C22.2635 20.5677 22 21.2208 22 22C22 22.7791 22.2635 23.4323 22.7906 23.9594C23.3177 24.4865 23.9708 24.75 24.75 24.75ZM24.75 16.5H41.2499C42.029 16.5 42.6824 16.2365 43.2094 15.7094C43.7364 15.1823 44.0001 14.5291 44.0001 13.75C44.0001 12.9708 43.7364 12.3177 43.2094 11.7906C42.6824 11.2635 42.029 11 41.2499 11H24.75C23.9708 11 23.3177 11.2635 22.7906 11.7906C22.2635 12.3177 22 12.9708 22 13.75C22 14.5291 22.2635 15.1823 22.7906 15.7094C23.3177 16.2365 23.9708 16.5 24.75 16.5ZM16.5 44.0001C14.9875 44.0001 13.6927 43.4616 12.6156 42.3844C11.5385 41.3073 11 40.0124 11 38.5V5.49998C11 3.98749 11.5385 2.6927 12.6156 1.61561C13.6927 0.538527 14.9875 0 16.5 0H49.4999C51.0126 0 52.3072 0.538527 53.3843 1.61561C54.4614 2.6927 55 3.98749 55 5.49998V38.5C55 40.0124 54.4614 41.3073 53.3843 42.3844C52.3072 43.4616 51.0126 44.0001 49.4999 44.0001H16.5ZM16.5 38.5H49.4999V5.49998H16.5V38.5ZM5.49998 55C3.98749 55 2.6927 54.4614 1.61561 53.3843C0.538527 52.3072 0 51.0126 0 49.4999V13.75C0 12.9708 0.263538 12.3177 0.790614 11.7906C1.31769 11.2635 1.97083 11 2.74999 11C3.52915 11 4.18229 11.2635 4.70936 11.7906C5.23644 12.3177 5.49998 12.9708 5.49998 13.75V49.4999H41.2499C42.029 49.4999 42.6824 49.7636 43.2094 50.2906C43.7364 50.8176 44.0001 51.4707 44.0001 52.2501C44.0001 53.0292 43.7364 53.6823 43.2094 54.2093C42.6824 54.7363 42.029 55 41.2499 55H5.49998Z"
                                fill="#12636A" />
                            </svg>
                          </div>
                          <div class="cardTitle">
                            Masterwork
                          </div>
                        </div>
                      </div>
                      <div class="right mt-4">
                        <div
                          class="smallCard d-flex flex-column justify-content-center align-items-center">
                          <div class="cardIcon">
                            <svg width="55" height="55" viewBox="0 0 55 55" fill="none"
                              xmlns="http://www.w3.org/2000/svg">
                              <path
                                d="M24.75 32.9999H30.25C31.0291 32.9999 31.6822 32.7366 32.2092 32.2092C32.7366 31.6822 32.9999 31.0291 32.9999 30.25C32.9999 29.4709 32.7366 28.8178 32.2092 28.2905C31.6822 27.7635 31.0291 27.5 30.25 27.5H24.75C23.9708 27.5 23.3177 27.7635 22.7906 28.2905C22.2635 28.8178 22 29.4709 22 30.25C22 31.0291 22.2635 31.6822 22.7906 32.2092C23.3177 32.7366 23.9708 32.9999 24.75 32.9999ZM24.75 24.75H41.2499C42.029 24.75 42.6824 24.4865 43.2094 23.9594C43.7364 23.4323 44.0001 22.7791 44.0001 22C44.0001 21.2208 43.7364 20.5677 43.2094 20.0406C42.6824 19.5135 42.029 19.25 41.2499 19.25H24.75C23.9708 19.25 23.3177 19.5135 22.7906 20.0406C22.2635 20.5677 22 21.2208 22 22C22 22.7791 22.2635 23.4323 22.7906 23.9594C23.3177 24.4865 23.9708 24.75 24.75 24.75ZM24.75 16.5H41.2499C42.029 16.5 42.6824 16.2365 43.2094 15.7094C43.7364 15.1823 44.0001 14.5291 44.0001 13.75C44.0001 12.9708 43.7364 12.3177 43.2094 11.7906C42.6824 11.2635 42.029 11 41.2499 11H24.75C23.9708 11 23.3177 11.2635 22.7906 11.7906C22.2635 12.3177 22 12.9708 22 13.75C22 14.5291 22.2635 15.1823 22.7906 15.7094C23.3177 16.2365 23.9708 16.5 24.75 16.5ZM16.5 44.0001C14.9875 44.0001 13.6927 43.4616 12.6156 42.3844C11.5385 41.3073 11 40.0124 11 38.5V5.49998C11 3.98749 11.5385 2.6927 12.6156 1.61561C13.6927 0.538527 14.9875 0 16.5 0H49.4999C51.0126 0 52.3072 0.538527 53.3843 1.61561C54.4614 2.6927 55 3.98749 55 5.49998V38.5C55 40.0124 54.4614 41.3073 53.3843 42.3844C52.3072 43.4616 51.0126 44.0001 49.4999 44.0001H16.5ZM16.5 38.5H49.4999V5.49998H16.5V38.5ZM5.49998 55C3.98749 55 2.6927 54.4614 1.61561 53.3843C0.538527 52.3072 0 51.0126 0 49.4999V13.75C0 12.9708 0.263538 12.3177 0.790614 11.7906C1.31769 11.2635 1.97083 11 2.74999 11C3.52915 11 4.18229 11.2635 4.70936 11.7906C5.23644 12.3177 5.49998 12.9708 5.49998 13.75V49.4999H41.2499C42.029 49.4999 42.6824 49.7636 43.2094 50.2906C43.7364 50.8176 44.0001 51.4707 44.0001 52.2501C44.0001 53.0292 43.7364 53.6823 43.2094 54.2093C42.6824 54.7363 42.029 55 41.2499 55H5.49998Z"
                                fill="#12636A" />
                            </svg>
                          </div>
                          <div class="cardTitle">
                            Masterwork
                          </div>
                        </div>
                        <div
                          class="smallCard d-flex flex-column justify-content-center align-items-center">
                          <div class="cardIcon">
                            <svg width="55" height="55" viewBox="0 0 55 55" fill="none"
                              xmlns="http://www.w3.org/2000/svg">
                              <path
                                d="M24.75 32.9999H30.25C31.0291 32.9999 31.6822 32.7366 32.2092 32.2092C32.7366 31.6822 32.9999 31.0291 32.9999 30.25C32.9999 29.4709 32.7366 28.8178 32.2092 28.2905C31.6822 27.7635 31.0291 27.5 30.25 27.5H24.75C23.9708 27.5 23.3177 27.7635 22.7906 28.2905C22.2635 28.8178 22 29.4709 22 30.25C22 31.0291 22.2635 31.6822 22.7906 32.2092C23.3177 32.7366 23.9708 32.9999 24.75 32.9999ZM24.75 24.75H41.2499C42.029 24.75 42.6824 24.4865 43.2094 23.9594C43.7364 23.4323 44.0001 22.7791 44.0001 22C44.0001 21.2208 43.7364 20.5677 43.2094 20.0406C42.6824 19.5135 42.029 19.25 41.2499 19.25H24.75C23.9708 19.25 23.3177 19.5135 22.7906 20.0406C22.2635 20.5677 22 21.2208 22 22C22 22.7791 22.2635 23.4323 22.7906 23.9594C23.3177 24.4865 23.9708 24.75 24.75 24.75ZM24.75 16.5H41.2499C42.029 16.5 42.6824 16.2365 43.2094 15.7094C43.7364 15.1823 44.0001 14.5291 44.0001 13.75C44.0001 12.9708 43.7364 12.3177 43.2094 11.7906C42.6824 11.2635 42.029 11 41.2499 11H24.75C23.9708 11 23.3177 11.2635 22.7906 11.7906C22.2635 12.3177 22 12.9708 22 13.75C22 14.5291 22.2635 15.1823 22.7906 15.7094C23.3177 16.2365 23.9708 16.5 24.75 16.5ZM16.5 44.0001C14.9875 44.0001 13.6927 43.4616 12.6156 42.3844C11.5385 41.3073 11 40.0124 11 38.5V5.49998C11 3.98749 11.5385 2.6927 12.6156 1.61561C13.6927 0.538527 14.9875 0 16.5 0H49.4999C51.0126 0 52.3072 0.538527 53.3843 1.61561C54.4614 2.6927 55 3.98749 55 5.49998V38.5C55 40.0124 54.4614 41.3073 53.3843 42.3844C52.3072 43.4616 51.0126 44.0001 49.4999 44.0001H16.5ZM16.5 38.5H49.4999V5.49998H16.5V38.5ZM5.49998 55C3.98749 55 2.6927 54.4614 1.61561 53.3843C0.538527 52.3072 0 51.0126 0 49.4999V13.75C0 12.9708 0.263538 12.3177 0.790614 11.7906C1.31769 11.2635 1.97083 11 2.74999 11C3.52915 11 4.18229 11.2635 4.70936 11.7906C5.23644 12.3177 5.49998 12.9708 5.49998 13.75V49.4999H41.2499C42.029 49.4999 42.6824 49.7636 43.2094 50.2906C43.7364 50.8176 44.0001 51.4707 44.0001 52.2501C44.0001 53.0292 43.7364 53.6823 43.2094 54.2093C42.6824 54.7363 42.029 55 41.2499 55H5.49998Z"
                                fill="#12636A" />
                            </svg>
                          </div>
                          <div class="cardTitle">
                            Masterwork
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="cardButtonWrapper mt-5 mt-md-0 hidecard">
                      <!-- <div id="landing__card">             
                    </div> -->
                    </div>

                  </div>
                </div>
              </div>
              <div class="container mt-4 px-4">
                <!-- <div class="card mb-5 landingPageCard">
              <div class="card-body d-flex align-items-start">
                <svg style="margin-right:10px;" width="20" height="21" viewBox="0 0 25 26" fill="none"><path
                d="M11.25 15.2867H13.75C14.1042 15.2867 14.401 15.1695 14.6406 14.9348C14.8803
                14.7003 15 14.4096 15 14.0629C15 13.7162 14.8803 13.4256 14.6406 13.1909C14.401
                12.9564 14.1042 12.8391 13.75 12.8391H11.25C10.8958 12.8391 10.599 12.9564 10.3594
                13.1909C10.1198 13.4256 9.99999 13.7162 9.99999 14.0629C9.99999 14.4096 10.1198
                14.7003 10.3594 14.9348C10.599 15.1695 10.8958 15.2867 11.25 15.2867ZM11.25
                11.6154H18.75C19.1041 11.6154 19.4011 11.4981 19.6407 11.2635C19.8802 11.029 20.0001
                10.7383 20.0001 10.3916C20.0001 10.0448 19.8802 9.75421 19.6407 9.51964C19.4011
                9.28509 19.1041 9.16781 18.75 9.16781H11.25C10.8958 9.16781 10.599 9.28509 10.3594
                9.51964C10.1198 9.75421 9.99999 10.0448 9.99999 10.3916C9.99999 10.7383 10.1198
                11.029 10.3594 11.2635C10.599 11.4981 10.8958 11.6154 11.25 11.6154ZM11.25
                7.94404H18.75C19.1041 7.94404 19.4011 7.82676 19.6407 7.59219C19.8802 7.35764
                20.0001 7.06699 20.0001 6.72025C20.0001 6.37352 19.8802 6.08287 19.6407
                5.84831C19.4011 5.61376 19.1041 5.49648 18.75 5.49648H11.25C10.8958 5.49648 10.599
                5.61376 10.3594 5.84831C10.1198 6.08287 9.99999 6.37352 9.99999 6.72025C9.99999
                7.06699 10.1198 7.35764 10.3594 7.59219C10.599 7.82676 10.8958 7.94404 11.25
                7.94404ZM7.5 20.1819C6.81249 20.1819 6.22395 19.9422 5.73436 19.4629C5.24478 18.9835
                4.99999 18.4073 4.99999 17.7343V3.04892C4.99999 2.37585 5.24478 1.79966 5.73436
                1.32034C6.22395 0.841029 6.81249 0.601379 7.5 0.601379H22.5C23.1876 0.601379 23.776
                0.841029 24.2656 1.32034C24.7552 1.79966 25 2.37585 25 3.04892V17.7343C25 18.4073
                24.7552 18.9835 24.2656 19.4629C23.776 19.9422 23.1876 20.1819 22.5 20.1819H7.5ZM7.5
                17.7343H22.5V3.04892H7.5V17.7343ZM2.49999 25.0769C1.81249 25.0769 1.22395 24.8373
                0.73437 24.3579C0.244785 23.8786 0 23.3025 0 22.6293V6.72025C0 6.37352 0.11979
                6.08287 0.35937 5.84831C0.59895 5.61376 0.89583 5.49648 1.24999 5.49648C1.60416
                5.49648 1.90104 5.61376 2.14062 5.84831C2.3802 6.08287 2.49999 6.37352 2.49999
                6.72025V22.6293H18.75C19.1041 22.6293 19.4011 22.7467 19.6407 22.9812C19.8802
                23.2157 20.0001 23.5063 20.0001 23.8532C20.0001 24.1999 19.8802 24.4905 19.6407
                24.7251C19.4011 24.9596 19.1041 25.0769 18.75 25.0769H2.49999Z"
                fill="#4381CC"></path></svg>
                <div class="w-100" id="bigCardText">         
                </div>
              </div>
            </div> -->
              </div>
            </article>
          </div>
        </div>
      </div>
    
    <footer
        class="sticky-lg-bottom">
        <div class="container">
          <span class="credit"> Copyright © 2024 <a href="https://metapercept.com/" target="_blank">Metapercept
    Technology Services LLP</a> All Rights Reserved </span>
        </div>
      </footer>

    <div
        class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample"
        aria-labelledby="offcanvasExampleLabel">
        <div class="offcanvas-header">
          <h5 class="offcanvas-title" id="offcanvasExampleLabel"></h5>
          <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
          <nav id="myUL2">
            <ul>
              <xsl:call-template name="commonattributes" />
              <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist" />
              </xsl:apply-templates>
            </ul>
          </nav>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
    [not(@toc = 'no')]
    [not(@processing-role = 'resource-only')]"
    mode="toc">
    <xsl:param name="pathFromMaplist" />
    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="get-navtitle" />
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="normalize-space($title)">

        <li>
          <xsl:call-template name="commonattributes" />
          <xsl:choose>
            <!-- If there is a reference to a DITA or HTML file, and it is not external: -->

            <xsl:when test="normalize-space(@href)">
              <a>
                <xsl:attribute name="href">
                  <xsl:choose>
                    <xsl:when
                      test="@copy-to and not(contains(@chunk, 'to-content')) and 
                      (not(@format) or @format = 'dita' or @format = 'ditamap') ">
                      <xsl:if test="not(@scope = 'external')">
                        <xsl:value-of select="$pathFromMaplist" />
                      </xsl:if>
                      <xsl:call-template
                        name="replace-extension">
                        <xsl:with-param name="filename" select="@copy-to" />
                        <xsl:with-param name="extension" select="$OUTEXT" />
                      </xsl:call-template>
                      <xsl:if
                        test="not(contains(@copy-to, '#')) and contains(@href, '#')">
                        <xsl:value-of select="concat('#', substring-after(@href, '#'))" />
                      </xsl:if>
                    </xsl:when>
                    <xsl:when
                      test="not(@scope = 'external') and (not(@format) or @format = 'dita' or @format = 'ditamap')">
                      <xsl:if test="not(@scope = 'external')">
                        <xsl:value-of select="$pathFromMaplist" />
                      </xsl:if>
                      <xsl:call-template
                        name="replace-extension">
                        <xsl:with-param name="filename" select="@href" />
                        <xsl:with-param name="extension" select="$OUTEXT" />
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise><!-- If non-DITA, keep the href as-is -->
                      <xsl:if test="not(@scope = 'external')">
                        <xsl:value-of select="$pathFromMaplist" />
                      </xsl:if>
                      <xsl:value-of
                        select="@href" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:if
                  test="@scope = 'external' or not(not(@format) or @format = 'dita' or @format = 'ditamap')">
                  <xsl:apply-templates select="." mode="external-link" />
                </xsl:if>
                <xsl:value-of select="$title" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <div class="caret d-flex justify-content-between">
                <div class="d-flex align-items-center iconAndTitle">
                  <xsl:value-of select="$title" />
                </div>
                <svg class="menu__icon" xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                  viewBox="0 0 24 24">
                  <path fill="currentColor"
                    d="M11.7 15.3q-.475.475-1.087.213T10 14.575v-5.15q0-.675.613-.938T11.7 8.7l2.6 2.6q.15.15.225.325T14.6 12q0 .2-.075.375t-.225.325l-2.6 2.6Z"></path>
                </svg>
              </div>
            </xsl:otherwise>
          </xsl:choose>
          <!-- If there are any children that should be in the TOC, process them -->
          <xsl:if
            test="descendant::*[contains(@class, ' map/topicref ')]
            [not(@toc = 'no')]
            [not(@processing-role = 'resource-only')]">
            <ul class="nested">
              <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist" />
              </xsl:apply-templates>
            </ul>
          </xsl:if>
        </li>

      </xsl:when>
      <xsl:otherwise><!-- if it is an empty topicref -->
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="toc">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist" />
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- If toc=no, but a child has toc=yes, that child should bubble up to the top -->
  <xsl:template
    match="*[contains(@class, ' map/topicref ')]
    [@toc = 'no']
    [not(@processing-role = 'resource-only')]"
    mode="toc">
    <xsl:param name="pathFromMaplist" />
    <xsl:apply-templates
      select="*[contains(@class, ' map/topicref ')]" mode="toc">
      <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="*" mode="toc" priority="-1" />

  <xsl:template match="*[contains(@class, ' map/map ')]">
    <xsl:apply-templates select="." mode="root_element" />
  </xsl:template>

  <xsl:variable name="relpath">
    <xsl:choose>
      <xsl:when test="$FILEDIR='.'">
        <xsl:text>.</xsl:text>
      </xsl:when>
      <xsl:when test="contains($FILEDIR,'\')">
        <xsl:value-of select=" replace($FILEDIR,'[^\\]+','..')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select=" replace($FILEDIR,'[^/]+','..')" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="*[contains(@class, ' map/map ')]" mode="chapterBody">
    <head>
      <link rel="icon" type="image/x-icon" href="images/Web_favicon.png"></link>
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
        crossorigin="anonymous"
      />
      <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        integrity="sha384-Ay26V7L8bsJTsX9Sxclnvsn+hkdiwRnrjZJXqKmkIDobPgIIWBOVguEcQQLDuhfN"
        crossorigin="anonymous"
      />
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3" />
      <!-- <script src="https://cdn.jsdelivr.net/npm/@docsearch/js@3"></script> -->
      <script src="https://cdn.jsdelivr.net/npm/algoliasearch@4"></script>

    </head>
    <body
      class="tocMain">
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@style"
        mode="add-ditaval-style" />
      <xsl:if test="@outputclass">
        <xsl:attribute name="class" select="@outputclass" />
      </xsl:if>
      <xsl:apply-templates select="." mode="addAttributesToBody" />
      <xsl:call-template name="setidaname" />
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]"
        mode="out-of-line" />
      <xsl:call-template name="generateBreadcrumbs" />
      <xsl:call-template name="gen-user-header" />
      <xsl:call-template name="processHDR" />
      <xsl:if test="$INDEXSHOW = 'yes'">
        <xsl:apply-templates
          select="/*/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]" />
      </xsl:if>
      <xsl:call-template name="gen-user-sidetoc" />
      <xsl:choose>
        <xsl:when test="*[contains(@class, ' topic/title ')]"> </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@title" />
        </xsl:otherwise>
      </xsl:choose>

      <!-- ========================================================================xxxxxxxxxxxxxxx -->
      <!-- <div class="container my-5">
        <div class="d-flex searchBoxWrapper2 no-print mx-auto" role="search">
          <input id="headerSearchBox" class="form-control me-2" type="search" placeholder="Search"
      aria-label="Search" data-bs-toggle="modal" data-bs-target="#searchBoxModal" />
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 1024 1024"><path
      fill="#000" d="M1014.64 969.04L703.71 656.207c57.952-69.408 92.88-158.704
      92.88-256.208c0-220.912-179.088-400-400-400s-400 179.088-400 400s179.088 400 400 400c100.368 0
      192.048-37.056 262.288-98.144l310.496 312.448c12.496 12.497 32.769 12.497 45.265
      0c12.48-12.496 12.48-32.752 0-45.263zM396.59 736.527c-185.856
      0-336.528-150.672-336.528-336.528S210.734 63.471 396.59 63.471c185.856 0 336.528 150.672
      336.528 336.528S582.446 736.527 396.59 736.527z"/></svg>
        </div>
      </div> -->
      <!-- ========================================================================xxxxxxxxxxxxxxx -->

      <!-- Modal -->

      <div class="modal fade" id="searchBoxModal" tabindex="-1" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog modal-dialog-scrollable modal-fullscreen-lg-down">
          <div class="modal-content">
            <div class="modal-header">
              <div
                class="serachAndIcon styleSearch d-flex justify-content-between align-items-start">
                <div class="d-flex align-items-start w-100">
                  <!-- <input class="form-control me-2" type="search" placeholder="Search docs"
                  aria-label="Search" id="search-input" autocomplete="off" /> -->
                  <div class="ditasearch w-100" data-searchroot=""></div>
                </div>
                <button class="searchButton mt-2" type="button" data-bs-dismiss="modal"
                  aria-label="Close">Cancel</button>
              </div>
              <!-- <button type="button" class="btn-close" data-bs-dismiss="modal"
              aria-label="Close"></button> -->
            </div>
            <div id="nosearch" style="display: none; padding: 2rem 0; text-align:center;"></div>
          </div>
        </div>
      </div>

      <xsl:variable name="map" as="element()*">
        <xsl:apply-templates select="." mode="normalize-map" />
      </xsl:variable>
      <xsl:apply-templates select="$map" mode="toc" />
      <xsl:call-template name="gen-endnotes" />
      <xsl:call-template name="gen-user-footer" />
      <xsl:call-template name="processFTR" />
      <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]"
        mode="out-of-line" />

      <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"
      />

      <script language="javascript" src="js/commonJS.js" />
      <script language="javascript" src="js/tocLanding.js" />

      <!-- <script
      src="https://cdn.jsdelivr.net/gh/Gurushesh-Metapercept/cdn_client_v3@main/commonJS.js"></script> 
      <script
      src="https://cdn.jsdelivr.net/gh/Gurushesh-Metapercept/cdn_client_v3@main/tocLanding.js"></script>  -->

    </body>
  </xsl:template>


  <xsl:template match="*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/title ')]">
    <h1 class="title topictitle1">
      <xsl:call-template name="gen-user-panel-title-pfx" />
      <xsl:apply-templates />
    </h1>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' map/map ')]/@title">
    <h1 class="title topictitle1">
      <xsl:call-template name="gen-user-panel-title-pfx" />
      <xsl:value-of select="." />
    </h1>
  </xsl:template>


  <xsl:template
    match="*[contains(@class,' bookmap/bookmap ')]/*[contains(@class,' bookmap/booktitle ')]"
    priority="10">
    <h1 class="title topictitle1" style="color:red">
      <xsl:call-template name="gen-user-panel-title-pfx" />
      <xsl:apply-templates select="*[contains(@class, ' bookmap/mainbooktitle ')]/node()" />
    </h1>
  </xsl:template>

  <xsl:template name="generateChapterTitle">
    <title>
      <xsl:choose>
        <xsl:when
          test="/*[contains(@class,' bookmap/bookmap ')]/*[contains(@class,' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]">
          <xsl:call-template name="gen-user-panel-title-pfx" />
          <xsl:value-of
            select="/*[contains(@class,' bookmap/bookmap ')]/*[contains(@class,' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]" />
        </xsl:when>
        <xsl:when test="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]">
          <xsl:call-template name="gen-user-panel-title-pfx" />
          <xsl:value-of
            select="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]" />
        </xsl:when>
        <xsl:when test="/*[contains(@class,' map/map ')]/@title">
          <xsl:call-template name="gen-user-panel-title-pfx" />
          <xsl:value-of
            select="/*[contains(@class,' map/map ')]/@title" />
        </xsl:when>
      </xsl:choose>
    </title>
  </xsl:template>

</xsl:stylesheet>