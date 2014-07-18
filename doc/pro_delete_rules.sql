DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_rules`(IN sectionId INT)
BEGIN
    -- 定义变量
    DECLARE exit_loop INT DEFAULT 0;
    DECLARE validation_rule_id INT DEFAULT -1;
    


    -- 定义CURSOR
    DECLARE rule_cursor CURSOR FOR
        SELECT rule_id FROM section_rule WHERE section_id = sectionId;

    -- 定义NOT FOUND HANDLER
    DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET exit_loop = 1;

    OPEN rule_cursor;

    -- 开始Iterate
    get_id: LOOP
        FETCH rule_cursor INTO validation_rule_id;
        
        IF exit_loop = 1 THEN
            LEAVE get_id;
        END IF;

        -- 删除section_rule对应列
        DELETE FROM section_rule WHERE rule_id = validation_rule_id;

        -- 删除validatoin_rule表中对应的列
        DELETE FROM validation_rule WHERE id = validation_rule_id;

    END LOOP get_id;

    CLOSE rule_cursor;
END