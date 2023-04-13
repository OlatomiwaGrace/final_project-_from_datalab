-- creating a schema and loading csv file to mysql database
-- CREATE SCHEMA DATA;

-- select database to use
USE projectdata;

-- show database tables
SHOW TABLES;

-- sql select – selecting all (*) column from table
SELECT * FROM actions2load;

-- another method of selecting all column from sql
SELECT * FROM projectdata.actions2load;

# count the number of rows
SELECT COUNT(*) FROM actions2load;

# describe table structure
DESC actions2load;

-- QUESTIONS TO QUERY FROM MYSQL

-- 1. What Events are the most common?
SELECT MAX(event_type) FROM actions2load;
SELECT event_type FROM actions2load WHERE event_type = (SELECT MAX(event_type) FROM actions2load);


SELECT event_type, COUNT(*) AS event_count FROM actions2load 
GROUP BY event_type 
ORDER BY event_count DESC
LIMIT 1;

# GEt most common event type
SELECT event_type, COUNT(event_type)
FROM actions2load
GROUP BY event_type;


# Count of the same result (above)
SELECT COUNT(*) FROM actions2load WHERE (SELECT MAX(event_type) FROM actions2load);

-- 2. what events are the least common?
SELECT MIN(event_type) AS least_common FROM actions2load;

SELECT event_type FROM actions2load WHERE event_type = (SELECT MIN(event_type) FROM actions2load);

SELECT event_type, COUNT(*) AS event_count
FROM actions2load GROUP BY event_type
ORDER BY event_count ASC
LIMIT 1;

-- Count of the same result (above)
SELECT COUNT(*) FROM actions2load WHERE (SELECT MIN(event_type) FROM actions2load);


-- 3. get the account id with the highest number of events?
SELECT MAX(account_id) FROM actions2load;
SELECT account_id FROM actions2load WHERE account_id = (SELECT MAX(account_id) FROM actions2load);
SELECT account_id, event_type FROM actions2load WHERE account_id = (SELECT MAX(account_id) FROM actions2load);

SELECT account_id, COUNT(*) AS event_count
FROM actions2load GROUP BY account_id 
ORDER BY event_count DESC LIMIT 1;

# Count of the same result (above)
SELECT COUNT(*) FROM actions2load WHERE (SELECT MAX(account_id) FROM actions2load);


-- 4. get the account id with the least number of events?
SELECT MIN(account_id) FROM actions2load;
SELECT account_id FROM actions2load WHERE account_id = (SELECT MIN(account_id) FROM actions2load);
SELECT account_id, event_type FROM actions2load WHERE account_id = (SELECT MIN(account_id) FROM actions2load);

SELECT account_id, COUNT(*) AS event_count FROM actions2load
GROUP BY account_id ORDER BY event_count ASC LIMIT 1;

# Count of the same result (above)
SELECT COUNT(*) FROM actions2load WHERE (SELECT MIN(account_id) FROM actions2load);

-- 5. how many times event occured based on different times of the day?

# Select all rows from actions2load table
 SELECT * FROM actions2load; 
DESC actions2load;


# date_format() to get the format of date needed
SELECT DATE_FORMAT("2019-11-29", "%M %D %Y") AS Monthdayy;
SELECT event_time AS original, DATE_FORMAT(event_time, "%M %D %Y %h %m %s") AS New_date
FROM actions2load; 
SELECT event_time AS original, DATE_FORMAT(event_time, "%hh %mm %ss") AS New_time
FROM actions2load; 

-- getting the number of times event occur based on different times of the day
SELECT (event_time) AS hour_of_day, COUNT(*) AS event_count FROM actions2load GROUP BY hour_of_day;

SELECT DATE_FORMAT(event_time, '%H:%i') AS time_of_day, COUNT(*) AS event_count
FROM actions2load
GROUP BY DATE_FORMAT(event_time, '%H:%i')
ORDER BY time_of_day;

