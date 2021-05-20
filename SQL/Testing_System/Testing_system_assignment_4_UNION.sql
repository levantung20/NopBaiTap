USE testingsystem3;

-- Exercise 2: Union
	-- Question 17: 
SELECT a.*, ga.GroupID
FROM `account` a 
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1
UNION
SELECT a.*, ga.GroupID
FROM `account` a 
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;


	-- Question 18: 
SELECT GroupID, COUNT(AccountID) AS NumbersOfMember
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) >= 5    
UNION
SELECT GroupID, COUNT(AccountID) AS NumbersOfMember
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) <= 7;   
