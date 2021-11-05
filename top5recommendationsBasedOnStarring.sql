pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.13 (Raspbian 11.13-0+deb10u1))
Type "help" for help.

test=> ALTER TABLE movies1
test-> ADD lexemesStarring tsvector;
ALTER TABLE
test=> UPDATE movies1
test-> SET lexemesStarring = to_tsvector(Starring) ;
UPDATE 5229
test=> ALTER TABLE movies1
test-> ADD rank1 float4 ;
ALTER TABLE
test=> UPDATE movies1
test-> SET rank1 = ts_rank(lexemesStarring,plainto_tsquery((SELECT Starring FROM movies1 WHERE url='catch-me-if-you-can'))) ;
UPDATE 5229
test=>  CREATE TABLE recommendationsBasedOnStarring AS
test-> SELECT url, rank1 FROM movies1 WHERE rank > 0.5 ORDER BY rank DESC LIMIT 50 ;
SELECT 5
test=> \copy (SELECT * FROM recommendationsBasedOnStarring) to '/home/pi/RSL/top5recommendationsBasedOnStarring.csv' WITH csv ;
COPY 5




