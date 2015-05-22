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
  xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  
  <xsl:template match="/doc">
    <xsl:apply-templates select="chapter"/>
  </xsl:template>
  
  <xsl:template match="chapter">
    <xsl:apply-templates select="p"/>
  </xsl:template>
  
  <xsl:template match="p">
    <xsl:apply-templates select="footnote"/>
  </xsl:template>
  
  <xsl:template match="footnote">
    <xsl:text>I am number </xsl:text>  
    <xsl:value-of select="text()"/>  
    <xsl:text> and my preceding nodes are: 
</xsl:text>  
<xsl:apply-templates select="preceding::*/text() | ancestor::*/text()"/>      
  </xsl:template>
</xsl:stylesheet>
