-- Police -- 

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'LSPD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Cadet',2000,'{}','{}'),
	('police',1,'officer','Officier',2000,'{}','{}'),
	('police',2,'sergeant','Sergent',2000,'{}','{}'),
  ('police',3,'sergent_chief','Sergent-Chef',2000,'{}','{}'),
	('police',4,'lieutenant','Lieutenant',2000,'{}','{}'),
  ('police',5,'lieutenant_chief','Lieutenant-Chef',2000,'{}','{}'),
  ('police',6,'captain','Capitaine',2000,'{}','{}'),
  ('police',7,'boss','Commandant',2000,'{}','{}')
;

-- Taxi -- 

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('taxi', 'Taxi')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('taxi',0,'recrue','Recrue',12, '{}','{}'),
	('taxi',1,'novice','Novice',24, '{}','{}'),
	('taxi',2,'experimente','Experimente',36, '{}','{}'),
	('taxi',3,'uber','Uber',48,  '{}','{}'),
	('taxi',4,'boss','Patron',0, '{}','{}')
;

-- Unicorn 



INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_unicorn', 'Unicorn', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_unicorn', 'Unicorn', 1),
  ('society_unicorn_fridge', 'Unicorn (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_unicorn', 'Unicorn', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('unicorn', 'Unicorn')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('unicorn', 0, 'barman', 'Barman', 300, '{}', '{}'),
  ('unicorn', 1, 'dancer', 'Danseur', 300, '{}', '{}'),
  ('unicorn', 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  ('unicorn', 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('rhum', 'Rhum', 5),
    ('martini', 'Martini blanc', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'Jus de fruits', 5),
    ('icetea', 'Ice Tea', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Limonade', 5),
    ('bolcacahuetes', 'Bol de cacahuètes', 5),
    ('bolnoixcajou', 'Bol de noix de cajou', 5),
    ('bolpistache', 'Bol de pistaches', 5),
    ('bolchips', 'Bol de chips', 5),
    ('saucisson', 'Saucisson', 5),
    ('grapperaisin', 'Grappe de raisin', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-coca', 5),
    ('vodkaenergy', 'Vodka-energy', 5),
    ('vodkafruit', 'Vodka-jus de fruits', 5),
    ('rhumfruit', 'Rhum-jus de fruits', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rhum-coca', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Glaçon', 5),
    ('mixapero', 'Mix Apéritif', 3),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('menthe', 'Feuille de menthe', 10)
;

-- Concess

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_concess', 'Concessionnaire', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_concess', 'name', 1),
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_concess', 'name', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('concess', 'name')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('concess', 0, 'seller', 'Vendeur', 300, '{}', '{}'),
  ('concess', 1, 'experiment', 'Expérimenter', 300, '{}', '{}'),
  ('concess', 2, 'viceboss', 'Co-Patron', 500, '{}', '{}'),
  ('concess', 3, 'boss', 'Patron', 600, '{}', '{}')
;

CREATE TABLE `veh_concess` (
  `id` int(11) NOT NULL,
  `plate` longtext NOT NULL,
  `price` longtext DEFAULT NULL,
  `plate` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `veh_concess`
  ADD PRIMARY KEY (`id`)
;

ALTER TABLE `veh_concess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

-- Mecano 


INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_mecano', 'Mecano', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_mecano', 'Mecano', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_mecano', 'Mecano', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('mecano', 'Mécano')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('mecano', 1, 'apprentice', 'Apprentie', 200, '{}', '{}'),
  ('mecano', 1, 'mechanic', 'Mécanicien', 300, '{}', '{}'),
  ('mecano', 2, 'workshop', "Chef d'atelier", 300, '{}', '{}'),
  ('mecano', 3, 'viceboss', "Chef d'équipe", 500, '{}', '{}'),
  ('mecano', 4, 'boss', 'Patron', 600, '{}', '{}')
;

-- Ambulance 

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('ambulance', 'Ambulance')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('ambulance', 1, 'apprentice', 'Apprentie', 200, '{}', '{}'),
  ('ambulance', 1, 'doctor', 'Médecin', 300, '{}', '{}'),
  ('ambulance', 2, 'surgeon', "Chirurgien", 300, '{}', '{}'),
  ('ambulance', 3, 'viceboss', "Co-Patron", 500, '{}', '{}'),
  ('ambulance', 4, 'boss', 'Patron', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('medikit', 'Kit de réanimation', 5),
    ('bandage', 'Bandage', 5)
;


ALTER TABLE `users`
	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'
;

CREATE TABLE `appel_ems` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coord` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `state` TINYINT(1) NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `appel_ems`
  ADD PRIMARY KEY (`id`)
;

ALTER TABLE `appel_ems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;