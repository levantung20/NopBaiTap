
-- Exercise 1: Tiếp tục với Database ở buổi 6
/* Viết triggers để tránh trường hợp người dùng nhập thông tin module Project không hợp 
lệ 
(Project_Modules.ProjectModulesDate < Projects.ProjectStartDate,
Project_Modules.ProjectModulesCompletedOn > Projects.ProjectCompletedOn)*/
USE new_projects;
DROP TRIGGER IF EXISTS check_dates;
DELIMITER $$
CREATE TRIGGER check_dates
BEFORE INSERT ON Project_Modules 
FOR EACH ROW
	BEGIN
		DECLARE var_projectID SMALLINT UNSIGNED;
        DECLARE var_ProjectStartDate DATE;
        DECLARE var_ProjectCompletedOn DATE;
        
        SELECT ProjectID INTO var_projectID
        FROM Project_Modules
        WHERE ModuleID = NEW.ModuleID;
        
        SELECT ProjectStartDate INTO var_ProjectStartDate
        FROM Projects
        WHERE ProjectID = var_projectID;
        
        SELECT ProjectCompletedOn INTO var_ProjectCompletedOn
        FROM Projects
        WHERE ProjectID = var_projectID;
        
        IF NEW.ProjectModulesDate < var_ProjectStartDate  
        THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'thông tin module Project không hợp lệ';
		END IF;
        
        IF NEW.ProjectModulesCompledOn > var_ProjectCompletedOn
        THEN 
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'thông tin module Project không hợp lệ';
		END IF;
	END $$
DELIMITER ;

/* Exercise 2: View
Trong database phần Assignment 3, Tạo 1 VIEW để lấy ra tất cả các thực tập sinh là 
ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số 
điểm như sau:
 ET_IQ + ET_Gmath>=20
 ET_IQ>=8
 ET_Gmath>=8
 ET_English>=18 */
USE fresher;
DROP VIEW IF EXISTS list_ETs;
CREATE VIEW list_ETs AS
SELECT *
FROM trainee
WHERE ET_IQ + ET_Gmath>=20 	AND 	ET_IQ>=8
							AND		ET_Gmath>=8
							AND		ET_English>=18;
