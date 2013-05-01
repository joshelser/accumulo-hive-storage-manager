Accumulo-hive-storage-manager
=============================

Pertains to patch: https://issues.apache.org/jira/browse/ACCUMULO-143

Manage your Accumulo tables through the Hive metastore, and issue queries directly over the underlying column familes and qualifiers. 

Requires Hive 0.10 and Accumulo 1.5+ which both use Thrift 0.9. Otherwise there are binary incompatibilities. 

Setup:
=================

Before you can build this storage handler, checkout and build Accumulo from the latest source. <code>svn co https://svn.apache.org/repos/asf/accumulo/trunk/</code> then <code>mvn clean install</code> to get 1.6.0 installed in your local repo. This will
have to do until Accumulo 1.5+ is hosted in maven central.

Documentation:
=================

<a href="http://storage-handler-docs.s3.amazonaws.com/javadocs/index.html">Javadocs</a>

<a href="https://github.com/bfemiano/accumulo-hive-storage-manager/wiki/examples">Basic tutorial</a>

ACLED examples:
=================
 
$ACCUMULO_HOME/bin, $HADOOP_HOME/bin, $HIVE_HOME/bin on environment path. Either wget or curl installed. 

The query examples use a cleaned up version of the structured Acled Nigeria dataset. (http://www.acleddata.com/) 

1.	Navigate to [src/test/hql/acled](src/test/hql/acled) and run [ingest.sh](src/test/hql/acled/ingest.sh). The script handles creating and loading data for both the Hive and Accumulo acled tables named 'acled_nigeria' and 'acled' respectively. The ETL and data for both processes runs standalone from the  [ingest](src/test/hql/acled) directory. 

2.	See [query_acled.sql](src/test/hql/query_acled.sql) for CREATE EXTERNAL TABLE example, required aux jars, and several sample queries that utilize both the Hive and Accumulo tables. The number of hive columns in table definition must be equal to accumulo.column.mapping.

3.	Run [query_acled.sh](src/test/hql/query_acled.sh) to see the different query results. Make sure to configure the -hiveconf variables for your local Accumulo instance. 

Known limitations:
===================

* 	Supported Hive column types limited to int, double, string and bigint. 
*	The Hive column types must match Accumulo value types to avoid odd behavior. An Accumulo value holding integer bytes should be mapped as a hive column of type int. 
* 	Does not yet support INSERT.
* 	Iterator pushdown only works on WHERE clauses consisting of purely conjunctive predicates. This is a known Hive limitation with the IndexPredicateAnalyzer.
* 	'Like' CompareOpt exists is not considered decomposable by the predicate analyzer.
*	Iterator pushdown only kicks in for operators <, >, =, >=, <=. 

Future enhancements: 
====================

*	Allow INSERT for field serialization to Accumulo. OutputFormat exists but is not wired to Serde or tested.  
*   Serde property for setting fixed timestamp during mutations. 
*   Allow per-qualifier type hints in the serde property, similar to the latest build of the HBase StorageHandler.  
*   Support for remaining hive primitive column types.
*   Support for complex value types (Struct, Map, Array, Union).
