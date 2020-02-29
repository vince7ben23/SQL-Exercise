--  ## leetcode 180. Consecutive Numbers
--     Write a SQL query to find all numbers that appear at least three times consecutively.


Create table If Not Exists Logs (Id int, Num int);
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');



SELECT DISTINCT a.num AS ConsecutiveNums FROM logs AS a
JOIN logs AS b
ON  a.id = (b.id-1)  AND a.num = b.num
JOIN logs AS c
ON a.id = (c.id-2)  AND a.num = c.num