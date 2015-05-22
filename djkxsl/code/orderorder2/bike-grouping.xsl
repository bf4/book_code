<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes"/>
  <xsl:template match="/bikes">
    <store-models>
      <xsl:apply-templates 
        select="bike[not(preceding-sibling::bike/shop = shop)]"/>  
    </store-models>
  </xsl:template>

  <xsl:template match="bike">
    <xsl:variable name="this-shop">
      <xsl:value-of select="shop"/>
    </xsl:variable>
    <shop>
      <shop-name>
        <xsl:value-of select="shop"/>
      </shop-name>
      <xsl:apply-templates select="." mode="bikelist"/> 
      <xsl:apply-templates 
        select="following-sibling::bike[shop = $this-shop]" mode="bikelist"/>  
    </shop>
  </xsl:template>

  <xsl:template match="bike" mode="bikelist"> 
    <bike>
      <brand>
        <xsl:value-of select="brand"/>
      </brand>
      <model>
        <xsl:value-of select="model"/>
      </model>
      <price>
        <xsl:value-of select="price"/>
      </price>
    </bike>
  </xsl:template>
</xsl:stylesheet>
