<?xml version="1.0" encoding="utf-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  version="1.0">
  
  <xsl:template match="/book">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="publisher">
    <xsl:variable name="publisher_ref">
      <xsl:value-of select="@ref"/>
    </xsl:variable>
    
    <xsl:for-each select="//bibliography/publishers/house[@xml:id = $publisher_ref]">
      <xsl:value-of select="name"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="address"/>
    </xsl:for-each>
    
  </xsl:template>
  
  <xsl:template match="text()"/>
  
  
</xsl:stylesheet>
