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
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

 <xsl:template match="part" mode="toc" >
    <fo:block margin-top="6pt">
      <xsl:value-of select="title"/>
          <xsl:apply-templates mode="toc"/>
    </fo:block>
  </xsl:template>

<xsl:template match="chapter" mode="toc" >
    <fo:block margin-top="6pt">
      <xsl:value-of select="title"/>
          <xsl:apply-templates mode="toc"/>
    </fo:block>
  </xsl:template>

 
 <xsl:template match="poem" mode="toc" >
    <fo:block margin-top="2pt" margin-left="2em" margin-bottom="2pt">
      <fo:basic-link internal-destination="{generate-id(.)}" color="rgb(00,00,255)" text-decoration="underline">
         <xsl:value-of select="title"/>
      </fo:basic-link>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>