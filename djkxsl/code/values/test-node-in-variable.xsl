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
  
  <xsl:template match="/ | * | @*">  
    <xsl:copy>
      <xsl:apply-templates select=" * | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="instance">
    <xsl:variable name="instance_id" select="@id"/>
    <xsl:if test="$structure//*[@ref_id = $instance_id]"> 
      <xsl:copy>
        <xsl:apply-templates/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
