<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output method="text"/>
  <xsl:template match="/customer">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="address">
        <xsl:apply-templates select="postalcode"/>
    </xsl:template>
    
    <xsl:template match="postalcode">
       <code>
         <xsl:apply-templates/>
       </code>
    </xsl:template>
    
    <xsl:template match="name">
    </xsl:template>
</xsl:stylesheet>

