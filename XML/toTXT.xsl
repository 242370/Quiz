<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="no"/>
    <xsl:template match="/">
        <xsl:value-of select="Music/Author"></xsl:value-of>
        <xsl:text> </xsl:text>
        <xsl:value-of select="Music/Date"></xsl:value-of>
        <xsl:text>&#xD;</xsl:text> <!-- przejście do nowej linii -->
        <xsl:text>Albumy: </xsl:text>
        <xsl:value-of select="Music/Count"/>
        <xsl:text>&#xD;</xsl:text>
        <xsl:for-each select="Music/Works/Work">
            <xsl:call-template name="pad">
                <xsl:with-param name="length" select="45"/>
                <xsl:with-param name="value" select="normalize-space(Title)"/>
            </xsl:call-template>
            <xsl:call-template name="pad">
                <xsl:with-param name="length" select="30"/>
                <xsl:with-param name="value" select="normalize-space(Composer)"/>
            </xsl:call-template>
            <xsl:call-template name="pad">
                <xsl:with-param name="length" select="15"/>
                <xsl:with-param name="value" select="normalize-space(Type)"/>
            </xsl:call-template>
            <xsl:call-template name="pad">
                <xsl:with-param name="length" select="5"/>
                <xsl:with-param name="value" select="normalize-space(Rank)"/>
            </xsl:call-template>
            <xsl:call-template name="pad">
                <xsl:with-param name="length" select="45"/>
                <xsl:with-param name="value" select="normalize-space(URL)"/>
            </xsl:call-template>
            <xsl:text>&#xD;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="pad">
        <xsl:param name="value"/>
        <xsl:param name="length"/>
        <xsl:variable name="padding"
                      select="'                                             '"/>
        <xsl:value-of select="concat($value,substring(substring($padding,1,$length),string-length($value)))"/>
    </xsl:template>
</xsl:stylesheet>