pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.13 (Raspbian 11.13-0+deb10u1))
Type "help" for help.

test=> ALTER TABLE movies1
test-> ADD lexemestitle tsvector;
ALTER TABLE
test=> UPDATE movies1
test-> SET lexemestitle = to_tsvector(title) ;
UPDATE 5229
test=> ALTER TABLE movies1
test-> ADD rank2 float4 ;
ALTER TABLE
test=> UPDATE movies1
test-> SET rank2 = ts_rank(lexemestitle,plainto_tsquery((SELECT title FROM movies1 WHERE url='catch-me-if-you-can'))) ;
UPDATE 5229
test=> CREATE TABLE recommendationsBasedOntitleField AS
test-> SELECT url, rank2 FROM movies1 WHERE rank > 0.5 ORDER BY rank DESC LIMIT 50 ;
SELECT 5
test=> \copy (SELECT * FROM recommendationsBasedOntitlefield) to '/home/pi/RSL/top5recommendationsBasedOntitleField.csv' WITH csv ;
COPY 5
