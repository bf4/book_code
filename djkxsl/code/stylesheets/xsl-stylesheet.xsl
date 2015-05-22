<?xml version="1.0" encoding="utf-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
     xmlns:fo="http://www.w3.org/1999/XSL/Format"
     xmlns:myxsl="file://myxsl.prefix" version="1.0">
  <xsl:import href="book.xsl"/>
  <xsl:include href="caution1.xsl"/>
  <xsl:namespace-alias stylesheet-prefix="myxsl" result-prefix="xsl"/>

  <xsl:template match="p">
    <myxsl:template match="{name()}">
      <myxsl:element name="{name()}">
        <xsl:if test="@id">
          <myxsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </myxsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
      </myxsl:element>
    </myxsl:template>
  </xsl:template>
</xsl:stylesheet>
