DROP SCHEMA IF EXISTS `library` ;
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `library` ;
DROP TABLE IF EXISTS `library`.`administrators` ;
CREATE TABLE IF NOT EXISTS `library`.`administrators` (
  `id` INT NOT NULL,
  `logins` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`readers` ;
CREATE TABLE IF NOT EXISTS `library`.`readers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `passport` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`rooms` ;
CREATE TABLE IF NOT EXISTS `library`.`rooms` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`librarians` ;
CREATE TABLE IF NOT EXISTS `library`.`librarians` (
  `id` INT NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`books` ;
CREATE TABLE IF NOT EXISTS `library`.`books` (
  `id` INT NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `publication_year` INT NOT NULL,
  `publisher` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `isbn` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`librarian_rooms` ;
CREATE TABLE IF NOT EXISTS `library`.`librarian_rooms` (
  `id_room` INT NOT NULL,
  `id_librarian` INT NOT NULL,
  PRIMARY KEY (`id_room`, `id_librarian`),
  INDEX `id_librarian_idx` (`id_librarian` ASC),
  CONSTRAINT `id_lr_room`
    FOREIGN KEY (`id_room`)
    REFERENCES `library`.`rooms` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_lr_librarian`
    FOREIGN KEY (`id_librarian`)
    REFERENCES `library`.`librarians` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = tis620
COLLATE = tis620_bin;
DROP TABLE IF EXISTS `library`.`booking_cards` ;
CREATE TABLE IF NOT EXISTS `library`.`booking_cards` (
  `id` INT NOT NULL,
  `id_reader` INT NOT NULL,
  `id_book` INT NOT NULL,
  `id_librarian` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `period` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `id_reader_idx` (`id_reader` ASC),
  INDEX `id_book_idx` (`id_book` ASC),
  INDEX `id_librarian_idx` (`id_librarian` ASC),
  CONSTRAINT `id_bc_reader`
    FOREIGN KEY (`id_reader`)
    REFERENCES `library`.`readers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_bc_book`
    FOREIGN KEY (`id_book`)
    REFERENCES `library`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_bc_librarian`
    FOREIGN KEY (`id_librarian`)
    REFERENCES `library`.`librarians` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`issue_cards` ;
CREATE TABLE IF NOT EXISTS `library`.`issue_cards` (
  `id` INT NOT NULL,
  `id_reader` INT NOT NULL,
  `id_book` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `period` DATETIME NULL,
  `issue_cardscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `id_reader_idx` (`id_reader` ASC),
  INDEX `id_book_idx` (`id_book` ASC),
  CONSTRAINT `id_ic_reader`
    FOREIGN KEY (`id_reader`)
    REFERENCES `library`.`readers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_ic_book`
    FOREIGN KEY (`id_book`)
    REFERENCES `library`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
DROP TABLE IF EXISTS `library`.`book_places` ;
CREATE TABLE IF NOT EXISTS `library`.`book_places` (
  `id_book` INT NULL,
  `id_room` INT NOT NULL,
  `quantity` INT NOT NULL,
  `shell_number` INT NOT NULL,
  PRIMARY KEY (`id_book`, `id_room`),
  INDEX `id_room_idx` (`id_room` ASC),
  CONSTRAINT `id_bp_book`
    FOREIGN KEY (`id_book`)
    REFERENCES `library`.`books` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_bp_room`
    FOREIGN KEY (`id_room`)
    REFERENCES `library`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;