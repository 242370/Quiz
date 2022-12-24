<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="/">
        <html xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>muuuuSIC</title>
                <link rel="stylesheet" href="html.css"/>
            </head>
            <body>
                <div class="Header">
                    <h2>
                        <img src="music-notes.png" alt="Logo" title="Logo" height="100" width="auto"/>
                    </h2>
                    <h4>
                        <xsl:value-of select="Music/Author"></xsl:value-of>
                        <br/>
                        <xsl:value-of select="Music/Date"></xsl:value-of>
                    </h4>
                </div>
                <div class="Liszt">
                    <h1>List of composers' works</h1>
                    <table>
                        <tr> <!-- table row -->
                            <th>Title</th>
                            <th>Composer</th>
                            <th>Type</th>
                            <th>Rank</th>
                            <th>URL</th>
                        </tr>
                        <xsl:for-each select="Music/Works/Work">
                            <tr>
                                <td>
                                    <xsl:value-of select="Title"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Composer"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Type"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Rank"/>
                                    <xsl:variable name="value" select="Rank"/>
                                    <xsl:variable name="colour">
                                        <xsl:choose>
                                            <xsl:when test="Rank &lt;= 1"> <!-- less than equal -->
                                                <xsl:value-of select="'black'"/>
                                            </xsl:when>
                                            <xsl:when test="Rank &lt;= 2">
                                                <xsl:value-of select="'red'"/>
                                            </xsl:when>
                                            <xsl:when test="Rank &lt;= 3">
                                                <xsl:value-of select="'orange'"/>
                                            </xsl:when>
                                            <xsl:when test="Rank &lt;= 4">
                                                <xsl:value-of select="'yellow'"/>
                                            </xsl:when>
                                            <xsl:when test="Rank &lt;= 5">
                                                <xsl:value-of select="'green'"/>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <svg style="background-color:white;float:right" width="150" height="20"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <rect x="5px" y="5px" width="{$value*30}" height="10px" fill="{$colour}">
                                            <animate attributeName="width" from="0" to="{$value*30}" dur="2s"/>
                                        </rect>
                                    </svg>
                                </td>
                                <td>
                                    <a href="{URL}" title="Click here to listen">Link to the album on YouTube platform
                                    </a>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
                <div class="Summary">
                    <h1>Summary</h1>
                    <table>
                        <tr>
                            <th>Type</th>
                            <th>Count</th>
                            <th>The lowest ranking</th>
                            <th>The highest ranking</th>
                            <th>The average ranking</th>
                        </tr>
                        <xsl:for-each select="Music/Types/Type">
                            <tr>
                                <td>
                                    <xsl:value-of select="Type"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Count"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Ranks/Min"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Ranks/Max"/>
                                </td>
                                <td>
                                    <xsl:value-of select="Ranks/Avg"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td>Total</td>
                            <td>
                                <xsl:value-of select="Music/Count"/>
                            </td>
                            <td>
                                <xsl:value-of select="Music/Ranks/Min"/>
                            </td>
                            <td>
                                <xsl:value-of select="Music/Ranks/Max"/>
                            </td>
                            <td>
                                <xsl:value-of select="Music/Ranks/Avg"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="plot">
                    <svg width="100%" height="100%" fill="none"
                         viewBox="0 0 100 40" xmlns="http://www.w3.org/2000/svg">
                        <path d="M 0 0 H 100"></path> <!--Move to length height Horizontal ending-->
                        <path d="M 0 5 H 100"></path>
                        <path d="M 0 10 H 100"></path>
                        <path d="M 0 15 H 100"></path>
                        <path d="M 0 20 H 100"></path>
                        <path d="M 0 25 H 100"></path>
                        <path d="M 0 30 H 100"></path>
                        <xsl:for-each select="Music/Types/Type">
                            <xsl:variable name="value" select="Count"/>
                            <xsl:variable name="index" select="position()"/>
                            <rect x="{20 +$index * 10}" y="{30 - 2 * $value}" width="7" height="{2 * $value}" fill="blue">
                                <animate attributeName="y" from="30" to="{30 - 2 * $value}" dur="2s"/>
                                <animate attributeName="height" from="0" to="{2 * $value}" dur="2s"/>
                            </rect>
                            <text x="{20 +$index * 10}" y="35" fill="white">
                                <xsl:value-of select="Type"/>
                            </text>
                        </xsl:for-each>
                        <xsl:variable name="value" select="Music/Count"/>
                        <rect x="5" y="{30 - 2 * $value}" width="7" height="{2 * $value}" fill="green">
                            <animate attributeName="y" from="30" to="{30 - 2 * $value}" dur="2s"/>
                            <animate attributeName="height" from="0" to="{2 * $value}" dur="2s"/>
                        </rect>
                        <text x="5" y="35" fill="white">
                            Total
                        </text>
                    </svg>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>