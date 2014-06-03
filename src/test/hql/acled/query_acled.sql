add jar /usr/local/lib/accumulo/lib/guava.jar;
add jar /usr/local/lib/zookeeper/zookeeper-3.4.5.jar;
add jar /usr/local/lib/accumulo/lib/accumulo-trace.jar;
add jar /usr/local/lib/accumulo/lib/accumulo-fate.jar;
add jar /usr/local/lib/accumulo/lib/accumulo-core.jar;
add jar /usr/local/lib/accumulo/lib/accumulo-start.jar;
add jar /Users/jelser/projects/hive.git/packaging/target/apache-hive-0.14.0-SNAPSHOT-bin/apache-hive-0.14.0-SNAPSHOT-bin/lib/hive-accumulo-handler-0.14.0-SNAPSHOT.jar;

DROP TABLE IF EXISTS acled;
CREATE EXTERNAL TABLE acled(rowid STRING, lat DOUBLE, lon DOUBLE, loc STRING, src STRING, type STRING, fid INT, pid BIGINT) 
STORED BY 'org.apache.hadoop.hive.accumulo.AccumuloStorageHandler' 
WITH SERDEPROPERTIES ('accumulo.columns.mapping' = 'rowID,cf|lat,cf|lon,cf|loc,cf|src,cf|type,cf|fid,cf|pid',
	'accumulo.table.name' = 'acled');
	
select pid from acled where pid != 1111 limit 100;
		
select type,lat,lon from acled where pid = 3333 and fid = 20 and type like 'Violence%';

select pid,fid from acled where pid > 3333 and fid < 30 limit 100;

select lat,lon from acled where lat > 0.0 and lat < 10.0 and lon > 0.0 and lon < 10.0 limit 100;

select * from acled where src = 'Reuters News';

select * from acled where loc = 'Clough Creek';

DROP TABLE IF EXISTS acled2;
CREATE EXTERNAL TABLE acled2(rowid STRING, lat DOUBLE, lon DOUBLE, loc STRING, src STRING, type STRING) 
STORED BY 'org.apache.hadoop.hive.accumulo.AccumuloStorageHandler' 
WITH SERDEPROPERTIES ('accumulo.columns.mapping' = 'rowID,cf|lat,cf|lon,cf|loc,cf|src,cf|type',
	'accumulo.no.iterators' = 'true',
	'accumulo.table.name' = 'acled');

select count(1) from acled2 where type = 'Violence against civilians';

select a1.lat,a1.lon,a2.src from acled a1 JOIN acled2 a2 on a1.rowid = a2.rowid; 



