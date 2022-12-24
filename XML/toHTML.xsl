<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            <head>
                <title>muuuuSIC</title>
                <link rel="stylesheet" href="html.css"/>
            </head>
            <body>
                <div class="Header">
                    <h2><img src="music-notes.png" alt="Logo" title="Logo" height="100" width="60"/></h2>
                    <h4>
                        <xsl:value-of select="Music/Author"/><br/>
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
                                <td><xsl:value-of select="Title"/></td>
                                <td><xsl:value-of select="Composer"/></td>
                                <td><xsl:value-of select="Type"/></td>
                                <td><xsl:value-of select="Rank"/></td>
                                <td><a href="{URL}" title="Click here to listen">Link to the album on YouTube platform</a></td>
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
                                <td><xsl:value-of select="Type"/></td>
                                <td><xsl:value-of select="Count"/></td>
                                <td><xsl:value-of select="Ranks/Min"/></td>
                                <td><xsl:value-of select="Ranks/Max"/></td>
                                <td><xsl:value-of select="Ranks/Avg"/></td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td>Total</td>
                            <td><xsl:value-of select="Music/Count"/></td>
                            <td><xsl:value-of select="Music/Ranks/Min"/></td>
                            <td><xsl:value-of select="Music/Ranks/Max"/></td>
                            <td><xsl:value-of select="Music/Ranks/Avg"/></td>
                        </tr>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

