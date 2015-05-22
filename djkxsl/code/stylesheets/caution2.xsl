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
  version="1.0">
  <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" 
    indent="yes"/>   
<xsl:template match="note[@type='caution']">
  <html>
    <head><title>Caution!</title></head>
    <body>
      <h2>WAIT JUST A SECOND THERE!!!</h2>
      <p>
        <xsl:text>USE EXTREME CAUTION: </xsl:text>
        <xsl:apply-templates select="p[1]"/>
      </p>
    <xsl:apply-templates select="p[not(position() = 1)]"/>
    </body>
<xsl:text>
</xsl:text>
  </html>
</xsl:template>

<xsl:template match="p[not(position() = 1)]">
  <p><xsl:apply-templates/></p>
</xsl:template>

</xsl:stylesheet>
