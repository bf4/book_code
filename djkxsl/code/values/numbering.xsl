<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/numbers/bignumbers">
  <xsl:for-each select="bignum">
    <xsl:text>
    </xsl:text>
    <xsl:value-of select="substring-before(.,3)"/>
    <xsl:text>E</xsl:text>
    <xsl:value-of select="substring-after(.,3)"/>
    <xsl:text>
    </xsl:text>
  </xsl:for-each>
  <anything xsl:use-attribute-sets=" ">
    
  </anything>
</xsl:template>

</xsl:stylesheet>
