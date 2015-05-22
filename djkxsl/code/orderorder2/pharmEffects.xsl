<?xml version="1.0" encoding="UTF-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <xsl:template match="/substanceEffects">
    <html>
      <head></head>
      <body>
        <h1>Pharmaceutical Substances and Their Effects</h1>
        <xsl:apply-templates select="substances/substance"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="substances/substance">
    <h2><xsl:value-of select="invented_name"/></h2> 
    <p><xsl:value-of select="description"/></p>
    <h3><xsl:text>Side Effects</xsl:text></h3>
    <ul><xsl:apply-templates select="sideEffects/effect"/></ul>
  </xsl:template>
  
  <xsl:template match="effect">
    <xsl:variable name="ref_code">
      <xsl:value-of select="@ref"/>
    </xsl:variable>
    <li>
    <xsl:value-of 
     select="/substanceEffects/
     sideEffects//effect[@reference = $ref_code]"/>   
    </li>
  </xsl:template>
  
  <xsl:template match="
    a 
    | b
    [contains(.,
    'yes'
    )]
    [@id 
    = 2]"
  />
</xsl:stylesheet>