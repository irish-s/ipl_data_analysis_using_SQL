CREATE DATABASE ipl;

CREATE TABLE matches (id integer,
  season integer,
  city varchar,
  date date,
  team1 varchar, 
  team2 varchar, 
  toss_winner varchar, 
  toss_decision varchar, 
  result varchar, 
  dl_applied integer, 
  winner varchar, 
  win_by_runs integer, 
  win_by_wickets integer, 
  player_of_the_match varchar, 
  venue varchar, 
  umpire1 varchar, 
  umpire2 varchar, 
  umpire3 integer
);

CREATE TABLE deliveries (
  matchid integer, 
  inning integer, 
  batting_team varchar, 
  bowling_team varchar, 
  over integer, 
  ball integer, 
  batsman varchar, 
  non_striker varchar, 
  bowler varchar, 
  is_super_over integer, 
  wide_runs integer, 
  bye_runs integer, 
  legbye_runs integer, 
  noball_runs integer, 
  penalty_runs integer, 
  batsman_runs integer, 
  extra_runs integer, 
  total_runs integer, 
  player_dismissed varchar, 
  dismissal_kind varchar, 
  fielder varchar
);

copy matches from 'C:/Users/iamir/Downloads/archive/matches.csv' with (format 'csv', header true);
copy deliveries from 'C:/Users/iamir/Downloads/archive/deliveries.csv' with (format 'csv', header true);

SELECT COUNT(*) as no_of_rows FROM matches;
/*Shape of Data gives no of rows*/
SELECT COUNT(*) as no_of_columns FROM information_schema.columns WHERE table_name = 'matches';
/*gives no of columns*/
SELECT * FROM matches LIMIT 5;
/*View first 5 rows*/
SELECT * FROM deliveries LIMIT 5;
/*View first 5 rows from deliveries table*/
SELECT date, team1, team2, winner FROM matches limit 5;
/*View selected columns*/
SELECT COUNT(DISTINCT(player_of_the_match)) FROM matches;
/*How many players have won player of the match award at least once*/
Select distinct on (season) * from matches order by season, date desc;
/*Find season winner for each season (season winner is the winner of the last match of each season*/
SELECT * FROM matches;
/*gets matches data*/
SELECT * FROM matches ORDER BY city LIMIT 10;
/*Order the rows by city in which the match was played*/
SELECT venue FROM matches ORDER BY date DESC LIMIT 10;
/*Find venue of 10 most recently played matches*/
Select batsman, total_runs, 
    CASE WHEN total_runs = 4 THEN 'Four' 
         WHEN total_runs = 6 THEN 'Six' 
         WHEN total_runs = 1 THEN 'single' 
         WHEN total_runs = 0 THEN 'duck' 
     END as howzthat 
   FROM deliveries;
/*Return a column with comment based on total_runs*/
SELECT MAX(win_by_runs) FROM matches;
/*What is the highest runs by which any team won a match*/
SELECT SUM(extra_runs) FROM deliveries;
/*How many extra runs have been conceded in ipl*/
SELECT ROUND(AVG(win_by_runs), 2) FROM matches;
/*On an average, teams won by how many runs in ipl*/
SELECT SUM(extra_runs) FROM deliveries WHERE bowler = 'SK Warne';
/*How many extra runs were conceded in ipl by SK Warne*/
SELECT COUNT(total_runs) FROM deliveries WHERE total_runs = 4 OR total_runs = 6;
/*How many boundaries (4s or 6s) have been hit in ipl*/
SELECT COUNT(*) FROM deliveries WHERE batsman = 'SR Tendulkar' AND bowler = 'SK Warne';
/*How many balls did SK Warne bowl to batsman SR Tendulkar/*
SELECT COUNT(*) FROM matches WHERE EXTRACT(month FROM date) = 4;
/*How many matches were played in the month of April*/
SELECT COUNT(*) FROM matches WHERE EXTRACT(month FROM date) = 3 or EXTRACT(month FROM date) = 6;
/*How many matches were played in the March and June*/
SELECT COUNT(player_dismissed) AS total_wickets FROM deliveries WHERE player_dismissed IS NOT NULL;
/*Total number of wickets taken in ipl (count not null values)*/
SELECT COUNT(DISTINCT(batsman)) FROM deliveries WHERE batsman LIKE 'S%';
/*How many batsmen have names starting with S*/
SELECT COUNT(DISTINCT(team1));
/*How many teams have word royal in it (could be anywhere in the team name, any case)*/
SELECT season, MAX(win_by_runs) FROM matches GROUP BY season ORDER BY season;
/*Maximum runs by which any team won a match per season*/
SELECT matchid, batting_team, batsman, SUM(batsman_runs) FROM deliveries GROUP BY matchid, batting_team, batsman ORDER BY matchid, batting_team;
/*Create score card for each match Id*/
SELECT batting_team, COUNT(total_runs) as No_of_boundaries FROM deliveries WHERE total_runs = 4 OR total_runs = 6 GROUP BY batting_team ORDER BY no_of_boundaries desc;
/*Total boundaries hit in ipl by each team*/
SELECT batsman, COUNT(batsman_runs);
/*Top 10 players with max boundaries (4 or 6)*/	
SELECT bowler, SUM(extra_runs) as total_extra_runs FROM deliveries GROUP BY bowler ORDER BY total_extra_runs DESC LIMIT 20;
/*Top 20 bowlers who conceded highest extra runs*/
SELECT bowler, COUNT(player_dismissed) as total_wickets;
/*Top 10 wicket takers*/
SELECT bowler, COUNT(player_dismissed) AS total_wickets FROM deliveries WHERE player_dismissed IS NOT NULL GROUP BY bowler HAVING COUNT(player_dismissed) >=100 ORDER BY total_wickets desc;
/*Name and number of wickets by bowlers who have taken more than or equal to 100 wickets in ipl*/
Select d.*, m.id, m.date from deliveries d join matches m on m.id = d.matchid limit 2;
/*Combine column date from matches with table deliveries to get data by year*/








	

