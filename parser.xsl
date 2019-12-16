<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">   
<xsl:output method="html" indent="no" encoding="utf-8" />
<xsl:template match="*">	
   <html>
   <body>
		<xsl:value-of select="//h1[1]/../descendant-or-self::*"/>
   </body>
   </html>	
</xsl:template>


</xsl:stylesheet>
