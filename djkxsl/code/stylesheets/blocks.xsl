<?xml version="1.0" encoding="utf-8"?>
<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="2.0">

  <xsl:template match="p">
    <fo:block line-height="{$line.height}">
      <xsl:choose>
        <xsl:when test="parent::li">
          <xsl:attribute name="text-align">left</xsl:attribute>
        </xsl:when>
        <xsl:when test="not(parent::poem) and not(ancestor::colophon)">
        <!--  <xsl:attribute name="padding-top">3pt</xsl:attribute>
          <xsl:attribute name="padding-bottom">3pt</xsl:attribute> --> 
          <xsl:attribute name="text-align">justify</xsl:attribute>
            <xsl:attribute name="text-indent">1.5em</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <!--  <xsl:if test="parent::poem">
       <xsl:attribute name="white-space">pre</xsl:attribute> </xsl:if>--> 
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="separator">
    <fo:block text-align="center" padding-top="9pt" padding-bottom="9pt">
      <fo:external-graphic src="url(C:/peloria/books/tbsn/graphics/separator.png)" content-width="50%"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="poem">
    <fo:block margin-top="6pt" margin-left="2em" margin-bottom="6pt" id="{@id}">
      <xsl:if test="ancestor::part and not(ancestor::chapter)">
        <xsl:attribute name="page-break-before">always</xsl:attribute>
      </xsl:if>
      <xsl:if test="ancestor::chapter or ancestor::appendix">
        <xsl:attribute name="font-style">italic</xsl:attribute>
      </xsl:if>
      <xsl:if test="@align">
        <xsl:attribute name="text-align">
          <xsl:value-of select="@align"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="title">
    <fo:block margin-bottom="6pt">
      <xsl:choose>
        <xsl:when test="parent::chapter or parent::appendix">
          <xsl:attribute name="text-align">center</xsl:attribute>
          <xsl:attribute name="padding-bottom">18pt</xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:value-of select="$chaptertitlefontsize"/>
          </xsl:attribute>
          <xsl:attribute name="font-family">
            <xsl:value-of select="$chaptertitlefont"/>
          </xsl:attribute>
          <fo:block font-size="{$chapternumberfontsize}" padding-bottom="30pt">
            <xsl:number count="chapter" from="book" format="1"/>
          </fo:block>
        </xsl:when>
        <xsl:when test="parent::poem or parent::recipe">
          <xsl:attribute name="font-style">normal</xsl:attribute>
          <xsl:attribute name="font-family">
            <xsl:value-of select="$poemtitlefont"/>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:value-of select="$poemtitlefontsize"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id(parent::poem)"/>
          </xsl:attribute>
          <xsl:attribute name="hyphenate">false</xsl:attribute>
          <xsl:attribute name="color">rgb(0, 0, 100)</xsl:attribute>
        </xsl:when>
        <xsl:when test="parent::figure">
          <xsl:attribute name="font-weight">bold</xsl:attribute>
          <xsl:attribute name="font-family">
            <xsl:value-of select="$othertitlefont"/>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:value-of select="$othertitlefontsize"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="generate-id(parent::recipe)"/>
          </xsl:attribute>
          <xsl:attribute name="hyphenate">false</xsl:attribute>
          <xsl:attribute name="color">rgb(0, 0, 100)</xsl:attribute>
          <xsl:attribute name="text-align">center</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="font-weight">bold</xsl:attribute>
          <xsl:attribute name="font-family">
            <xsl:value-of select="$othertitlefont"/>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:value-of select="$othertitlefontsize"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="byline">
    <fo:block font-style="italic" margin-top="6pt">
      <xsl:text>&#x2014;</xsl:text>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="figure">
    <fo:block id="{@id}">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="table">
    <fo:block id="{@id}">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="quote">
    <fo:block id="{@id}">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="image">
    <fo:block text-align="{@align}">
      <fo:external-graphic content-width="{@width}">
        <xsl:attribute name="src">
          <xsl:text>url(C:/peloria/books/</xsl:text>
          <xsl:value-of select="//book/bookmeta/bookid"/>
          <xsl:text>/graphics/</xsl:text>
          <xsl:value-of select="@src"/>
          <xsl:text>)</xsl:text>
        </xsl:attribute>
      </fo:external-graphic>
    </fo:block>
  </xsl:template>

  <xsl:template match="ul">
    <fo:list-block provisional-distance-between-starts="0.25in" provisional-label-separation="0.1in"
      space-before="3pt" space-after="3pt">
      <xsl:if test="not(ancestor::recipe)"><xsl:attribute name="start-indent">1.5em</xsl:attribute></xsl:if>
      <xsl:for-each select="li">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block text-align="left"  font-size="14pt">&#x2022;</fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block text-align="justify">
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="ol">
    <fo:list-block provisional-distance-between-starts="0.25in" provisional-label-separation="0.1in"
      space-before="3pt" space-after="3pt">
     <xsl:if test="not(ancestor::recipe)"><xsl:attribute name="start-indent">1.5em</xsl:attribute></xsl:if>
      <xsl:for-each select="li">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block text-align="left" padding-top="2pt">
              <xsl:number select="." format="1."/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block text-align="justify">
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="recipe">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ingredients">
  <fo:block font-style="italic">Ingredients:</fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="instructions"> 
    <fo:block font-style="italic">Instructions:</fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="title2">
    <fo:block margin-top="11pt" margin-bottom="3pt" font-style="italic">
          <xsl:attribute name="font-family">
            <xsl:value-of select="$othertitlefont"/>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:value-of select="'12pt'"/>
          </xsl:attribute>
      <xsl:apply-templates/>
    </fo:block>    
  </xsl:template>

</xsl:stylesheet>
