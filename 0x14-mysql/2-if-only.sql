-- 2.If only you could see what I've seen with your eyes

CREATE DATABASE IF NOT EXISTS tyrell_corp;

USE tyrell_corp;

CREATE TABLE IF NOT EXISTS nexus6
(
        id int,
        name varchar(256)
);

INSERT INTO nexus6 (id, name)
        VALUES (1, 'Leon');


GRANT SELECT
  ON *.*
  TO 'holberton_user'@'localhost';

SELECT * from nexus6;
