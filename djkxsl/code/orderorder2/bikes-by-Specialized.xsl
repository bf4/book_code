<?xml version="1.0" encoding="UTF-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:key name="bike-brand" match="bike" use="brand"/>

<xsl:template match="/bikes">
  <html>
    <body>
      <xsl:apply-templates select="key('bike-brand', 'Specialized')"/>
    </body>
  </html>
</xsl:template>
  
<xsl:template match="bike">
  [template contents]
</xsl:template>
</xsl:stylesheet> 
