pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.13 (Raspbian 11.13-0+deb10u1))
Type "help" for help.

test=> CREATE TABLE movies1 (url text,title text,ReleaseDate text,Distributor text,Starring text,Summary text,Director text,Genre text,Rating text,Runtime text,Userscore text,Metascore text,scoreCounts text);
CREATE TABLE
test=> \copy movies1 FROM '/home/pi/RSL/moviesFromMetacritic.csv' delimiter ';' csv header ;
COPY 5229
test=> ALTER TABLE movies1
test-> ADD lexemesSummary tsvector;
ALTER TABLE
test=> UPDATE movies1
test-> SET lexemesSummary = to_tsvector(Summary) ;
UPDATE 5229
test=> ALTER TABLE movies1
test-> ADD rank float4 ;
ALTER TABLE
test=> UPDATE movies1
test-> SET rank = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies1 WHERE url='war-for-the-planet-of-the-apes'))) ;
UPDATE 5229
test=> CREATE TABLE recommendationsBasedOnSummaryField AS
test-> SELECT url, rank FROM movies1 WHERE rank > 0.5 ORDER BY rank DESC LIMIT 50 ;
SELECT 5
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField) to '/home/pi/RSL/top5recommendationsBasedOnSummary.csv' WITH csv ;
COPY 5
