<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!--Attempting to do a batch transformation of the entire collection of letters, as of 11/29 -->
    <!--Creates a variable for each letter as a document node, from the entire collection of letters -->
    <xsl:variable name="wwi_letter" as="document-node()+"
        select="collection('../XML_Markup/?select=*.xml')"/>

    <!--Document node template: currently shows all letters in the series but later javascript will show/hide.-->

    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Letters</title>
                <link rel="Stylesheet" type="text/css" href="letters.css"/>
                <script src="website_js.js"/>
            </head>
            <body>
                <xsl:comment>#include virtual="header.xhtml" </xsl:comment>
                <ul class="letters">
                    <li class="dropdown">
                        <a>1915</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID1">Kerr</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">1916</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID13">Ashton</a>
                            <a class="dd" id="ID20">Beaumont</a>
                            <a class="dd" id="ID19">Bullen</a>
                            <a class="dd" id="ID4">Cronin</a>
                            <a class="dd" id="ID16">Davies</a>
                            <a class="dd" id="ID7">Davis</a>
                            <a class="dd" id="ID2">Douce</a>
                            <a class="dd" id="ID21">Frost (Aug)</a>
                            <a class="dd" id="ID26">Frost (Nov)</a>
                            <a class="dd" id="ID8">Mansbridge</a>
                            <a class="dd" id="ID15">McGrath (June)</a>
                            <a class="dd" id="ID18">McGrath (July)</a>
                            <a class="dd" id="ID22">McGrath (Sept)</a>
                            <a class="dd" id="ID23">McGrath (Oct)</a>
                            <a class="dd" id="ID27">McGrath (Nov)</a>
                            <a class="dd" id="ID10">Pond</a>
                            <a class="dd" id="ID3">Priestley</a>
                            <a class="dd" id="ID12">Robertson</a>
                            <a class="dd" id="ID5">Russell</a>
                            <a class="dd" id="ID25">Smith, Arthur</a>
                            <a class="dd" id="ID9">Smith, Sidney</a>
                            <a class="dd" id="ID17">Turner</a>
                            <a class="dd" id="ID11">Williams</a>
                            <a class="dd" id="ID24">Wilson</a>
                            <a class="dd" id="ID14">Witt</a>
                            <a class="dd" id="ID6">Woodhams</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">1917</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID38">Andrews</a>
                            <a class="dd" id="ID31">Beaumont</a>
                            <a class="dd" id="ID37">Board</a>
                            <a class="dd" id="ID39">Hart</a>
                            <a class="dd" id="ID36">Kibblewhite</a>
                            <a class="dd" id="ID29">Marsh</a>
                            <a class="dd" id="ID30">McGrath</a>
                            <a class="dd" id="ID32">Morris</a>
                            <a class="dd" id="ID33">Secrett</a>
                            <a class="dd" id="ID34">Sharland</a>
                            <a class="dd" id="ID28">Skilling</a>
                            <a class="dd" id="ID35">Staley</a>
                            <a class="dd" id="ID40">Wiggs</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">1918</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID42">Hyam</a>
                            <a class="dd" id="ID46">Inglis</a>
                            <a class="dd" id="ID41">Staley (Apr)</a>
                            <a class="dd" id="ID43">Staley (May)</a>
                            <a class="dd" id="ID44">Staley (Jun)</a>
                            <a class="dd" id="ID45">Staley (July)</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">1919</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID47">Lambert</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">1920</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID48">Monaghan</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <a class="dropbtn">Unknown</a>
                        <div class="dropdown-content">
                            <a class="dd" id="ID49">Smith</a>
                        </div>
                    </li>
                </ul>

                <div class="parent_container3">

                    <div class="parent_container4">
                        <div class="sidebar">
                            <h1 class="sidebar">Legend:</h1>
                            <h2>Emotion:</h2>
                            <ul class="sidebar" style="list-style-type:square">
                                <li class="positive">Positive</li>
                                <li class="negative">Negative</li>
                                <li class="neutral">Neutral</li>
                            </ul>
                            <h2>Factors:</h2>
                            <ul class="sidebar" style="list-style-type:square">
                                <li class="trauma">Trauma</li>
                                <li class="battle">Battle</li>
                                <li class="prep">Prep</li>
                                <li class="conditions">Conditions</li>
                                <li class="sense">Sense</li>
                            </ul>
                        </div>
                        <!--end of sidebar-->

                        <img class="sidebar" src="../Images_and_Source_Material/Highland_Trench.jpg"
                            alt="Highland Trench"/>

                        <img class="sidebar"
                            src="../Images_and_Source_Material/Longueval_France.jpg"
                            alt="Longueval France"/>
                    </div>
                    <!--End of parent container 4 -->
                    <div class="parent_container5">
                        <!-- =========================================== -->
                        <!-- Transform individual letters                -->
                        <!-- =========================================== -->
                        <xsl:apply-templates select="$wwi_letter//div">
                            <xsl:sort select="opener/dateline/date/@when"/>
                        </xsl:apply-templates>
                    </div>
                    <!--end of parent_container 5 (the column of letters)-->
                </div>
                <!-- end of parent_container 3 (the whole page) -->

            </body>
        </html>
    </xsl:template>

    <!-- Template to match the new corpus, and for each -->
    <xsl:template match="$wwi_letter">
        <xsl:apply-templates/>
    </xsl:template>

    <!--Template for processing divs, which are the individual letters in this series, and in the eventual corpus.-->
    <!--I specified type here just in case we later use divs for anything else.-->
    <xsl:template match="div[@type = 'letter']">
        <div class="special_container" id="{concat('letter', position())}">

            <section>
                <!--Rev2 - Adding a header component to include dateline and salutation, to mirror the footer component.-->

                <xsl:apply-templates/>
            </section>
        </div>
    </xsl:template>

    <!--Rev2 - processing info element, which will be turned off using javascript later. -->
    <xsl:template match="info">
        <p>
            <xsl:apply-templates/>
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

    <xsl:template match="postscript">
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
