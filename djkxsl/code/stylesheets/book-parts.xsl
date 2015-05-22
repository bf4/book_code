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
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
  
 <xsl:preserve-space elements="code"/>
  
  <xsl:template match="p">
    <fo:block>
      <xsl:choose>
        <xsl:when test="parent::li | parent::poem">
          <xsl:attribute name="text-align">left</xsl:attribute>
        </xsl:when>
        <xsl:when test="parent::colophon">center</xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="text-align">justify</xsl:attribute>
          <xsl:attribute name="text-indent">1.5em</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
       <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="code">
    <fo:block white-space-treatment="preserve" 
      linefeed-treatment="preserve">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
