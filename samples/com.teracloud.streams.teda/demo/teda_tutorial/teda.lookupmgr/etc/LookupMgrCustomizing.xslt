<?xml version="1.0" encoding="UTF-8"?>
<!-- begin_generated_IBM_Teracloud_ApS_copyright_prolog               -->
<!--                                                                  -->
<!-- This is an automatically generated copyright prolog.             -->
<!-- After initializing,  DO NOT MODIFY OR MOVE                       -->
<!-- **************************************************************** -->
<!-- Licensed Materials - Property of IBM                             -->
<!-- (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2023, 2023     -->
<!-- All Rights Reserved.                                             -->
<!-- US Government Users Restricted Rights - Use, duplication or      -->
<!-- disclosure restricted by GSA ADP Schedule Contract with          -->
<!-- IBM Corp.                                                        -->
<!--                                                                  -->
<!-- end_generated_IBM_Teracloud_ApS_copyright_prolog                 -->
<xsl:stylesheet version="1.0" xmlns:teda="http://www.ibm.com/xmlns/prod/streams/teda" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" version="1.0" encoding="utf-8"/>
	<xsl:key name="DataSourcesGroup" match="teda:LookupManager/teda:Application/teda:StreamsSchemas/teda:StreamsSchema" use="@SegmentName"/>
	<xsl:key name="SegmentsGroup" match="teda:LookupManager/teda:Application/teda:SegmentCustomizing/teda:Segment" use="@MemSegmentName"/>
	<xsl:key name="ApplicationGroup" match="teda:LookupManager/teda:Application" use="teda:SegmentCustomizing/teda:Segment/@MemSegmentName"/>
	<xsl:template match="/">
	<LookupManager 
		SchemaVersion="2.0" 
		xmlns="http://www.ibm.com/xmlns/prod/streams/teda" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xsi:schemaLocation="http://www.ibm.com/xmlns/prod/streams/teda etc/LookupMgrCustomizing.xsd">
		<xsl:element name="DataSources">
		<xsl:comment>Indexing begins with 0</xsl:comment>
		<xsl:for-each select="teda:LookupManager/teda:Application/teda:StreamsSchemas/teda:StreamsSchema[generate-id() = generate-id(key('DataSourcesGroup', @SegmentName)[1])]">
			<xsl:element name="DataSource">
				<xsl:attribute name="Name">
				<xsl:value-of select="@SegmentName"/>
				</xsl:attribute>
				<xsl:for-each select="teda:SchemaValueDefinition">
					<xsl:element name="ValueDefinition">
						<xsl:copy-of select="@*"/>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>
		</xsl:element>
		<xsl:element name="Segments">
			<xsl:for-each select="teda:LookupManager/teda:Application/teda:SegmentCustomizing/teda:Segment[generate-id() = generate-id(key('SegmentsGroup', @MemSegmentName)[1])]">
				<xsl:element name="Segment">
					<xsl:attribute name="Name">
					<xsl:value-of select="@MemSegmentName"/>
					</xsl:attribute>
					<xsl:attribute name="DataSource">
					<xsl:value-of select="@Name"/>
					</xsl:attribute>
					<xsl:copy-of select="teda:SegmentSize/@*"/>
					<xsl:element name="Stores">
						<xsl:for-each select="teda:StoreDefinitions">
							<xsl:element name="Store">
								<xsl:copy-of select="@Name"/>
								<xsl:for-each select="teda:SPLValueAssigment">
									<xsl:element name="ValueAssignment">
										<xsl:copy-of select="@SPLType"/>
										<xsl:attribute name="Name">
										<xsl:value-of select="@ValueName"/>
										</xsl:attribute>
										<xsl:attribute name="SPLExpression">
										<xsl:value-of select="@SPLValueExpression"/>
										</xsl:attribute>
									</xsl:element>
								</xsl:for-each>
								<xsl:element name="KeyAssignment">
									<xsl:attribute name="SPLType">
									<xsl:value-of select="teda:SPLKeyAssigment/@SPLKeyType"/>
									</xsl:attribute>
									<xsl:attribute name="SPLExpression">
									<xsl:value-of select="teda:SPLKeyAssigment/@SPLKeyExpression"/>
									</xsl:attribute>
								</xsl:element>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					<xsl:element name="Applications">
						<xsl:for-each select="key('ApplicationGroup', @MemSegmentName)">
							<xsl:element name="Application">
								<xsl:attribute name="Namespace">
								<xsl:value-of select="@ApplicationNamespace"/>
								</xsl:attribute>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</LookupManager>		
	</xsl:template>
</xsl:stylesheet>
