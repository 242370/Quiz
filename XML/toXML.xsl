<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.Music.org">
    <xsl:key name="Genre" match="/tns:Music/Works/Types/Type" use="@id"/>
    <xsl:key name="Composer" match="/tns:Music/Composers/Composer" use="@id"/>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:element name="Music">
            <xsl:element name="Date">
                <xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
            </xsl:element>
            <xsl:element name="Author"><xsl:value-of select="tns:Music/@author"/></xsl:element>
            <xsl:element name="Works">
                    <xsl:for-each select="tns:Music/Works/Work">
                        <xsl:element name="Work">
                            <xsl:element name="Id">
                                <xsl:value-of select="@id"/>
                            </xsl:element>
                            <xsl:element name="Title">
                                <xsl:value-of select="Name"/>
                            </xsl:element>
                            <xsl:element name="Rank">
                                <xsl:value-of select="Rank"/>
                            </xsl:element>
                            <xsl:element name="URL">
                                <xsl:value-of select="YT/@link"/>
                            </xsl:element>
                            <xsl:element name="Type">
                                <xsl:value-of select="key('Genre', Type/@idref)"/>
                            </xsl:element>
                            <xsl:element name="Composer">
                                <xsl:for-each select="key('Composer', Composer/@idref)">
                                    <xsl:value-of select="Name"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="Last_Name"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="Nationality"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:for-each>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
            </xsl:element>
            <xsl:text>
            </xsl:text>
            <xsl:element name="Count">
                <xsl:value-of select="count(tns:Music/Works/Work)"/>
            </xsl:element>
            <xsl:element name="Types">
                <xsl:for-each-group select="tns:Music/Works/Work" group-by="key('Genre', Type/@idref)">
                    <xsl:element name="Type">
                        <xsl:element name="Type"><xsl:value-of select="current-grouping-key()"/></xsl:element>
                        <xsl:element name="Count"><xsl:value-of select="count(current-group())"/></xsl:element>
                        <xsl:element name="Ranks">
                            <xsl:element name="Min"><xsl:value-of select="min(current-group()/Rank)"/></xsl:element>
                            <xsl:element name="Max"><xsl:value-of select="max(current-group()/Rank)"/></xsl:element>
                            <xsl:element name="Avg"><xsl:value-of select="avg(current-group()/Rank)"/></xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each-group>
            </xsl:element>
            <xsl:element name="Ranks">
                <xsl:element name="Min"><xsl:value-of select="min(tns:Music/Works/Work/Rank)"/></xsl:element>
                <xsl:element name="Max"><xsl:value-of select="max(tns:Music/Works/Work/Rank)"/></xsl:element>
                <xsl:element name="Avg"><xsl:value-of select="avg(tns:Music/Works/Work/Rank)"/></xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>