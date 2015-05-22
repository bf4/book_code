<?xml version="1.0" encoding="utf-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"> 
 
  <xsl:template match="/caution">
    <html>
      <head><title>Caution!</title></head>
      <body>
        <h2>WAIT JUST A SECOND THERE!!!</h2>
        <p> USE EXTREME CAUTION:</p>  
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="paragraph">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="product">
    <b><xsl:apply-templates/></b>
  </xsl:template>
</xsl:stylesheet>
