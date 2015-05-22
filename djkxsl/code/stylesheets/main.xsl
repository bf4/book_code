<!DOCTYPE stylesheet [
<!ENTITY plaintext SYSTEM "someplain.txt">
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
  xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 
  <xsl:variable name="text">
    <xsl:text>&plaintext;</xsl:text>
  </xsl:variable>

  <xsl:template match="/xhtml">
    <html>
      <head><xsl:value-of select="$text"/></head>
      <body></body>
    </html>
  </xsl:template>
  
  <xsl:template match="section">
         <xsl:apply-templates/>
  </xsl:template>
 
  <xsl:template match="title">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

</xsl:stylesheet>
