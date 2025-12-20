-- =========================================
-- MariaDB Forward Engineering
-- =========================================

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS;
SET UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE;
SET SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- =========================================
-- Database
-- =========================================
CREATE DATABASE IF NOT EXISTS `db_6_clean_water`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `db_6_clean_water`;

-- =========================================
-- User  (reserved keyword → backticks REQUIRED)
-- =========================================
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id_user` VARCHAR(10) NOT NULL,
  `nama` VARCHAR(60),
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `tgl_lahir` DATE,
  `pekerjaan` VARCHAR(45),
  `bio` TEXT,
  `foto_profil` MEDIUMBLOB,
  `domisili` TEXT,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB;

-- =========================================
-- Admin
-- =========================================
DROP TABLE IF EXISTS `Admin`;
CREATE TABLE `Admin` (
  `id_admin` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255),
  `email` VARCHAR(45),
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB;

-- =========================================
-- Sungai
-- =========================================
DROP TABLE IF EXISTS `Sungai`;
CREATE TABLE `Sungai` (
  `id_sungai` INT NOT NULL,
  `status` ENUM('Bersih','Cukup Bersih','Kurang Bersih','Tercemar'),
  `koordinat` VARCHAR(255),
  `alamat` TEXT NOT NULL,
  `nama_sungai` VARCHAR(60) NOT NULL,
  `gambar_sungai` MEDIUMBLOB,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_sungai`),
  KEY `fk_Sungai_User1_idx` (`id_user`),
  CONSTRAINT `fk_Sungai_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `User` (`id_user`)
) ENGINE=InnoDB;

-- =========================================
-- Data_Baru
-- =========================================
DROP TABLE IF EXISTS `Data_Baru`;
CREATE TABLE `Data_Baru` (
  `id_data_baru` INT NOT NULL,
  `status_data` ENUM('Verifikasi','Menunggu','Tidak Diketahui'),
  `tgl_data` DATETIME NOT NULL,
  `id_admin` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_data_baru`),
  KEY `fk_Data_Baru_Admin1_idx` (`id_admin`),
  CONSTRAINT `fk_Data_Baru_Admin1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `Admin` (`id_admin`)
) ENGINE=InnoDB;

-- =========================================
-- Pemda
-- =========================================
DROP TABLE IF EXISTS `Pemda`;
CREATE TABLE `Pemda` (
  `id_pemda` VARCHAR(45) NOT NULL,
  `dinas_terkait` VARCHAR(45),
  `id_data_baru` INT NOT NULL,
  PRIMARY KEY (`id_pemda`),
  UNIQUE KEY `id_data_baru_UNIQUE` (`id_data_baru`),
  CONSTRAINT `fk_Pemda_Data_Baru1`
    FOREIGN KEY (`id_data_baru`)
    REFERENCES `Data_Baru` (`id_data_baru`)
) ENGINE=InnoDB;

-- =========================================
-- Surat_Penyuluhan
-- =========================================
DROP TABLE IF EXISTS `Surat_Penyuluhan`;
CREATE TABLE `Surat_Penyuluhan` (
  `id_surat` INT NOT NULL,
  `perizinan` MEDIUMBLOB,
  `format_dokumen` MEDIUMBLOB,
  `id_pemda` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_surat`),
  KEY `fk_Surat_Penyuluhan_Pemda1_idx` (`id_pemda`),
  CONSTRAINT `fk_Surat_Penyuluhan_Pemda1`
    FOREIGN KEY (`id_pemda`)
    REFERENCES `Pemda` (`id_pemda`)
) ENGINE=InnoDB;

-- =========================================
-- Verifikasi_email
-- =========================================
DROP TABLE IF EXISTS `Verifikasi_email`;
CREATE TABLE `Verifikasi_email` (
  `id_verifikasi` INT NOT NULL AUTO_INCREMENT,
  `tgl_kirim` DATETIME NOT NULL,
  `tgl_verifikasi` DATETIME DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_verifikasi`),
  KEY `fk_Verifikasi_email_User1_idx` (`id_user`),
  CONSTRAINT `fk_Verifikasi_email_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `User` (`id_user`)
) ENGINE=InnoDB;

