<!--
 ! Excerpted from "XSL Jumpstarter",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/djkxsl for more book information.
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon" version="1.0"> 
  <xsl:template match="/report/fantasy-league/team">
    <saxon:output href="output-dir/{@name}.html" method="html"> 
      <html>
        <head><xsl:value-of select="@name"/></head>
        <body>
          <h1><xsl:value-of select="@name"/></h1>
          <h2>Hitters</h2>
          <xsl:for-each select="player">
            <xsl:variable name="player-name">
              <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:value-of select="$player-name"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@position"/>
            <xsl:for-each select="/report/mlb-player/player[@name = $player-name]">
              (create the stat line for each player here)
            </xsl:for-each>
          </xsl:for-each>
          <xsl:for-each select="pitcher">
            (lather, rinse, repeat...)
          </xsl:for-each>
        </body>
      </html>
    </saxon:output>
  </xsl:template>
</xsl:stylesheet>
