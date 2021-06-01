DROP DATABASE IF EXISTS nobel;
CREATE DATABASE nobel;
USE nobel;

DROP TABLE IF EXISTS nobeladwards;
CREATE TABLE nobeladwards(
	`year` 		CHAR(4),
    `subject`	VARCHAR(20),
    winner		VARCHAR(20)
);

-- 1. Hiển thị thông tin(tất cả các trường) của giải Nobel năm 1950
CREATE VIEW nobelWinner1950 AS 
SELECT * 
FROM nobeladwards
WHERE `year` = 1950;
-- 2. Hiển thị tên người nhận giải(winner) Nobel năm 1962 ở lĩnh vực Văn học
CREATE VIEW nobelWinner1962_lit AS
SELECT winner
FROM nobeladwards
WHERE `year` = 1962 AND `subject` = 'literature';
-- 3. Hiển thị năm và chủ đề mà nhà bác học Albert Einstein nhận giải Nobel
CREATE VIEW noble_einstein AS
SELECT `year`,`subject`
FROM nobeladwards
WHERE winner = 'Albert Einstein';
-- 4. Hiển thị tên người nhận giải Nobel kể từ năm 2000(bao gồm cả năm 2000) thuộc chủ đề Hòa bình(Peace)
CREATE VIEW nobelwinner_Peace_2000UpToNow AS
SELECT winner
FROM nobeladwards
WHERE `year` >=2000 AND `subject` = 'Peace';
-- 5. Hiển thị đầy đủ các thông tin của những người dành giải Nobel trong những năm 80(1980 đến 1989)
CREATE VIEW nobelwinner_80s AS
SELECT winner
FROM nobeladwards
WHERE `year` >= 1980 AND `year` <= 1989;
/* 6. Hiển thị thông tin nhận giải Nobel của các vị lãnh đạo có tên sau:
Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama */
SELECT *
FROM nobeladwards
WHERE winner IN ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama')
ORDER BY winner;
-- 7. Hiển thị các tên người nhận giải có Firstname là John
CREATE VIEW nobelwinner_firstnameJohn AS
SELECT *
FROM nobeladwards
WHERE winner LIKE 'John%';
-- 8. Hiển thị year, subject, và name của người nhận giải Nobel vật lý năm 1980 và người nhận giải Nobel hóa học năm 1984
SELECT *
FROM nobeladwards
WHERE `year` = 1980 AND `subject` = 'Physics'
UNION
SELECT *
FROM nobeladwards
WHERE `year` = 1984 AND `subject` = 'Chemistry';
-- 9. Hiển thị year, subject, và name của những người nhận giải năm 1980, ngoại trừ chủ đề Hóa học và Dược phẩm(Chemistry and Medicine)
SELECT *
FROM nobeladwards
WHERE `year` = 1980 AND `subject` NOT IN ('Chemistry','Medicine');
-- 10. Hiển thị year, subject, và name của những người nhận giải Nobel Dược phẩm(Medicine) trước 1910(ko bao gồm 1910) 
-- và những người nhận giải Nobel văn học(Literature) sau năm 2004(bao gồm 2004)
SELECT *
FROM nobeladwards
WHERE `year` < 1910 AND `subject` = 'Medicine'
UNION
SELECT *
FROM nobeladwards
WHERE `year` > 2004 AND `subject` = 'Literature';

-- Nâng cao
-- 11. Tìm thông tin tất cả các giải Nobel của PETER GRÜNBERG
SELECT *
FROM nobeladwards
WHERE winner = 'PETER GRÜNBERG';
-- 12. Tìm thông tin tất cả các giải Nobel của EUGENE O’NEILL
SELECT *
FROM nobeladwards
WHERE winner = 'EUGENE O’NEILL';
-- 13. Hiển thị thông tin winners, year và subject của những người có tên bắt đầu bằng Sir. 
-- Hiển thị gần đây nhất đầu tiên, sau đó theo thứ tự tên
SELECT *
FROM nobeladwards
WHERE winner LIKE 'sir.%'
ORDER BY `year`DESC, winner ASC;
-- 14. Hiển thị thông tin người giành giải năm 1984 và chủ đề, sắp xếp theo tên chủ đề và sau đó là tên người giành giải, 
-- nhưng chủ đề Chemistry và Physics xếp cuối
(SELECT winner,`year`
FROM nobeladwards
WHERE `year` = 1984 AND `subject` NOT IN ('Chemistry','Physics')
ORDER BY `subject`, winner)
UNION
(SELECT winner,`year`
FROM nobeladwards
WHERE `year` = 1984 AND `subject` IN ('Chemistry','Physics')
ORDER BY `subject`, winner);


