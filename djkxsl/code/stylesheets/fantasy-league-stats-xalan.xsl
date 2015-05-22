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
  xmlns:redirect=" http://xml.apache.org/xalan/redirect" version="1.0"> 

<xsl:template match="/report/fantasy-league/team">
 <redirect:write select="concat('output-dir/',@name,'.html'" file="no-team.html"> 
   ...
   [more XSLT code goes here]
   ...
 </redirect:write>
</xsl:template>
</xsl:stylesheet>
