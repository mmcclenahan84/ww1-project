<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">

    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================================================= -->
    <!--             Definining stylesheet variables                                                       -->
    <!-- ================================================================================================= -->
    <xsl:variable name="bar_height" as="xs:double" select="20"/>
    <xsl:variable name="bar_spacing" as="xs:double" select="$bar_height div 2"/>
    <xsl:variable name="year_spacing" as="xs:double" select="$bar_height"/>
    <xsl:variable name="year_count" as="xs:integer" select="7"/>
    <xsl:variable name="total_letters" as="xs:double" select="count(//div)"/>
    <xsl:variable name="x_scale" as="xs:double" select="5"/>
    <xsl:variable name="max_width" as="xs:double" select="($x_scale * 100) + 50"/>
    <xsl:variable name="max_height" as="xs:double"
        select="count(//div) * ($bar_height + $bar_spacing)"/>
    <!-- ================================================================================================= -->
    <!--Variables for 1st chart are emotes: positive, negative, neutral                                    -->
    <!-- ================================================================================================= -->
    <xsl:variable name="distinct_emo_types" as="xs:string+"
        select="distinct-values(//p/emote/@type)"/>
    <xsl:variable name="distinct_emo_count" as="xs:integer" select="count($distinct_emo_types)"/>



    <!--Variable sequences for the letters written in each year. Convenience Variables!-->
    <xsl:variable name="letters_1915" as="xs:double"
        select="//div//date/@when[starts-with(., '1915')]/ancestor::div =>count()"/>
    <!-- 1 letter -->
    <xsl:variable name="letters_1916" as="xs:double"
        select="//div//date/@when[starts-with(., '1916')]/ancestor::div =>count()"/>
    <!-- 26 letters -->
    <xsl:variable name="letters_1917" as="xs:double"
        select="//div//date/@when[starts-with(., '1917')]/ancestor::div =>count()"/>
    <!-- 13 letters -->
    <xsl:variable name="letters_1918" as="xs:double"
        select="//div//date/@when[starts-with(., '1918')]/ancestor::div => count()"/>
    <!-- 6 letters -->
    <xsl:variable name="letters_1919" as="xs:double"
        select="//div//date/@when[starts-with(., '1919')]/ancestor::div => count()"/>
    <!-- 1 letter -->
    <xsl:variable name="letters_1920" as="xs:double"
        select="//div//date/@when[starts-with(., '1920')]/ancestor::div => count()"/>
    <!-- 1 letter -->
    <xsl:variable name="unknown_years" as="xs:double"
        select="//div//date/@when[contains(., 'unknown')]/ancestor::div => count()"/>
    <!--1 letter -->
    

    <!-- ================================================================================================= -->
    <!--             Templates for SVG Stacked Bar Charts                                                  -->
    <!-- ================================================================================================= -->
    <xsl:template match="/">
        <svg height="{$max_height +50}" width="{$max_width +50}"
            viewBox="-150, -{$max_height +100}, {$max_width+200}, {$max_height+ 375}">


           <xsl:apply-templates select="//div">
               <xsl:sort select="./opener//date/@when"/>
           </xsl:apply-templates> 
            
            <!-- X and Y axes, written after <xsl:apply-templates>          -->
            <!-- to ensure bars do not overlap                              -->
            <!-- ========================================================== -->
            <line x1="0" y1="0" x2="0" y2="-{$max_height}" stroke="black"/>
            <line x1="0" y1="0" x2="{$max_width}" y2="0" stroke="black"/>
                
        </svg>
    </xsl:template>




    <xsl:template match="div">
    <!--Creating a count of each emote per letter, to calculcate percentages.-->
    <xsl:variable name="letter_emotes" as="xs:double" select="count(.//emote)"/>
    <xsl:variable name="letter_pos" as="xs:double" select=".//emote[@type='positive'] => count()"/>
    <xsl:variable name="letter_neu" as="xs:double" select=".//emote[@type='neutral'] => count()"/>
    <xsl:variable name="letter_neg" as="xs:double" select=".//emote[@type='neutral'] => count()"/>
    <!--Position of each letter's bar on the graph: all bars per div will have same position. -->
    <xsl:variable name="y_pos" as="xs:double"
            select="(position()) * ($bar_height + $bar_spacing)"/>
        
        <!--Conditional statement that makes horizontal lines between year groups -->
        <xsl:if test=".//date/@when ! substring-before(.,'-') != ./preceding-sibling::div[1]//date/@when ! substring-before(.,'-')">
            <line x1="0" x2="{$max_width}" y1="-{$y_pos+5}" y2="-{$y_pos+5}" stroke="black" stroke-dasharray="2"/>
            <text x="-5" y="-{$y_pos+5}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select=".//date/@when ! substring-before(.,'-')"/>
            </text>
        </xsl:if>
    
    <!--====================================================================================================-->
    <!-- Make a rectangle for each percentage                                                               -->
    <!--====================================================================================================-->
        <!--Lowest level rectangle: it will be the sum of all three percentages (positive).-->
        <rect x=" 0" y="-{$y_pos}"
            width="{((($letter_pos + $letter_neu+$letter_neg)div $letter_emotes)*100 *$x_scale )}" height="{$bar_height}"
            opacity=".5" fill="green"/>
        <!--Second level rectangle: will be the sum of neutral and negative percentages (neutral).-->
        <rect x=" 0" y="-{$y_pos}"
            width="{((($letter_neu+$letter_neg)div $letter_emotes)*100 *$x_scale )}" height="{$bar_height}"
            opacity=".5" fill="yellow"/>
        <!--Third level rectangle: will be only the negative percentages, leaving neutral and positive portions uncovered.-->
        <rect x=" 0" y="-{$y_pos}"
            width="{(($letter_neg div $letter_emotes)*100 *$x_scale )}" height="{$bar_height}"
            opacity=".5" fill="red"/>
        
        
       
    </xsl:template>

    


</xsl:stylesheet>
