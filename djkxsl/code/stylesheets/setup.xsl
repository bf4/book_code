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

  <xsl:template name="page-setup">
    <xsl:param name="page.width"/>
    <xsl:param name="page.height"/>
  <xsl:param name="page.margin.top">.5in</xsl:param>
    <xsl:param name="page.margin.bottom">0.6in</xsl:param>
    <xsl:param name="page.margin.inner">1in</xsl:param>
    <xsl:param name="page.margin.outer">1in</xsl:param>
 <!--<xsl:param name="page.margin.inner">0.35in</xsl:param>
    <xsl:param name="page.margin.outer">0.35in</xsl:param>  -->  
    <xsl:param name="body.margin.bottom">0in</xsl:param>
    <xsl:param name="body.margin.top">0.5in</xsl:param>
   
   <fo:layout-master-set>
      <fo:simple-page-master master-name="cover" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="0pt"
        margin-bottom="0pt" margin-left="0pt"
        margin-right="0pt">
        <fo:region-body margin-bottom="0pt" margin-top="0pt"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="title-page" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="copyright" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="toc" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="frontmatter" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>

      <fo:simple-page-master master-name="first-odd" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="first-even" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.outer}"
        margin-right="{$page.margin.inner}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>

      <fo:simple-page-master master-name="body-odd" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.inner}"
        margin-right="{$page.margin.outer}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
        <fo:region-before region-name="xsl-region-before-odd" extent="{$body.margin.top}"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="body-even" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.outer}"
        margin-right="{$page.margin.inner}">
        <fo:region-body margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
        <fo:region-before region-name="xsl-region-before-even" extent="{$body.margin.top}"/>
      </fo:simple-page-master>

       <fo:simple-page-master master-name="colophon-page"  page-width="{$page.width}"
        page-height="{$page.height}" margin-top="{$page.margin.top}"
        margin-bottom="{$page.margin.bottom}" margin-left="{$page.margin.outer}"
        margin-right="{$page.margin.inner}">
          <fo:region-body  margin-bottom="{$body.margin.bottom}" margin-top="{$body.margin.top}"
          region-name="xsl-region-body"/>
       </fo:simple-page-master>
   
     <fo:simple-page-master master-name="blank" page-width="{$page.width}"
        page-height="{$page.height}" margin-top="0pt"
        margin-bottom="0pt" margin-left="0pt"
        margin-right="0pt">
        <fo:region-body margin-bottom="0pt" margin-top="0pt"
          region-name="xsl-region-body"/>
      </fo:simple-page-master>



      <fo:page-sequence-master master-name="body">
      	<fo:repeatable-page-master-alternatives>
	       <fo:conditional-page-master-reference page-position="first" odd-or-even="odd" master-reference="first-odd"/>
	       <fo:conditional-page-master-reference page-position="first" odd-or-even="even" master-reference="first-even"/>
	       <fo:conditional-page-master-reference page-position="rest" odd-or-even="odd" master-reference="body-odd"/>
	       <fo:conditional-page-master-reference page-position="rest" odd-or-even="even" master-reference="body-even"/> 
         <fo:conditional-page-master-reference page-position="last" odd-or-even="odd" master-reference="body-odd"/>
	       <fo:conditional-page-master-reference page-position="last" odd-or-even="even" master-reference="body-even"/>
	      </fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>  

    
    </fo:layout-master-set>
  </xsl:template>

</xsl:stylesheet>
