DROP DATABASE IF EXISTS state_data;

CREATE DATABASE IF NOT EXISTS state_data;

USE state_data;

DROP TABLE IF EXISTS state_data;

CREATE TABLE state_data
(
	countyName VARCHAR(100) NOT NULL,
    stateName VARCHAR(100) NOT NULL,
    numCases INT NOT NULL,
    numCases100k FLOAT NOT NULL,
    numDeaths INT NOT NULL
);

SELECT * FROM state_data;