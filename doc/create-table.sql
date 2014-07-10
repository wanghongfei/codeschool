SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `codeschool` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `codeschool` ;

-- -----------------------------------------------------
-- Table `codeschool`.`member`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`member` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `avatar_image` BLOB NULL DEFAULT NULL ,
  `bio` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `birthday` DATE NULL DEFAULT NULL ,
  `courses_finished_amount` INT(11) NULL DEFAULT NULL ,
  `email_address` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `finished_section_ids` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `gender` INT(11) NULL DEFAULT NULL ,
  `location` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `max_consecution` INT(11) NULL DEFAULT NULL ,
  `nick_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `occupation` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `password` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `phone_number` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `point` INT(11) NULL DEFAULT NULL ,
  `qq_number` VARCHAR(30) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `rank` BIGINT(20) NULL DEFAULT NULL ,
  `register_date` DATETIME NULL DEFAULT NULL ,
  `started_course_ids` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `thumb_amount` INT(11) NULL DEFAULT NULL ,
  `username` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`member_acquired_badges`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`member_acquired_badges` (
  `id` INT(11) NOT NULL ,
  `acquire_time` DATE NULL DEFAULT NULL ,
  `memo` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `member_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) ,
  INDEX `FK3555F49CD200ED63` (`member_id` ASC) ,
  CONSTRAINT `FK3555F49CD200ED63`
    FOREIGN KEY (`member_id` )
    REFERENCES `codeschool`.`member` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`course`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`course` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `chapter_amount` INT(11) NULL DEFAULT NULL ,
  `course_category` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `course_description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `course_language` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `course_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `finished_member_amount` INT(11) NULL DEFAULT NULL ,
  `section_amount` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`course_chapter`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`course_chapter` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `chapter_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `finished_member_amount` INT(11) NULL DEFAULT NULL ,
  `memo` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `course_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) ,
  INDEX `FK8A36B829C8DF71C3` (`course_id` ASC) ,
  CONSTRAINT `FK8A36B829C8DF71C3`
    FOREIGN KEY (`course_id` )
    REFERENCES `codeschool`.`course` (`id` ))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`all_badges`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`all_badges` (
  `id` INT(11) NOT NULL ,
  `badge_icon` TINYBLOB NULL DEFAULT NULL ,
  `badge_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `memo` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `course_id` INT(11) NOT NULL ,
  `course_chapter_id` INT(11) NOT NULL ,
  `member_acquired_badges_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) ,
  INDEX `FK3DE2758EC8DF71C3` (`course_id` ASC) ,
  INDEX `FK3DE2758E980A4A9A` (`course_chapter_id` ASC) ,
  INDEX `FK3DE2758E5FAE641F` (`member_acquired_badges_id` ASC) ,
  CONSTRAINT `FK3DE2758E5FAE641F`
    FOREIGN KEY (`member_acquired_badges_id` )
    REFERENCES `codeschool`.`member_acquired_badges` (`id` ),
  CONSTRAINT `FK3DE2758E980A4A9A`
    FOREIGN KEY (`course_chapter_id` )
    REFERENCES `codeschool`.`course_chapter` (`id` ),
  CONSTRAINT `FK3DE2758EC8DF71C3`
    FOREIGN KEY (`course_id` )
    REFERENCES `codeschool`.`course` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`course_section`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`course_section` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `course_content` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `finished_member_amount` INT(11) NULL DEFAULT NULL ,
  `initial_code` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `section_description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `section_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `chapter_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `FKD399BAC1833E63F6` (`chapter_id` ASC) ,
  CONSTRAINT `FKD399BAC1833E63F6`
    FOREIGN KEY (`chapter_id` )
    REFERENCES `codeschool`.`course_chapter` (`id` ))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`member_friend`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`member_friend` (
  `member_id` INT(11) NOT NULL ,
  `friend_id` INT(11) NOT NULL ,
  INDEX `FK97993BE3D200ED63` (`member_id` ASC) ,
  INDEX `FK97993BE33C8F3EDF` (`friend_id` ASC) ,
  CONSTRAINT `FK97993BE33C8F3EDF`
    FOREIGN KEY (`friend_id` )
    REFERENCES `codeschool`.`member` (`id` ),
  CONSTRAINT `FK97993BE3D200ED63`
    FOREIGN KEY (`member_id` )
    REFERENCES `codeschool`.`member` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`role`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `memo` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `role_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id` (`id` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`member_role`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`member_role` (
  `member_id` INT(11) NOT NULL ,
  `role_id` INT(11) NOT NULL ,
  PRIMARY KEY (`member_id`, `role_id`) ,
  INDEX `FK527E3EFBD200ED63` (`member_id` ASC) ,
  INDEX `FK527E3EFBC14C3623` (`role_id` ASC) ,
  CONSTRAINT `FK527E3EFBC14C3623`
    FOREIGN KEY (`role_id` )
    REFERENCES `codeschool`.`role` (`id` ),
  CONSTRAINT `FK527E3EFBD200ED63`
    FOREIGN KEY (`member_id` )
    REFERENCES `codeschool`.`member` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`post`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`post` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `post_content` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `post_time` DATETIME NULL DEFAULT NULL ,
  `author_id` INT(11) NULL DEFAULT NULL ,
  `section_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `FK3498A0D9F424D2` (`author_id` ASC) ,
  INDEX `FK3498A0E58C3CF6` (`section_id` ASC) ,
  CONSTRAINT `FK3498A0D9F424D2`
    FOREIGN KEY (`author_id` )
    REFERENCES `codeschool`.`member` (`id` ),
  CONSTRAINT `FK3498A0E58C3CF6`
    FOREIGN KEY (`section_id` )
    REFERENCES `codeschool`.`course_section` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`postback`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`postback` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `post_content` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `post_time` DATETIME NULL DEFAULT NULL ,
  `author_id` INT(11) NULL DEFAULT NULL ,
  `original_post_id` BIGINT(20) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `FK2D254D878FF01D75` (`original_post_id` ASC) ,
  INDEX `FK2D254D87D9F424D2` (`author_id` ASC) ,
  CONSTRAINT `FK2D254D878FF01D75`
    FOREIGN KEY (`original_post_id` )
    REFERENCES `codeschool`.`post` (`id` ),
  CONSTRAINT `FK2D254D87D9F424D2`
    FOREIGN KEY (`author_id` )
    REFERENCES `codeschool`.`member` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`recent_activity`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`recent_activity` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `content` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `occurTime` DATETIME NULL DEFAULT NULL ,
  `member_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `FKB434D473D200ED63` (`member_id` ASC) ,
  CONSTRAINT `FKB434D473D200ED63`
    FOREIGN KEY (`member_id` )
    REFERENCES `codeschool`.`member` (`id` ))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`validation_rule`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`validation_rule` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `attr_name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `attr_value` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `output` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `rule_type` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `tag_name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `codeschool`.`section_rule`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `codeschool`.`section_rule` (
  `section_id` INT(11) NOT NULL ,
  `rule_id` INT(11) NOT NULL ,
  UNIQUE INDEX `rule_id` (`rule_id` ASC) ,
  INDEX `FK26C55816E75FD93C` (`rule_id` ASC) ,
  INDEX `FK26C55816E58C3CF6` (`section_id` ASC) ,
  CONSTRAINT `FK26C55816E58C3CF6`
    FOREIGN KEY (`section_id` )
    REFERENCES `codeschool`.`course_section` (`id` ),
  CONSTRAINT `FK26C55816E75FD93C`
    FOREIGN KEY (`rule_id` )
    REFERENCES `codeschool`.`validation_rule` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
