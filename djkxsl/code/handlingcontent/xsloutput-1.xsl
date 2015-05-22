<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
  version="1.0">
  <xsl:strip-space elements="p"/>
  <xsl:output method="xml" indent="no" />
   <xsl:template match="note">
    <html>
      <head>
        <title>Caution!</title>
      </head>
      <body>
        <h2>WAIT JUST A SECOND THERE!!!</h2>
        <p>USE EXTREME CAUTION:</p>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
</xsl:stylesheet>
