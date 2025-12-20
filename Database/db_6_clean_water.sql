-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_6_clean_water
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_6_clean_water
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_6_clean_water` DEFAULT CHARACTER SET utf8 ;
USE `db_6_clean_water` ;

-- -----------------------------------------------------
-- Table `db_6_clean_water`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`User` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`User` (
  `id_user` VARCHAR(10) NOT NULL,
  `nama` VARCHAR(60) NULL,
  `password` VARCHAR(16) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tgl_lahir` DATE NULL,
  `pekerjaan` VARCHAR(45) NULL,
  `bio` TEXT NULL,
  `foto_profil` MEDIUMBLOB NULL,
  `domisili` TEXT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Sungai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Sungai` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Sungai` (
  `id_sungai` INT NOT NULL,
  `status` ENUM('Bersih', 'Cukup Bersih', 'Kurang Bersiih', 'Tercemar') NULL,
  `koordinat` VARCHAR(255) NULL,
  `alamat` TEXT NOT NULL,
  `nama_sungai` VARCHAR(60) NOT NULL,
  `gambar_sungai` MEDIUMBLOB NULL,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_sungai`),
  INDEX `fk_Sungai_User1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Sungai_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_6_clean_water`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Admin` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Admin` (
  `id_admin` VARCHAR(10) NOT NULL,
  `password` VARCHAR(16) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id_admin`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Data_Baru`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Data_Baru` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Data_Baru` (
  `id_data_baru` INT NOT NULL,
  `status_data` ENUM('Verifikasi', 'Menunggu', 'Tidak Diketahui') NULL,
  `tgl_data` DATETIME NOT NULL,
  `id_admin` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_data_baru`, `id_admin`),
  INDEX `fk_Data_Baru_Admin1_idx` (`id_admin` ASC) VISIBLE,
  UNIQUE INDEX `id_data_baru_UNIQUE` (`id_data_baru` ASC) VISIBLE,
  CONSTRAINT `fk_Data_Baru_Admin1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `db_6_clean_water`.`Admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Pemda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Pemda` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Pemda` (
  `id_pemda` VARCHAR(45) NOT NULL,
  `dinas_terkait` VARCHAR(45) NULL,
  `id_data_baru` INT NOT NULL,
  PRIMARY KEY (`id_pemda`),
  INDEX `fk_Pemda_Data_Baru1_idx` (`id_data_baru` ASC) VISIBLE,
  UNIQUE INDEX `id_data_baru_UNIQUE` (`id_data_baru` ASC) VISIBLE,
  CONSTRAINT `fk_Pemda_Data_Baru1`
    FOREIGN KEY (`id_data_baru`)
    REFERENCES `db_6_clean_water`.`Data_Baru` (`id_data_baru`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Surat_Penyuluhan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Surat_Penyuluhan` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Surat_Penyuluhan` (
  `id_surat` INT NOT NULL,
  `perizinan` MEDIUMBLOB NULL,
  `format_dokumen` MEDIUMBLOB NULL,
  `id_pemda` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_surat`, `id_pemda`),
  INDEX `fk_Surat_Penyuluhan_Pemda1_idx` (`id_pemda` ASC) VISIBLE,
  CONSTRAINT `fk_Surat_Penyuluhan_Pemda1`
    FOREIGN KEY (`id_pemda`)
    REFERENCES `db_6_clean_water`.`Pemda` (`id_pemda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Verifikasi_email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Verifikasi_email` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Verifikasi_email` (
  `id_verifikasi` INT NOT NULL AUTO_INCREMENT,
  `tgl_kirim` DATETIME NOT NULL,
  `tgl_verifikasi` DATETIME NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_verifikasi`, `id_user`),
  INDEX `fk_Verifikasi_email_User1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Verifikasi_email_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_6_clean_water`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Berita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Berita` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Berita` (
  `id_berita` INT NOT NULL,
  `tautan` TEXT NOT NULL,
  `gambar` MEDIUMBLOB NULL,
  PRIMARY KEY (`id_berita`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Kuisioner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Kuisioner` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Kuisioner` (
  `id_kuisioner` INT NOT NULL,
  `pertanyaan` TEXT NULL,
  PRIMARY KEY (`id_kuisioner`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Komentar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Komentar` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Komentar` (
  `id_komentar` INT NOT NULL,
  `isi_komentar` TEXT NULL,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_komentar`, `id_user`),
  INDEX `fk_Komentar_User1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Komentar_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_6_clean_water`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Jawaban`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Jawaban` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Jawaban` (
  `id_kuisioner` INT NOT NULL,
  `id_user` VARCHAR(10) NOT NULL,
  `jawaban` ENUM('Sangat Setuju', 'Setuju', 'Kurang Setuju', 'Tidak Setuju') NULL,
  PRIMARY KEY (`id_kuisioner`, `id_user`),
  INDEX `fk_Kuisioner_has_User_User1_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_Kuisioner_has_User_Kuisioner1_idx` (`id_kuisioner` ASC) VISIBLE,
  CONSTRAINT `fk_Kuisioner_has_User_Kuisioner1`
    FOREIGN KEY (`id_kuisioner`)
    REFERENCES `db_6_clean_water`.`Kuisioner` (`id_kuisioner`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kuisioner_has_User_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_6_clean_water`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_6_clean_water`.`Laporan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_6_clean_water`.`Laporan` ;

CREATE TABLE IF NOT EXISTS `db_6_clean_water`.`Laporan` (
  `id_admin` VARCHAR(10) NOT NULL,
  `id_sungai` INT NOT NULL,
  `tgl_lapor` DATETIME NOT NULL,
  `attachment` MEDIUMBLOB NULL,
  PRIMARY KEY (`id_admin`, `id_sungai`),
  INDEX `fk_Admin_has_Sungai_Sungai1_idx` (`id_sungai` ASC) VISIBLE,
  INDEX `fk_Admin_has_Sungai_Admin1_idx` (`id_admin` ASC) VISIBLE,
  CONSTRAINT `fk_Admin_has_Sungai_Admin1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `db_6_clean_water`.`Admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Admin_has_Sungai_Sungai1`
    FOREIGN KEY (`id_sungai`)
    REFERENCES `db_6_clean_water`.`Sungai` (`id_sungai`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db_6_clean_water`;

DELIMITER $$

USE `db_6_clean_water`$$
DROP TRIGGER IF EXISTS `db_6_clean_water`.`User_AFTER_INSERT` $$
USE `db_6_clean_water`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_6_clean_water`.`User_AFTER_INSERT` AFTER INSERT ON `User` FOR EACH ROW
BEGIN
	Insert into Verifikasi_email (tgl_kirim,email,id_user) values
    (current_timestamp(),NEW.email,NEW.id_user);
END$$


USE `db_6_clean_water`$$
DROP TRIGGER IF EXISTS `db_6_clean_water`.`Sungai_AFTER_INSERT` $$
USE `db_6_clean_water`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_6_clean_water`.`Sungai_AFTER_INSERT` AFTER INSERT ON `Sungai` FOR EACH ROW
BEGIN
	insert into Laporan (id_sungai,tgl_lapor,attachment)
    values (NEW.id_sungai,current_timestamp(),NEW.gambar_sungai);
END$$


DELIMITER ;
SET SQL_MODE = '';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

