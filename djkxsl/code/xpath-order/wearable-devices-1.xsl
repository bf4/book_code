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
  <xsl:template match="/product-line">
    <html>
      <head><title><xsl:value-of select="@name"/></title></head>
      <body>
        <h1>Our Unique Wearable Products:</h1>
        <ul>
          <xsl:apply-templates select="child::product[position() &lt; 4]"/>  
        </ul>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="product">
    <li><p><xsl:value-of select="."/></p></li>
  </xsl:template>
</xsl:stylesheet>
