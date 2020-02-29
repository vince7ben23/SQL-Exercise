-- CREATE TABLE score(
-- 	name varchar(50) NOT NULL,
-- 	score int NOT NULL
-- );

-- INSERT INTO score (name, score) VALUES('John', 10);
-- INSERT INTO score (name, score) VALUES('Jennifer', 15);
-- INSERT INTO score (name, score) VALUES('Stella', 20);
-- INSERT INTO score (name, score) VALUES('Sophia', 40);
-- INSERT INTO score (name, score) VALUES('Greg', 50);
-- INSERT INTO score (name, score) VALUES('Jeff', 20);


--求排名
SELECT a.name, a.score , COUNT(a.score) AS rank 
FROM score AS a
JOIN score AS b
ON a.score < b.score OR (a.score = b.score AND a.name = b.name)
GROUP BY a.name, a.score
ORDER BY rank;



--求中位數
SELECT c.name, c.score, c.rank 
FROM
	(SELECT a.name, a.score, COUNT(a.name) AS rank
		FROM score AS a
		JOIN score AS b
		ON a.score < b.score OR (a.name = b.name AND a.score = b.score)
		GROUP BY a.name, a.score
		ORDER BY a.score DESC) AS c
WHERE c.rank =((SELECT COUNT(name) FROM score)+1)/2;


--算出累積總計
SELECT  a.name, a.score, SUM(b.score) AS 累積總計
FROM score AS a
JOIN score AS b
ON a.score <= b.score OR (a.name = b.name AND a.score = b.score)
GROUP BY a.name, a.score
ORDER BY 累積總計;


--總合百分比
SELECT name, score, CONCAT(100*score/(SELECT SUM(score) FROM score), '%') AS 總合百分比
FROM score
ORDER BY score DESC;

--累積總合百分比
SELECT  a.name, a.score, CONCAT(100*SUM(b.score)/(SELECT SUM(score) FROM score), '%') AS 累積總合百分比
FROM score AS a
JOIN score AS b
ON a.score <= b.score OR (a.name = b.name AND a.score = b.score)
GROUP BY a.name, a.score
ORDER BY score DESC, name DESC ;


