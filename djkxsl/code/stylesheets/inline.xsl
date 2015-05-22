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
 
 <xsl:template match="text()">
   <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="i">
   <fo:inline font-style="italic">
     <xsl:apply-templates/>
   </fo:inline>
 </xsl:template> 
  
<xsl:template match="b">
   <fo:inline font-weight="bold">
     <xsl:apply-templates/>
   </fo:inline>
</xsl:template> 
  
<xsl:template match="u">
   <fo:inline text-decoration="underline">
     <xsl:apply-templates/>
   </fo:inline>
</xsl:template> 
  
<xsl:template match="q">
   <xsl:text>&#x201C;</xsl:text>
     <xsl:apply-templates/>
   <xsl:text>&#x201D;</xsl:text>  
</xsl:template> 
  
<xsl:template match="xref">
     <fo:basic-link internal-destination="{@to}" font-style="italic" color="blue"> 
       <xsl:apply-templates/>
     </fo:basic-link> 
</xsl:template> 
  
<xsl:template match="keep">
  <fo:inline keep-together.within-line="always" hyphenate="false"><xsl:apply-templates/></fo:inline>
</xsl:template>
  
<xsl:template match="break">
  
</xsl:template>

<xsl:template match="footnote">
   <fo:footnote>
     <fo:inline baseline-shift="super" font-size="6.5pt"><xsl:number count="footnote" level="any" from="book"/></fo:inline>
     <fo:footnote-body><fo:block font-size="8.5pt" line-height="105%"> <fo:inline space-end="1em"><xsl:number count="footnote" level="any" from="book"/>.</fo:inline>
       <xsl:for-each select="child::*[1]">
         <xsl:apply-templates/>
       </xsl:for-each> </fo:block>
       <xsl:apply-templates select="child::*[preceding-sibling::*]"/>
     </fo:footnote-body>
   </fo:footnote>
</xsl:template>
 
</xsl:stylesheet>
