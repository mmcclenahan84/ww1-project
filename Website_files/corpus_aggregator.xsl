<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Select all XML files within markuip folder -->
    <xsl:variable name="wwi_letters" as="document-node()+"
        select="collection('../XML_Markup/?select=*.xml')"/>
    
    <!-- Create root element for our output and select document nodes -->
    <xsl:template name="xsl:initial-template">
        <letters>
            <xsl:apply-templates select="$wwi_letters"/>
            
        </letters>
    </xsl:template>
    
    <xsl:template match="div">
        <xsl:copy-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>