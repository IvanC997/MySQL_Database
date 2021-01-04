-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BazaVK
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BazaVK
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BazaVK` DEFAULT CHARACTER SET utf8 ;
USE `BazaVK` ;

-- -----------------------------------------------------
-- Table `BazaVK`.`Status_zaposlenih`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Status_zaposlenih` (
  `id_Statusa` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Statusa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`VideoKlub(Radnja)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`VideoKlub(Radnja)` (
  `id_radnje` INT NOT NULL AUTO_INCREMENT,
  `AdresaLokala` VARCHAR(45) NOT NULL,
  `Naziv_lokala` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_radnje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Zaposleni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Zaposleni` (
  `id_Zaposleni` INT NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NOT NULL,
  `Adresa` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `Br_Telefona` VARCHAR(45) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Status_zaposlenih_id_Statusa` INT NOT NULL,
  `VideoKlub(Radnja)_id_radnje` INT NOT NULL,
  PRIMARY KEY (`id_Zaposleni`),
  INDEX `fk_Zaposleni_Status_zaposlenih1_idx` (`Status_zaposlenih_id_Statusa` ASC) VISIBLE,
  INDEX `fk_Zaposleni_VideoKlub(Radnja)1_idx` (`VideoKlub(Radnja)_id_radnje` ASC) VISIBLE,
  CONSTRAINT `fk_Zaposleni_Status_zaposlenih1`
    FOREIGN KEY (`Status_zaposlenih_id_Statusa`)
    REFERENCES `BazaVK`.`Status_zaposlenih` (`id_Statusa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zaposleni_VideoKlub(Radnja)1`
    FOREIGN KEY (`VideoKlub(Radnja)_id_radnje`)
    REFERENCES `BazaVK`.`VideoKlub(Radnja)` (`id_radnje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Clanovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Clanovi` (
  `id_Clana` INT NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NOT NULL,
  `Adresa` VARCHAR(45) NOT NULL,
  `Br_Telefona` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Datum_Uclanjenja` DATE NOT NULL,
  `Status(Aktivan/Inaktivan)` TINYINT NOT NULL,
  `VideoKlub(Radnja)_id_radnje` INT NOT NULL,
  PRIMARY KEY (`id_Clana`),
  INDEX `fk_Clanovi_VideoKlub(Radnja)1_idx` (`VideoKlub(Radnja)_id_radnje` ASC) VISIBLE,
  CONSTRAINT `fk_Clanovi_VideoKlub(Radnja)1`
    FOREIGN KEY (`VideoKlub(Radnja)_id_radnje`)
    REFERENCES `BazaVK`.`VideoKlub(Radnja)` (`id_radnje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Kategorija/Zanr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Kategorija/Zanr` (
  `id_kategorije` INT NOT NULL AUTO_INCREMENT,
  `NazivKategorije` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_kategorije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Filmovi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Filmovi` (
  `id_Filma` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NOT NULL,
  `GodinaIzdanja` INT NOT NULL,
  `Reziser` VARCHAR(45) NOT NULL,
  `Ocena` VARCHAR(45) NOT NULL,
  `KratakOpis` VARCHAR(255) NULL,
  `Jezik` VARCHAR(45) NOT NULL,
  `Format(2D,3D,4D)` VARCHAR(45) NOT NULL,
  `DuzinaTrajanja` TIME NOT NULL,
  `Kategorija/Zanr_id_kategorije` INT NOT NULL,
  `Poslednji_unos` DATETIME NULL,
  PRIMARY KEY (`id_Filma`),
  INDEX `fk_Filmovi_Kategorija/Zanr1_idx` (`Kategorija/Zanr_id_kategorije` ASC) VISIBLE,
  CONSTRAINT `fk_Filmovi_Kategorija/Zanr1`
    FOREIGN KEY (`Kategorija/Zanr_id_kategorije`)
    REFERENCES `BazaVK`.`Kategorija/Zanr` (`id_kategorije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Tarifa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Tarifa` (
  `id_Tarife` INT NOT NULL,
  `Tarifa` VARCHAR(45) NOT NULL,
  `Rok_Vracanja` VARCHAR(45) NOT NULL,
  `CenaZamene/Nadoknade` DECIMAL NOT NULL,
  PRIMARY KEY (`id_Tarife`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Evidencioni_Karton`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Evidencioni_Karton` (
  `id_kartona` INT NOT NULL AUTO_INCREMENT,
  `Clanovi_id_Clana` INT NOT NULL,
  `Tarifa_id_Tarife` INT NOT NULL,
  `Filmovi_id_Filma` INT NOT NULL,
  PRIMARY KEY (`id_kartona`),
  INDEX `fk_Iznajmljivanje_Clanovi1_idx` (`Clanovi_id_Clana` ASC) VISIBLE,
  INDEX `fk_Iznajmljivanje_Tarifa1_idx` (`Tarifa_id_Tarife` ASC) VISIBLE,
  INDEX `fk_Iznajmljivanje_Filmovi1_idx` (`Filmovi_id_Filma` ASC) VISIBLE,
  CONSTRAINT `fk_Iznajmljivanje_Clanovi1`
    FOREIGN KEY (`Clanovi_id_Clana`)
    REFERENCES `BazaVK`.`Clanovi` (`id_Clana`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Iznajmljivanje_Tarifa1`
    FOREIGN KEY (`Tarifa_id_Tarife`)
    REFERENCES `BazaVK`.`Tarifa` (`id_Tarife`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Iznajmljivanje_Filmovi1`
    FOREIGN KEY (`Filmovi_id_Filma`)
    REFERENCES `BazaVK`.`Filmovi` (`id_Filma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BazaVK`.`Stanje_Filmova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BazaVK`.`Stanje_Filmova` (
  `id_Stanja` INT NOT NULL AUTO_INCREMENT,
  `VideoKlub(Radnja)_id_radnje` INT NOT NULL,
  `Filmovi_id_Filma` INT NOT NULL,
  `Kolicina` INT NOT NULL,
  PRIMARY KEY (`id_Stanja`),
  INDEX `fk_Stanje_Filmova_Filmovi1_idx` (`Filmovi_id_Filma` ASC) VISIBLE,
  INDEX `fk_Stanje_Filmova_VideoKlub(Radnja)1_idx` (`VideoKlub(Radnja)_id_radnje` ASC) VISIBLE,
  CONSTRAINT `fk_Stanje_Filmova_Filmovi1`
    FOREIGN KEY (`Filmovi_id_Filma`)
    REFERENCES `BazaVK`.`Filmovi` (`id_Filma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stanje_Filmova_VideoKlub(Radnja)1`
    FOREIGN KEY (`VideoKlub(Radnja)_id_radnje`)
    REFERENCES `BazaVK`.`VideoKlub(Radnja)` (`id_radnje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
