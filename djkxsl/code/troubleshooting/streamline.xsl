<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="xml"/>
  <xsl:template name="word-swapper">
    <xsl:param name="old-word"/>
    <xsl:param name="new-word"/>
    <xsl:param name="our-string"/>
    <xsl:param name="new-string"/>
    <xsl:param name="count" select="0"/>

    <xsl:message>Count: <xsl:value-of select="$count"/></xsl:message>

    <xsl:choose>
      <xsl:when test="contains($our-string, $old-word)">
        <xsl:call-template name="word-swapper">
          <xsl:with-param name="old-word"/>
          <xsl:with-param name="new-word"/>
          <xsl:with-param name="our-string"/>
          <xsl:with-param name="new-string"/>
          <xsl:with-param name="count" select="0"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="coordinates">
    <xsl:for-each select="ancestor-or-self::*">
      <xsl:text> </xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text>(</xsl:text>
      <xsl:value-of select="count(preceding-sibling::*) + 1"/>
      <xsl:text>):</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/accounts">
    <xsl:variable name="new-id">
      <xsl:call-template name="id-gen"/>
    </xsl:variable>
    <xsl:message>
      <xsl:copy-of select="$new-id"/>
      <xsl:call-template name="coordinates"/>
    </xsl:message>
    <accounts id="{$new-id}">
      <xsl:apply-templates/>
    </accounts>
    <xsl:value-of select="$new-id"/>
  </xsl:template>

  <xsl:template name="id-gen">
    <xsl:comment>I'm a little comment.</xsl:comment>
    <xsl:value-of select="concat('book-id-',generate-id())"/>
  </xsl:template>
  <xsl:template match="account">
    <xsl:element name="account">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:value-of select="name/first"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="name/middle"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="name/last"/>
      </xsl:attribute>
      <xsl:apply-templates select="transactions"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="transactions">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="transaction">
    <xsl:element name="transaction">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="date">
    <xsl:variable name="new-id">
      <xsl:call-template name="id-gen"/>
    </xsl:variable>
    <xsl:message>
      <xsl:copy-of select="$new-id"/>
      <xsl:call-template name="coordinates"/>
    </xsl:message>

    <xsl:element name="date">
      <xsl:value-of select="month"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="day"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="time"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="amount">
    <xsl:element name="amount">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="product">
    <xsl:element name="product">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
