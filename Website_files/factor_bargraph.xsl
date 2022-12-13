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
                >Percentage of War-time Factors </text>
            <!-- <text x="-75"
                y="-{$max_height div 2}"
                text-anchor="middle" writing-mode="tb" font-size="large">Year Letter was Written</text> -->
            <text x="{$max_width div 2}" y="-{$max_height}" text-anchor="middle"
                font-size="x-large">Percentage of Factors per Letter Written</text>
        </svg>
    </xsl:template>
    
    <!-- ================================================================================================= -->
    <!--             Template for Individual Bars per Letter                                               -->
    <!-- ================================================================================================= -->
    
    <xsl:template match="div">
        <!--Creating a count of each factor per letter, to calculcate percentages.-->
        <xsl:variable name="letter_factors" as="xs:double" select="count(.//factor)"/>
        <xsl:variable name="letter_trauma" as="xs:double" select=".//factor[@type='trauma'] => count()"/>
        <xsl:variable name="letter_battle" as="xs:double" select=".//factor[@type='battle'] => count()"/>
        <xsl:variable name="letter_prep" as="xs:double" select=".//factor[@type='prep'] => count()"/>
        <xsl:variable name="letter_cond" as="xs:double" select=".//factor[@type='conditions'] => count()"/>
        <xsl:variable name="letter_sense" as="xs:double" select=".//factor[@type='sense'] => count()"/>
        
        <!--Position of each letter's bar on the graph: all bars per div will have same position. -->
        <xsl:variable name="y_pos" as="xs:double"
            select="(position()) * ($bar_height + $bar_spacing)"/>
        
        <!--================================================================================================-->
        <!-- Make a rectangle for each percentage                                                           -->
        <!--================================================================================================-->
        
        <!--Lowest level rectangle: it will be the sum of factors (trauma).-->
        <xsl:variable name="trauma_bar" as="xs:double" select="((($letter_trauma+$letter_battle+$letter_prep+$letter_cond+$letter_sense)div $letter_factors)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$trauma_bar}" height="{$bar_height}"
            opacity=".5" fill="red"/>
        <xsl:if test="$letter_trauma > 0">
            <text x="{(($trauma_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_trauma div $letter_factors) *100)"/></text>
        </xsl:if>
        
        <!--Next level rectangle: it will be the sum of factors minus trauma (battle).-->
        <xsl:variable name="battle_bar" as="xs:double" select="((($letter_battle+$letter_prep+$letter_cond+$letter_sense)div $letter_factors)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$battle_bar}" height="{$bar_height}"
            opacity=".5" fill="SaddleBrown"/>
        <xsl:if test="$letter_battle > 0">
            <text x="{(($battle_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_battle div $letter_factors) *100)"/></text>
        </xsl:if>
        
        <!--Next level rectangle: it will be the sum of factors minus trauma and battle (prep).-->
        <xsl:variable name="prep_bar" as="xs:double" select="((($letter_prep+$letter_cond+$letter_sense)div $letter_factors)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$prep_bar}" height="{$bar_height}"
            opacity=".5" fill="DarkBlue"/>
        <xsl:if test="$letter_prep > 0">
            <text x="{(($prep_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_prep div $letter_factors) *100)"/></text>
        </xsl:if> 
        
        <!--Second to last rectangle: it will be the sum of only conditions and sense (conditions).-->
        <xsl:variable name="cond_bar" as="xs:double" select="((($letter_cond+$letter_sense)div $letter_factors)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$cond_bar}" height="{$bar_height}"
            opacity=".5" fill="DarkOliveGreen"/>
        <xsl:if test="$letter_cond > 0">
            <text x="{(($cond_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_cond div $letter_factors) *100)"/></text>
        </xsl:if> 
        
        <!--Last rectangle: it will be only the count of sense (sense).-->
        <xsl:variable name="sense_bar" as="xs:double" select="(($letter_sense div $letter_factors)*100*$x_scale)"/>
        <rect x=" 0" y="-{$y_pos}"
            width="{$sense_bar}" height="{$bar_height}"
            opacity=".5" fill="DarkGoldenrod"/>
        <xsl:if test="$letter_sense > 0">
            <text x="{(($sense_bar)-20)}" y="-{$y_pos -12}" text-anchor="end" dominant-baseline="middle">
                <xsl:value-of select="round(($letter_sense div $letter_factors) *100)"/></text>
        </xsl:if> 
        
        <!--Print the date of letter written to left of bar, in lieu of a y axis title. -->
        <text x="-80" y="-{$y_pos -15}" fill="black"><xsl:value-of select=".//date/@when"/></text>
        
    </xsl:template>
</xsl:stylesheet>