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
  <xsl:key name="bike-brand" match="bike" use="brand"/>

  <xsl:template match="/bikes">
    <store-models>
      <xsl:for-each 
        select="bike[generate-id() = generate-id(key('bike-brand', brand)[1])]">   
        <xsl:sort/>
        <h1>
          <xsl:value-of select="brand"/>
        </h1>
        <ul>
          <xsl:for-each select="key('bike-brand',brand)"> 
            <xsl:sort select="model"/>
            <li><xsl:value-of select="model"/>, <xsl:value-of select="shop"/></li> 
          </xsl:for-each>
        </ul>
      </xsl:for-each>
    </store-models>
  </xsl:template>
</xsl:stylesheet>
