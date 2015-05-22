<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/customer">
    <customer>
      <name><xsl:value-of select="@name"/></name>
      <address><xsl:apply-templates/></address>
    </customer>
  </xsl:template>

  <xsl:template match="street">
    <street><xsl:value-of select="."/></street>
  </xsl:template>
  
  <xsl:template match="city">
    <city><xsl:value-of select="."/></city>
  </xsl:template>
  
  <xsl:template match="state">
    <state><xsl:value-of select="."/></state>
  </xsl:template>
  
  <xsl:template match="zip">
    <zip><xsl:value-of select="."/></zip>
  </xsl:template>
</xsl:stylesheet>