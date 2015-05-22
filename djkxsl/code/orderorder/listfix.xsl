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
  <xsl:template match="/document">
    <chapter>
      <xsl:apply-templates/>
    </chapter>
  </xsl:template>
  
  <xsl:template match="chapter">
    
              <section>
                <title>
                  <xsl:value-of select="p[1]"/>
                </title>
                <xsl:apply-templates/>
              </section>
            
  </xsl:template>
  
    <xsl:template match="*[not(position() = 1)]"><xsl:text>
</xsl:text>
   PARA!
  <xsl:apply-templates/>
   </xsl:template>
  
   <xsl:template match="note">
    NOTE!
  </xsl:template>
  
  <xsl:template match="tree">
    TREE!
  </xsl:template>
  
  
  

 </xsl:stylesheet>