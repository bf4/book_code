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
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="chapter">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="p">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="footnote">
    <xsl:apply-templates/>
  </xsl:template>  
  
 <xsl:template match="xref">
    <xsl:apply-templates/>
 </xsl:template>
  
  <xsl:template match="note">
    <xsl:text>I'm </xsl:text> 
    <xsl:value-of select="@id"/> 
    <xsl:text> and my chapter's ID is </xsl:text> 
    <xsl:value-of select="ancestor::chapter/@id"/> 
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
  
</xsl:stylesheet>