-- =========================================
-- Berita
-- =========================================
DROP TABLE IF EXISTS `Berita`;
CREATE TABLE `Berita` (
  `id_berita` INT NOT NULL,
  `tautan` TEXT NOT NULL,
  `gambar` MEDIUMBLOB,
  PRIMARY KEY (`id_berita`)
) ENGINE=InnoDB;

-- =========================================
-- Kuisioner
-- =========================================
DROP TABLE IF EXISTS `Kuisioner`;
CREATE TABLE `Kuisioner` (
  `id_kuisioner` INT NOT NULL,
  `pertanyaan` TEXT,
  PRIMARY KEY (`id_kuisioner`)
) ENGINE=InnoDB;

-- =========================================
-- Komentar
-- =========================================
DROP TABLE IF EXISTS `Komentar`;
CREATE TABLE `Komentar` (
  `id_komentar` INT NOT NULL,
  `isi_komentar` TEXT,
  `id_user` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_komentar`),
  KEY `fk_Komentar_User1_idx` (`id_user`),
  CONSTRAINT `fk_Komentar_User1`
    FOREIGN KEY (`id_user`)
    REFERENCES `User` (`id_user`)
) ENGINE=InnoDB;

-- =========================================
-- Jawaban
-- =========================================
DROP TABLE IF EXISTS `Jawaban`;
CREATE TABLE `Jawaban` (
  `id_kuisioner` INT NOT NULL,
  `id_user` VARCHAR(10) NOT NULL,
  `jawaban` ENUM('Sangat Setuju','Setuju','Kurang Setuju','Tidak Setuju'),
  PRIMARY KEY (`id_kuisioner`,`id_user`),
  CONSTRAINT `fk_Jawaban_Kuisioner`
    FOREIGN KEY (`id_kuisioner`)
    REFERENCES `Kuisioner` (`id_kuisioner`),
  CONSTRAINT `fk_Jawaban_User`
    FOREIGN KEY (`id_user`)
    REFERENCES `User` (`id_user`)
) ENGINE=InnoDB;

-- =========================================
-- Laporan
-- =========================================
DROP TABLE IF EXISTS `Laporan`;
CREATE TABLE `Laporan` (
  `id_admin` VARCHAR(10) NOT NULL,
  `id_sungai` INT NOT NULL,
  `tgl_lapor` DATETIME NOT NULL,
  `attachment` MEDIUMBLOB,
  PRIMARY KEY (`id_admin`,`id_sungai`),
  CONSTRAINT `fk_Laporan_Admin`
    FOREIGN KEY (`id_admin`)
    REFERENCES `Admin` (`id_admin`),
  CONSTRAINT `fk_Laporan_Sungai`
    FOREIGN KEY (`id_sungai`)
    REFERENCES `Sungai` (`id_sungai`)
) ENGINE=InnoDB;

-- =========================================
-- Triggers (MariaDB-safe)
-- =========================================
DELIMITER $$

DROP TRIGGER IF EXISTS `User_AFTER_INSERT`$$
CREATE TRIGGER `User_AFTER_INSERT`
AFTER INSERT ON `User`
FOR EACH ROW
BEGIN
  INSERT INTO Verifikasi_email (tgl_kirim, email, id_user)
  VALUES (CURRENT_TIMESTAMP, NEW.email, NEW.id_user);
END$$

DROP TRIGGER IF EXISTS `Sungai_AFTER_INSERT`$$
CREATE TRIGGER `Sungai_AFTER_INSERT`
AFTER INSERT ON `Sungai`
FOR EACH ROW
BEGIN
  INSERT INTO Laporan (id_sungai, tgl_lapor, attachment)
  VALUES (NEW.id_sungai, CURRENT_TIMESTAMP, NEW.gambar_sungai);
END$$

DELIMITER ;

-- =========================================
-- Restore Settings
-- =========================================
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

