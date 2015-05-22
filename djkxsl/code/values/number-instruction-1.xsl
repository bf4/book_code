<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
  <xsl:template match=" / | * ">
    <xsl:apply-templates select=" * "/>
  </xsl:template>
  <xsl:template match="section | example | codeline">
    <xsl:text>
    </xsl:text><xsl:number level="multiple" from="/" 
      count="section | example | codeline" format="1.1.a.1."/>
    <xsl:apply-templates select=" * "/>
  </xsl:template>
</xsl:stylesheet>
