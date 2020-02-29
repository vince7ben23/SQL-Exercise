--  ###leetcode Delete Duplicate Emails###
--     Write a SQL query to delete all duplicate email entries in a table named Person, 
--     keeping only unique emails based on its smallest Id.

CREATE TABLE Person (
Id int PRIMARY KEY  NOT NULL,
Email varchar(50) NOT NULL
)

INSERT INTO Person(Id, Email) VALUES(1, 'john@example.com');
INSERT INTO Person(Id, Email) VALUES(2, 'bob@example.com');
INSERT INTO Person(Id, Email) VALUES(3, 'john@example.com');

-- ##Mathod 1.
DELETE FROM Person WHERE id  IN
	(SELECT c.dup_id FROM
        (
		    SELECT a.id AS dup_id FROM Person AS a
		    WHERE EXISTS
				    (
					    SELECT b.id FROM Person AS b
					    WHERE b.id < a.id AND b.email = a.email
				    )
	    ) AS c
    )
	
-- ##Mathod 2.	
DELETE a
FROM Person AS a
JOIN Person AS b
ON a.id > b.id AND a.email = b.email;