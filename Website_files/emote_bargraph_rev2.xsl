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
    <xsl:variable name="total_letters" as="xs:double" select="count(//div)"/>
    <xsl:variable name="x_scale" as="xs:double" select="5"/>
    <xsl:variable name="max_width" as="xs:double" select="($x_scale * 100) + 50"/>
    <xsl:variable name="max_height" as="xs:double"
        select="count(//div) * ($bar_height + $bar_spacing) +50"/>
   

    <!-- ================================================================================================= -->
    <!--             Templates for SVG Stacked Bar Charts                                                  -->
    <!-- ================================================================================================= -->
    <xsl:template match="/">
        <svg height="{$max_height +50}" width="{$max_width +50}"
            viewBox="-150, -{$max_height +100}, {$max_width+200}, {$max_height+ 375}">


           <xsl:apply-templates select="//div">
               <xsl:sort select="./opener//date/@when"/>
           </xsl:apply-templates> 
            
            <!-- ========================================================== -->
            <!-- X and Y axes, written after <xsl:apply-templates>          -->
            <!-- to ensure bars do not overlap                              -->
            <!-- ========================================================== -->
            <line x1="0" y1="0" x2="0" y2="-{$max_height}" stroke="black"/>
            <line x1="0" y1="0" x2="{$max_width}" y2="0" stroke="black"/>
             
            <!-- ========================================================== -->
            <!-- Percentage markers, with % under the x-axis                -->
            <!-- ========================================================== -->
            <xsl:for-each select="0 to 4">
                <xsl:variable name="perc_line" as="xs:double" select=". * 25 * $x_scale"/>
                <line x1="{$perc_line}" y1="0" x2="{$perc_line}" y2="10" stroke="black"/>
                <text x="{$perc_line}" y="20" text-anchor="end" dominant-baseline="central"><xsl:value-of select=". *25"/><xsl:text>%</xsl:text></text>
            </xsl:for-each>
            
            <!-- ========================================================== -->
            <!-- Axis labels and Graph Title                                -->
            <!-- ========================================================== -->
            <text x="{$max_width div 2}" y="50" text-anchor="middle" font-size="large"
                >Percentage of Emotive Statements </text>
           <!-- <text x="-75"
                y="-{$max_height div 2}"
                text-anchor="middle" writing-mode="tb" font-size="large">Year Letter was Written</text> -->
            <text x="{$max_width div 2}" y="-{$max_height}" text-anchor="middle"
                font-size="x-large">Percentage of Emotive Statements per Letter Written</text>
        </svg>
    </xsl:template>


    <!-- ================================================================================================= -->
    <!--             Template for Individual Bars per Letter                                               -->
    <!-- ================================================================================================= -->

    <xsl:template match="div">
    <!--Creating a count of each emote per letter, to calculcate percentages.-->
    <xsl:variable name="letter_emotes" as="xs:double" select="count(.//emote)"/>
    <xsl:variable name="letter_pos" as="xs:double" select=".//emote[@type='positive'] => count()"/>
    <xsl:variable name="letter_neu" as="xs:double" select=".//emote[@type='neutral'] => count()"/>
    <xsl:variable name="letter_neg" as="xs:double" select=".//emote[@type='negative'] => count()"/>
    <!--Position of each letter's bar on the graph: all bars per div will have same position. -->
    <xsl:variable name="y_pos" as="xs:double"
            select="(position()) * ($bar_height + $bar_spacing)"/>
        
        <!--Conditional statement that makes horizontal lines between year groups -->
        <!--This still generates too many lines ... need to debug this or else get rid of the lines entirely. -->
       <!-- <xsl:if test=".//date/@when ! substring-before(.,'-') != ./following-sibling::div[1]//date/@when ! substring-before(.,'-')">
            <line x1="0" x2="{$max_width}" y1="-{$y_pos+5}" y2="-{$y_pos+5}" stroke="black" stroke-dasharray="2"/>
            <text x="-5" y="-{$y_pos+5}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select=".//date/@when ! substring-before(.,'-')"/>
            </text>
        </xsl:if> -->
    
    <!--====================================================================================================-->
    <!-- Make a rectangle for each percentage                                                               -->
    <!--====================================================================================================-->
        
        <!--Lowest level rectangle: it will be the sum of all three percentages (positive).-->
        <xsl:variable name="pos_bar" as="xs:double" select="((($letter_pos + $letter_neu +$letter_neg)div $letter_emotes)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$pos_bar}" height="{$bar_height}"
            opacity="1" fill="#3CB371"/>
        <xsl:if test="$letter_pos > 0">
        <text x="{(($pos_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
            <xsl:value-of select="round(($letter_pos div $letter_emotes) *100)"/></text>
        </xsl:if>
        
        <!--Second level rectangle: will be the sum of neutral and negative percentages (neutral).-->
        <xsl:variable name="neu_bar" as="xs:double" select="((($letter_neu +$letter_neg)div $letter_emotes)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{($neu_bar)}" height="{$bar_height}"
            opacity="1" fill="#FFD700"/>
        <xsl:if test="$letter_neu > 0">
            <text x="{(($neu_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_neu div $letter_emotes) *100)"/></text>
        </xsl:if>
        
        <!--Third level rectangle: will be only the negative percentages, leaving neutral and positive portions uncovered.-->
        <xsl:variable name="neg_bar" as="xs:double" select="(($letter_neg div $letter_emotes)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$neg_bar}" height="{$bar_height}"
            opacity="1" fill="#FF6347"/>
        <xsl:if test="$letter_neg > 0">
            <text x="{(($neg_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_neg div $letter_emotes) *100)"/></text>
        </xsl:if>
        
        <!--Print the date of letter written to left of bar, in lieu of a y axis title. -->
        <text x="-80" y="-{$y_pos -15}" fill="black"><xsl:value-of select=".//date/@when"/></text>
        
       
    </xsl:template>

    


</xsl:stylesheet>
