<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:variable name="structure" select="/labels/structure"/> <!-- (1) -->
  <xsl:template match="/labels"> 
    <labels>
      <xsl:apply-templates select="language"/>
    </labels>
  </xsl:template>

  <xsl:template match="language">
    <label language="{@lang}">
      <substance>
        <xsl:apply-templates
          select="*[contains(@id,'01') 
          or contains(@id,'02')  
          or contains(@id,'03')]"/>
      </substance>
      <packaging>
        <xsl:apply-templates select="*[contains(@id,'06')  
          or contains(@id,'07')]"/>
      </packaging>
    </label>
  </xsl:template>

  <xsl:template match="instance">
    <xsl:variable name="ref_id">
      <xsl:value-of select="substring-after(@id,'-')"/>
    </xsl:variable>
    <xsl:variable name="element_name">
      <xsl:value-of select="name($structure//*[@ref_id = $ref_id])"/>
    </xsl:variable>

    <xsl:element name="{$element_name}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
