<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
<!--Attempting to do a batch transformation of the entire collection of letters, as of 11/29 -->
    
    
<!--Document node template: currently shows all letters in the series but later javascript will show/hide.-->
    
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="letters_workingcopy.css"/>
                <title>Letters Reading View</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

<!--Template for processing divs, which are the individual letters in this series, and in the eventual corpus.-->
<!--I specified type here just in case we later use divs for anything else.-->
    <xsl:template match="div[@type = 'letter']">
        <div class="special_container">
        
        <section>
            <!--Rev2 - Adding a header component to include dateline and salutation, to mirror the footer component.-->
            
            <xsl:apply-templates/>
        </section>
        </div>
    </xsl:template>

    <!--Rev2 - processing info element, which will be turned off using javascript later. -->
    <xsl:template match="info">
        <p>
            <xsl:apply-templates></xsl:apply-templates>
        </p>
    </xsl:template>
    
    <!--This template processes dateline element and should output "PlaceName, 00/00/1918". This will be centered above letter as it is the header.-->
    <!--The object of the choose is to not display any place if the place was an unknown factor, and only show the date.-->
    <xsl:template match="opener">
     <header>  
        <h1>
            <xsl:choose>
                <xsl:when test="dateline/name[contains(., 'unknown')]">
                    <xsl:value-of select="dateline/date"/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:value-of select="dateline/name"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="dateline/date"/>
                </xsl:otherwise>
            </xsl:choose>
        </h1> 
        <xsl:apply-templates select="salute"/> 
     </header> 
    </xsl:template>

<!--Rev 2 - including both dateline and salutation inside of a header element.-->
    <xsl:template match="salute">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<!--Template for paragraphs - left this simple since I was making spans for our inline elements, below.-->
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!--Creates spans for all of the emote types: positive, neutral, and negative.-->
    <xsl:template match="emote">
        <span class="{@type}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<!--Creates spans for all of the factor types: battle, trauma, prep, conditions, and sense.-->
<!--Not all of the factor types appear in this series, so we're getting a limited sample, but they should all have distinct colors.-->
    <xsl:template match="factor">
        <span class="{@type}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<!--Template for closer and postscript are just plain text like the rest of the letter, but I notated the 'p.s.' as text.-->
    <xsl:template match="closer">
        <footer class="letter">
            <xsl:apply-templates/>
        </footer>
    </xsl:template>
<!--It may be a good idea to check if the closing salutation includes a comma or not, and make that look more standardized.-->    
    
    <xsl:template match= "postscript">
        <footer class="letter">
            <xsl:text>p.s.</xsl:text>
            <xsl:apply-templates/>
        </footer>
    </xsl:template>

<!--If I had more time, I wanted to assign a div class so that I could try matching up the letters to links in the html/javascript
        dropdown that Matt made for our reading view page.  I thought about it and wasn't sure how I could create an AVT for Lastname_Year,
        which is what we agreed would be the most useful system. The last names sometimes appear in the info element, so maybe regex could pull them out?
        Just food for thought, in case our project group uses some of this code later. Thanks for any advice. -->
</xsl:stylesheet>
