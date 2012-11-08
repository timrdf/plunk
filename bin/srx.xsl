<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:srx="http://www.w3.org/2005/sparql-results#"
               exclude-result-prefixes="">
<xsl:output method="text"/>

<xsl:template match="/">
   <xsl:apply-templates select="//srx:binding[srx:uri]"/>
</xsl:template>

<xsl:template match="srx:binding">
   <xsl:value-of select="concat(srx:uri,$NL)"/> 
</xsl:template>

<xsl:variable name="NL">
<xsl:text>
</xsl:text>
</xsl:variable>

</xsl:transform>
