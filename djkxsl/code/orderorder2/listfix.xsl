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
      <xsl:apply-templates select="p[@font-size='14pt']"/>
      <xsl:apply-templates select="p[@font-size='10pt' 
        and not(preceding-sibling::p[@font-size='12pt'])]"/>
      <xsl:apply-templates select="p[@font-size='12pt']"/> 
    </chapter>
  </xsl:template>

  <xsl:template match="p[@font-size='14pt']">
      <title>
        <xsl:apply-templates/>
      </title>
  </xsl:template>
  
  <xsl:template match="p[@font-size='10pt' 
    and not(preceding-sibling::p[@font-size='12pt'])]">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="p[@font-size='12pt']"> 
    <xsl:variable name="id">
      <xsl:value-of select="generate-id(.)"/>
    </xsl:variable>
    <section1>
      <title>
        <xsl:apply-templates/>
      </title>
      <xsl:apply-templates select="following-sibling::p[@font-size='10pt' and
        not(preceding-sibling::p[@font-size='12pt' 
        and preceding-sibling::p[generate-id() = $id]])]"/>   
    </section1>
  </xsl:template>
 
 <xsl:template match="p[@font-size='10pt' 
   and preceding-sibling::p[@font-size='12pt']]">  
   <p>
     <xsl:apply-templates/>
   </p>
 </xsl:template>
</xsl:stylesheet>
