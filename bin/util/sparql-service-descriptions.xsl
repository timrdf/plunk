<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:s="http://www.w3.org/2005/sparql-results#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:j2r="jview2-rdf"
   exclude-result-prefixes="#all">

<xsl:include href="../../../../../../model_integration/rutil/sparql-endpoint.xsl"/>

<xsl:output method="text"/>

<!--xsl:param name="endpoint"    select="'http://logd.tw.rpi.edu/sparql'"/-->
<xsl:param name="endpoint"    select="'http://logd.tw.rpi.edu:8890/sparql'"/>
<!--xsl:param name="named-graph" select="'&lt;http://logd.tw.rpi.edu/source/data-gov/dataset/2538/version/mashathon>'"/-->
<xsl:param name="named-graph" select="'?g'"/>

<xsl:key name="value-of"      match="s:binding/*" use="../@name"/>

<xsl:variable name="GRAPHS_SELECT_QUERY" select="1"/>

<xsl:template match="/">
   <xsl:variable name="queries">
      <query><![CDATA[
         PREFIX sd: <http://www.w3.org/ns/sparql-service-description#>
         SELECT distinct ?:NAMED_GRAPH
         WHERE {
           GRAPH ?:NAMED_GRAPH {
             [] a []
           }
         }
      ]]></query>
   </xsl:variable>
   <xsl:variable name="request"  select="j2r:virtuoso($endpoint,j2r:situate-query(replace($queries/*[$GRAPHS_SELECT_QUERY],'\?:ENDPOINT',$endpoint),$named-graph))"/>
   <xsl:variable name="response" select="doc($request)"/>

   <xsl:value-of select="concat('@prefix sd: &lt;http://www.w3.org/ns/sparql-service-description#> .',$NL)"/>
   <xsl:value-of select="j2r:bind-variable($sparql-service-description-beg,'ENDPOINT',$endpoint)"/>

   <xsl:variable name="give-NamedGraphs-URIs" select="true()"/>

   <xsl:choose>

      <xsl:when test="not($give-NamedGraphs-URIs)">
         <!-- Using blank nodes for the sd:NamedGraphs requires just one pass. -->
         <xsl:for-each select="$response/s:sparql/s:results/s:result">
            <xsl:value-of select="replace(replace($sparql-service-description-mid,
                                                 '\?:ENDPOINT',$endpoint),
                                                 '\?:NAMED_GRAPH',key('value-of','g',.))"/>
         </xsl:for-each>
         <xsl:value-of select="concat($sparql-service-description-end,'')"/>
      </xsl:when>

      <xsl:otherwise>
         <!-- List all sd:namedGraphs in the endpoint's dataset. -->
         <xsl:for-each select="$response/s:sparql/s:results/s:result">
            <xsl:variable name="named-graph" select="key('value-of','g',.)"/>
            <xsl:value-of select="concat($NL,'      sd:namedGraph &lt;',j2r:name-sparql-endpoints-named-graph($endpoint,$named-graph),'>;',$NL)"/>
         </xsl:for-each>
         <xsl:value-of select="concat($sparql-service-description-end,'')"/>
         <xsl:value-of select="$NL"/>

         <!-- Describe the sd:NamedGraphs (URIS) with sd:name -->
         <xsl:for-each select="$response/s:sparql/s:results/s:result">
            <xsl:variable name="named-graph" select="key('value-of','g',.)"/>
            <xsl:value-of select="concat($NL,'&lt;',j2r:name-sparql-endpoints-named-graph($endpoint,$named-graph),'>',$NL,
                                         '   a sd:NamedGraph;',$NL,
                                         '   sd:name &lt;',$named-graph,'>',$NL,'.',$NL)"/>
         </xsl:for-each>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<xsl:variable name="sparql-service-description-beg">
[] a sd:Service; 
   sd:url &lt;?:ENDPOINT>;
   sd:defaultDatasetDescription [
      a sd:Dataset;
</xsl:variable>

<xsl:variable name="sparql-service-description-mid">
      sd:namedGraph [
         a sd:NamedGraph;
         sd:name &lt;?:NAMED_GRAPH>;
      ];</xsl:variable>

<xsl:variable name="sparql-service-description-end">
   ]
.</xsl:variable>

<xsl:function name="j2r:name-sparql-endpoints-named-graph">
   <xsl:param name="endpoint"/>
   <xsl:param name="named-graph"/>
   <xsl:variable name="query-constructing-named-graph-description">
      PREFIX sd: &lt;http://www.w3.org/ns/sparql-service-description#>

      CONSTRUCT { ?endpoints_named_graph ?p ?o }
      WHERE {
        GRAPH 
        ?:NAMED_GRAPH {
           [] sd:url ?:ENDPOINT;
              sd:defaultDatasetDescription [
                 sd:namedGraph ?endpoints_named_graph
              ]
           .
           ?endpoints_named_graph 
              sd:name 
           ?:NAMED_GRAPH;
              ?p ?o .
         }
      }
   </xsl:variable>
   <xsl:value-of select="concat($endpoint,
                                       '?query=',
                                       encode-for-uri(
                                       normalize-space(
                                       j2r:bind-variable(
                                       j2r:bind-variable($query-constructing-named-graph-description,
                                                        'ENDPOINT',   concat('&lt;',$endpoint,'>')),
                                                        'NAMED_GRAPH',concat('&lt;',$named-graph,'>')))))"/>
</xsl:function>

</xsl:transform>
