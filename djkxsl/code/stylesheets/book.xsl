<?xml version="1.0" encoding="utf-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="2.0">

  <xsl:include href="setup.xsl"/>
  <xsl:include href="blocks.xsl"/>
  <xsl:include href="inline.xsl"/>
  <xsl:include href="toc.xsl"/>

  <xsl:param name="body.font.family">
    <xsl:value-of select="//book/bookmeta/fonts/bodyfont"/>
  </xsl:param>
  <xsl:param name="body.font.size">
    <xsl:value-of select="//book/bookmeta/fonts/bodyfontsize"/>
  </xsl:param>
  <xsl:param name="line.height">
    <xsl:value-of select="//book/bookmeta/fonts/bodyfontlineheight"/>
  </xsl:param>
  <xsl:param name="poemtitlefont">
    <xsl:value-of select="//book/bookmeta/fonts/poemtitlefont"/>
  </xsl:param>
  <xsl:param name="poemtitlefontsize">
    <xsl:value-of select="//book/bookmeta/fonts/poemtitlefontsize"/>
  </xsl:param>
  <xsl:param name="chaptertitlefont">
    <xsl:value-of select="//book/bookmeta/fonts/chaptertitlefont"/>
  </xsl:param>
  <xsl:param name="chaptertitlefontsize">
    <xsl:value-of select="//book/bookmeta/fonts/chaptertitlefontsize"/>
  </xsl:param>
 <xsl:param name="chapternumberfontsize">
    <xsl:value-of select="//book/bookmeta/fonts/chapternumberfontsize"/>
  </xsl:param>
  <xsl:param name="othertitlefont">
    <xsl:value-of select="//book/bookmeta/fonts/othertitlefont"/>
  </xsl:param>
  <xsl:param name="othertitlefontsize">
    <xsl:value-of select="//book/bookmeta/fonts/othertitlefontsize"/>
  </xsl:param>
  <xsl:param name="titlepage-title-size">
     <xsl:value-of select="//book/bookmeta/fonts/titlepagetitlefontsize"/>
  </xsl:param>
  <xsl:param name="titlepage-author-size">
     <xsl:value-of select="//book/bookmeta/fonts/titlepageauthorfontsize"/>    
  </xsl:param>
  <!-- The book starts here. -->
  <xsl:template match="book">
    <xsl:param name="page.width">
      <xsl:choose>
        <xsl:when test="string-length(bookmeta/pagesize/pagewidth) &gt; 0">
          <xsl:value-of select="bookmeta/pagesize/pagewidth"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>5.25in</xsl:text>
          <!-- 'Trade' paperback or B format -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="page.height">
      <xsl:choose>
        <xsl:when test="string-length(bookmeta/pagesize/pageheight) &gt; 0">
          <xsl:value-of select="bookmeta/pagesize/pageheight"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>8in</xsl:text>
          <!-- 'Trade' paperback or B format -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>

    <xsl:variable name="cover">
      <xsl:value-of select="@cover"/>
    </xsl:variable>

    <fo:root font-family="{$body.font.family}" font-size="{$body.font.size}" hyphenate="true" language="en_US">
      <xsl:call-template name="page-setup">
        <xsl:with-param name="page.width" select="$page.width"/>
        <xsl:with-param name="page.height" select="$page.height"/>
      </xsl:call-template>
      <!-- Eventually need to define an online versus print process.  In the meantime, just comment out the cover. -->
      <xsl:if test="//book/@cover">
     <fo:page-sequence master-reference="cover">
        <fo:flow flow-name="xsl-region-body">
          <fo:block padding-top="-1pt" text-align="center">
          <fo:external-graphic src="url({$cover})" content-height="{$page.height}" />
          </fo:block>
          <fo:block page-break-before="always"></fo:block>
        </fo:flow> 
     </fo:page-sequence>
      </xsl:if>
      <fo:page-sequence master-reference="title-page">
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-family="{$chaptertitlefont}" text-align="center" margin-top="1in" font-size="{$titlepage-title-size}"
            page-break-before="always">
            <xsl:value-of select="title"/>
          </fo:block>
          <xsl:if test="subtitle">
            <fo:block font-size="18pt" margin-top="24pt" text-align="center">
              <xsl:value-of select="subtitle"/>
            </fo:block>
          </xsl:if>
          <fo:block font-size="{$titlepage-author-size}" text-align="center" margin-top="36pt" font-family="{$chaptertitlefont}">
            <xsl:value-of select="author"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
      <fo:page-sequence master-reference="copyright">
        <fo:flow flow-name="xsl-region-body">
          <fo:block page-break-before="always" margin-bottom="6pt">
            <fo:external-graphic src="url(../../graphics/peloria press logo-BW.png)" content-width="1in"/>
          </fo:block>
          <fo:block margin-bottom="6pt"> <xsl:text>Copyright </xsl:text> <xsl:apply-templates
            select="notices/copyrightdate"/>, <xsl:apply-templates select="notices/copyrightholder"/>. </fo:block>
          <fo:block-container display-align="after" height="5in">
            <xsl:for-each select="notices/additional-rights/p">
              <fo:block font-style="italic" padding-top="3pt" padding-bottom="3pt">
                <xsl:apply-templates/>
              </fo:block>
            </xsl:for-each>

          </fo:block-container>
        </fo:flow>
      </fo:page-sequence>
      <xsl:if test="reviewquotes/reviewquote">
        <fo:page-sequence master-reference="frontmatter" force-page-count="end-on-even">
          <fo:flow flow-name="xsl-region-body"  hyphenate="true" hyphenation-remain-character-count="3" hyphenation-push-character-count="3" hyphenation-ladder-count="1">
            <xsl:apply-templates select="reviewquotes"/>
          </fo:flow>
        </fo:page-sequence>
      </xsl:if>
      <xsl:if test="@toc='yes'">
        <fo:page-sequence master-reference="toc">
          <fo:flow flow-name="xsl-region-body">
            <fo:block font-family="{$chaptertitlefont}" font-size="{$chaptertitlefontsize}">Table of contents</fo:block>
            <xsl:apply-templates mode="toc"/>
          </fo:flow>
        </fo:page-sequence>
      </xsl:if>
      <xsl:if test="dedication or prolog">
        <fo:page-sequence master-reference="frontmatter" force-page-count="end-on-even">
          <fo:flow flow-name="xsl-region-body" hyphenate="true">
            <xsl:apply-templates select="dedication | prolog"/>
          </fo:flow>
        </fo:page-sequence>
      </xsl:if>

      <xsl:apply-templates select="part | chapter | appendix | acks | blank | colophon"/>

    </fo:root>
  </xsl:template>
  <!-- The book stops here. -->

  <xsl:template match="reviewquotes">
    <fo:block text-align="center" font-size="15pt">Reviewers are excited about</fo:block>
    <fo:block text-align="center" font-size="15pt" padding-bottom="18pt">
      <fo:inline font-style="italic">
        <xsl:value-of select="//book/title"/>
      </fo:inline>...
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="reviewquote">
    <fo:block padding-top="6pt" padding-bottom="6pt" font-size="10pt" keep-together.within-page="always">
      <xsl:apply-templates select="quotebody"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="quotebody">
    <fo:block padding-bottom="3pt">
      <xsl:apply-templates/>
    </fo:block>
    <fo:block text-align="right"> &#x2014; <fo:inline font-weight="bold"><xsl:value-of
      select="following-sibling::quoteperson"/></fo:inline> <xsl:text>,  </xsl:text> <xsl:for-each
      select="following-sibling::personattributions"> <xsl:apply-templates/> </xsl:for-each> </fo:block>
  </xsl:template>

  <xsl:template match="prolog">
    <fo:block page-break-before="always" margin-top="1in">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="dedication">
    <fo:block page-break-before="always" font-style="italic" text-align="center" margin-top="2in">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
 
  <xsl:template match="part | chapter | appendix">
    <fo:page-sequence master-reference="body">
      <fo:static-content flow-name="xsl-region-before-odd">
        <fo:table font-size="9" font-style="italic" table-layout="fixed" width="100%" margin-bottom="9pt">
          <fo:table-column column-number="1" column-width="proportional-column-width(6)"/>
          <fo:table-column column-number="2" column-width="proportional-column-width(1)"/>
       <!--  <fo:table-column column-number="3" column-width="proportional-column-width(1)"/> -->  
          <fo:table-body>
            <fo:table-row>
            <!--   <fo:table-cell>
                <fo:block>&#x200b;</fo:block>
              </fo:table-cell> -->
              <fo:table-cell text-align="left">
                <fo:block>
                  <xsl:value-of select="//book/title"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block>
                  <fo:page-number/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-even">
        <fo:table font-size="9" font-style="italic" table-layout="fixed" width="100%">
          <fo:table-column column-number="1" column-width="proportional-column-width(1)"/>
          <fo:table-column column-number="2" column-width="proportional-column-width(6)"/>
         <!-- <fo:table-column column-number="3" column-width="proportional-column-width(4)"/> --> 
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell text-align="left">
                <fo:block>
                  <fo:page-number/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block>
                  <xsl:value-of select="//book/author"/>
                </fo:block>
              </fo:table-cell>
           <!--  <fo:table-cell>
                <fo:block>&#x200b;</fo:block>
              </fo:table-cell>  --> 
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body" hyphenate="true" hyphenation-remain-character-count="3" hyphenation-push-character-count="3" hyphenation-ladder-count="1" >
        <fo:block id="{@id}" page-break-before="always" margin-top="1in">
          <xsl:apply-templates/>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  
 <xsl:template match="blank">
   <fo:page-sequence  master-reference="blank" >
     <fo:flow flow-name="xsl-region-body" hyphenate="true" hyphenation-remain-character-count="3" hyphenation-push-character-count="3" hyphenation-ladder-count="1" >
        <fo:block id="{@id}" page-break-before="always" margin-top="1.75in" margin-left=".5in" margin-right=".5in">
          <xsl:apply-templates/>
        </fo:block>
     </fo:flow>
   </fo:page-sequence>
 </xsl:template>
  
 <xsl:template match="acks">
   <fo:page-sequence master-reference="body" >
     <fo:flow flow-name="xsl-region-body" hyphenate="true" hyphenation-remain-character-count="3" hyphenation-push-character-count="3" hyphenation-ladder-count="1" >
       <fo:block id="{@id}" page-break-before="always" margin-top="1in" margin-left=".5in" margin-right=".5in">
         <fo:block font-size="{$poemtitlefontsize}" text-align="center" padding-bottom="6pt">Acknowledgments</fo:block>
          <xsl:apply-templates/>
        </fo:block>
     </fo:flow>
   </fo:page-sequence>
  </xsl:template>

  <xsl:template match="colophon">
   <fo:page-sequence master-reference="colophon-page" >
     <fo:flow flow-name="xsl-region-body" hyphenate="true" hyphenation-remain-character-count="3" hyphenation-push-character-count="3" hyphenation-ladder-count="1" >
        <fo:block id="{@id}" page-break-before="always" margin-top="0.5in" margin-left=".5in" margin-right=".5in">
          <xsl:apply-templates/>
        </fo:block>
     </fo:flow>
   </fo:page-sequence>
  </xsl:template>
  
</xsl:stylesheet>
