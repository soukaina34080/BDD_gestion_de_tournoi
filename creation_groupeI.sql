/*
FIchier : Creation_GroupeI.sql
Auteurs : 
Chaima ABRADI 21700074
Soukaina MESSAOUDI 21603069
Nom du groupe : I
*/


DROP DATABASE IF EXISTS `bddtournoi`;
CREATE DATABASE `bddtournoi`;
USE `bddtournoi`;

DROP TABLE IF EXISTS `evenement`;
DROP TABLE IF EXISTS `organisateur`;
DROP TABLE IF EXISTS `formule_sportive`;
DROP TABLE IF EXISTS `terrain`;
DROP TABLE IF EXISTS `equipe`;
DROP TABLE IF EXISTS `joueur`;
DROP TABLE IF EXISTS `tournoi`;
DROP TABLE IF EXISTS `tour`;
DROP TABLE IF EXISTS `poule`;
DROP TABLE IF EXISTS `_match`;
DROP TABLE IF EXISTS `_set`;
DROP TABLE IF EXISTS `utilise`;
DROP TABLE IF EXISTS `inscrit`;
DROP TABLE IF EXISTS `participe_au_set`;
DROP TABLE IF EXISTS `participe_au_match`;
DROP TABLE IF EXISTS `match_statut`;
DROP TABLE IF EXISTS `tournoi_statut`;
DROP TABLE IF EXISTS `type_de_jeu`;


CREATE TABLE organisateur(
   id_organisateur VARCHAR(50),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   mail VARCHAR(50),
   PRIMARY KEY(id_organisateur)
);

CREATE TABLE formule_sportive(
   id_formule_sportive VARCHAR(50),
   PRIMARY KEY(id_formule_sportive)
);

CREATE TABLE terrain(
   id_terrain VARCHAR(50),
   type VARCHAR(50),
   PRIMARY KEY(id_terrain)
);

CREATE TABLE equipe(
   id_equipe VARCHAR(50),
   nom VARCHAR(50) NOT NULL,
   niveau INT CHECK (niveau BETWEEN 1 and 5),
   PRIMARY KEY(id_equipe)
);

CREATE TABLE joueur(
   id_joueur VARCHAR(50),
   niveau VARCHAR(50),
   id_equipe VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_joueur),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe)
);

CREATE TABLE tournoi_statut(
   id_tournoi_statut VARCHAR(50),
   description VARCHAR(50),
   PRIMARY KEY(id_tournoi_statut)
);

CREATE TABLE match_statut(
   id_match_statut VARCHAR(50),
   description VARCHAR(50),
   PRIMARY KEY(id_match_statut)
);

CREATE TABLE type_de_jeu(
   id_type_de_jeu VARCHAR(50),
   description VARCHAR(50),
   PRIMARY KEY(id_type_de_jeu)
);

CREATE TABLE evenement(
   id_evenement INTEGER AUTO_INCREMENT,
   nb_tournois INT,
   id_organisateur VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_evenement),
   FOREIGN KEY(id_organisateur) REFERENCES organisateur(id_organisateur)
);

CREATE TABLE tournoi(
   id_tournoi INTEGER AUTO_INCREMENT,
   nom VARCHAR(50),
   lieu VARCHAR(50),
   date_ VARCHAR(50),
   id_type_de_jeu VARCHAR(50) NOT NULL,
   id_tournoi_statut VARCHAR(50) NOT NULL,
   id_evenement INTEGER NOT NULL,
   PRIMARY KEY(id_tournoi),
   FOREIGN KEY(id_type_de_jeu) REFERENCES type_de_jeu(id_type_de_jeu),
   FOREIGN KEY(id_tournoi_statut) REFERENCES tournoi_statut(id_tournoi_statut),
   FOREIGN KEY(id_evenement) REFERENCES evenement(id_evenement)
);

CREATE TABLE tour(
   id_tour VARCHAR(50),
   id_equipe VARCHAR(50) NOT NULL,
   id_formule_sportive VARCHAR(50) NOT NULL,
   id_tournoi INTEGER NOT NULL,
   PRIMARY KEY(id_tour),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe),
   FOREIGN KEY(id_formule_sportive) REFERENCES formule_sportive(id_formule_sportive),
   FOREIGN KEY(id_tournoi) REFERENCES tournoi(id_tournoi)
);

CREATE TABLE poule(
   id_poule VARCHAR(50),
   id_tour VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_poule),
   FOREIGN KEY(id_tour) REFERENCES tour(id_tour)
);

CREATE TABLE _match(
   id_match VARCHAR(50),
   score VARCHAR(50),
   id_match_statut VARCHAR(50) NOT NULL,
   id_poule VARCHAR(50) NOT NULL,
   id_equipe VARCHAR(50) NOT NULL,
   id_tournoi INTEGER NOT NULL,
   PRIMARY KEY(id_match),
   FOREIGN KEY(id_match_statut) REFERENCES match_statut(id_match_statut),
   FOREIGN KEY(id_poule) REFERENCES poule(id_poule),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe),
   FOREIGN KEY(id_tournoi) REFERENCES tournoi(id_tournoi)
);

CREATE TABLE _set(
   id_set VARCHAR(50),
   score VARCHAR(50),
   id_equipe VARCHAR(50) NOT NULL,
   id_match VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_set),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe),
   FOREIGN KEY(id_match) REFERENCES _match(id_match)
);


CREATE TABLE utilise(
   id_poule VARCHAR(50),
   id_terrain VARCHAR(50),
   PRIMARY KEY(id_poule, id_terrain),
   FOREIGN KEY(id_poule) REFERENCES poule(id_poule),
   FOREIGN KEY(id_terrain) REFERENCES terrain(id_terrain)
);

CREATE TABLE inscrit(
   id_tournoi INTEGER,
   id_equipe VARCHAR(50),
   PRIMARY KEY(id_tournoi, id_equipe),
   FOREIGN KEY(id_tournoi) REFERENCES tournoi(id_tournoi),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe)
);

CREATE TABLE participe_au_set(
   id_equipe VARCHAR(50),
   id_set VARCHAR(50),
   PRIMARY KEY(id_equipe, id_set),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe),
   FOREIGN KEY(id_set) REFERENCES _set(id_set)
);

CREATE TABLE participe_au_match(
   id_equipe VARCHAR(50),
   id_match VARCHAR(50),
   PRIMARY KEY(id_equipe, id_match),
   FOREIGN KEY(id_equipe) REFERENCES equipe(id_equipe),
   FOREIGN KEY(id_match) REFERENCES _match(id_match)
);

CREATE TABLE LOGERROR  (
  ID INT(11) AUTO_INCREMENT,
  MESSAGE VARCHAR(255) DEFAULT NULL,
  THETIME TIMESTAMP,
  CONSTRAINT PK_LOGERROR PRIMARY KEY (ID)
);

/* 
Insertion de tuples dans les relations
*/

INSERT INTO organisateur VALUES ('11', 'DUPONT', 'PAUL','dupont.paul@email.com');
INSERT INTO organisateur VALUES ('22', 'MARTIN', 'BERNARD','martin.bernard@email.com');
INSERT INTO organisateur VALUES ('33', 'PETIT', 'THOMAS','petit.thomas@email.com');

INSERT INTO evenement (nb_tournois, id_organisateur) VALUES(3, '11');
INSERT INTO evenement (nb_tournois, id_organisateur) VALUES(2, '22');
INSERT INTO evenement (nb_tournois, id_organisateur) VALUES(1, '33');

INSERT INTO formule_sportive VALUES ('1*1');
INSERT INTO formule_sportive VALUES ('2*2');
INSERT INTO formule_sportive VALUES ('3*3');

INSERT INTO terrain VALUES ('12','terrain_de_football');
INSERT INTO terrain VALUES ('34','terrain_de_tennis');
INSERT INTO terrain VALUES ('56','terrain_de_basket');

INSERT INTO type_de_jeu VALUES ('1', '3_JOUEURS');
INSERT INTO type_de_jeu VALUES ('2', '2_JOUEURS');
INSERT INTO type_de_jeu VALUES ('3', '4_JOUEURS');

INSERT INTO tournoi_statut VALUES ('1', 'FINI');
INSERT INTO tournoi_statut VALUES ('2', 'CLOTURE');
INSERT INTO tournoi_statut VALUES ('3', 'OUVERT');

INSERT INTO tournoi (nom, lieu, date_, id_tournoi_statut, id_type_de_jeu, id_evenement)
VALUES ('tournoi_de_tennis', 'Paris', '22-10-2021','1', '1', 1);
INSERT INTO tournoi (nom, lieu, date_, id_tournoi_statut, id_type_de_jeu, id_evenement)
VALUES ('tournoi_de_football', 'Paris','22-08-2021','2', '2', 1);
INSERT INTO tournoi(nom, lieu, date_, id_tournoi_statut, id_type_de_jeu, id_evenement)
VALUES ('tournoi_de_basket', 'Paris', '22-10-2021','3', '3', 1);

INSERT INTO equipe VALUES ('34','Les_bleus',2);
INSERT INTO equipe VALUES ('54','Les_rouges',3);
INSERT INTO equipe VALUES ('78','Les_verts',5);

INSERT INTO joueur VALUES ( '77','regional','34');
INSERT INTO joueur VALUES ( '79','loisir','78');
INSERT INTO joueur VALUES ( '9','regional','54');

INSERT INTO tour VALUES ('09', '34', '1*1', 1);
INSERT INTO tour VALUES ('08', '54', '2*2', 1);
INSERT INTO tour VALUES ('07', '78', '3*3', 1);

INSERT INTO poule VALUES ('poule_1','09');
INSERT INTO poule VALUES ('poule_2','08');
INSERT INTO poule VALUES ('poule_3','07');

INSERT INTO match_statut VALUES ('1', 'PAS_JOUE');
INSERT INTO match_statut VALUES ('2', 'EN_COURS');
INSERT INTO match_statut VALUES ('3', 'FINI');

INSERT INTO _match VALUES('AA','4','1','poule_1','34',2);
INSERT INTO _match VALUES('BB','6','2','poule_1','34',2);
INSERT INTO _match VALUES('CC','9','3','poule_2','54',2);
INSERT INTO _match VALUES('DD','3','3','poule_2','54',2);
INSERT INTO _match VALUES('FF','10','3','poule_3','78',2);
INSERT INTO _match VALUES('VV','2','3','poule_3','78',2);

INSERT INTO _set VALUES('3','8', '34' ,'AA');
INSERT INTO _set VALUES('5','7', '54' ,'BB');
INSERT INTO _set VALUES('9','10', '78' ,'CC');
INSERT INTO _set VALUES('7','5', '34' ,'CC');

INSERT INTO utilise VALUES('poule_1','12');
INSERT INTO utilise VALUES('poule_1','34');
INSERT INTO utilise VALUES('poule_2','56');

INSERT INTO inscrit VALUES(1,'34');
INSERT INTO inscrit VALUES(1,'54');
INSERT INTO inscrit VALUES(1,'78');

INSERT INTO participe_au_set VALUES('34','3');
INSERT INTO participe_au_set VALUES('54','9');
INSERT INTO participe_au_set VALUES('78','7');
INSERT INTO participe_au_set VALUES('78','3');

INSERT INTO participe_au_match VALUES('54','AA');
INSERT INTO participe_au_match VALUES('34','BB ');
INSERT INTO participe_au_match VALUES('78','AA');
INSERT INTO participe_au_match VALUES('34','CC ');

/*
Définition de functions ou procedures
*/



DROP FUNCTION IF EXISTS nouveau_evenement; /*nom de fontion nouveau evenement*/
DELIMITER $$ 
CREATE FUNCTION nouveau_evenement (p_id_organisateur VARCHAR(50), p_lieu VARCHAR(50), p_date_ VARCHAR(50), p_type_de_jeu VARCHAR(50))
RETURNS VARCHAR(100) -- on renvoit l'identifiant du nouvel evenement
DETERMINISTIC 
BEGIN
    DECLARE p_id_tournoi_statut VARCHAR(50);
    DECLARE p_id_evenement INTEGER;
    DECLARE p_id_type_de_jeu VARCHAR(50);
    DECLARE organisateur_exist INTEGER;
    DECLARE type_de_jeu_exist INTEGER;
	SET @organisateur_exist = (SELECT COUNT(*) FROM organisateur WHERE id_organisateur = p_id_organisateur);
	IF @organisateur_exist = 0 THEN
		RETURN ('ID ORGANISATEUR SPECIFIE DANS LES PARAMETRES NEXISTE PAS');
	END IF;
	SET @type_de_jeu_exist = (SELECT COUNT(*) FROM type_de_jeu WHERE description = p_type_de_jeu);
	IF @type_de_jeu_exist = 0 THEN
		RETURN ('TYPE DE JEU SPECIFIE DANS LES PARAMETRES NEXISTE PAS');
	END IF;
    SET p_id_tournoi_statut = (SELECT id_tournoi_statut FROM tournoi_statut WHERE description = 'OUVERT');
    IF @id_tournoi_statut = 0 THEN
		RETURN ('UNE ERREUR BIZARRE SEST PRODUITE');
	END IF;
    SET p_id_type_de_jeu = (SELECT id_type_de_jeu FROM type_de_jeu WHERE description = p_type_de_jeu);     
    INSERT INTO evenement (nb_tournois, id_organisateur) VALUES (1, p_id_organisateur);
    SET @p_id_evenement = (SELECT MAX(id_evenement) FROM evenement);
    INSERT INTO tournoi (lieu, nom, date_, id_evenement, id_tournoi_statut, id_type_de_jeu)
    VALUES (p_lieu, 'TOURNOI_INITIAL', p_date_, @p_id_evenement, p_id_tournoi_statut, p_id_type_de_jeu);
    RETURN ('LA CREATION DEVENEMENT ET SON TOURNOI INITIAL EFFECTUEE AVEC SUCCES');
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS inscription_equipe_dans_un_tournoi;
DELIMITER $$ 
CREATE FUNCTION inscription_equipe_dans_un_tournoi (p_id_equipe VARCHAR(50), p_id_tournoi INTEGER)
RETURNS VARCHAR(50)
DETERMINISTIC 
BEGIN
    DECLARE nb_existants INTEGER;
    DECLARE tournoi_exist INTEGER;
    DECLARE equipe_exist INTEGER;
    SET @nb_existants = (
        SELECT COUNT(*)
		FROM inscrit
		WHERE inscrit.id_equipe = p_id_equipe
		AND inscrit.id_tournoi = p_id_tournoi
    );
    SET @tournoi_exist = (
        SELECT COUNT(*) 
		FROM tournoi
		WHERE tournoi.id_tournoi = p_id_tournoi
    );
    SET @equipe_exist = (
        SELECT COUNT(*)
		FROM equipe   
		WHERE equipe.id_equipe = p_id_equipe
    );
    IF @tournoi_exist = 0 THEN
    	INSERT INTO LOGERROR(MESSAGE) VALUES ("CE TOURNOI NEXISTE PAS");
        RETURN ('CE TOURNOI NEXISTE PAS');
    ELSEIF @equipe_exist = 0 THEN
    	INSERT INTO LOGERROR(MESSAGE) VALUES ("CETTE EQUIPE NEXISTE PAS");
        RETURN ('CETTE EQUIPE NEXISTE PAS');
    ELSEIF @nb_existants = 0 THEN
    	INSERT INTO inscrit(id_equipe, id_tournoi) VALUES (p_id_equipe, p_id_tournoi);
        RETURN ('INSCRIPTION A ETE EFFECTUEE AVEC SUCCES');
    ELSE
    	INSERT INTO LOGERROR(MESSAGE) VALUES ("CETTE EQUIPE EST DEJA INSCRITE DANS CE TOURNOI");
        RETURN ('CETTE EQUIPE EST DEJA INSCRITE DANS CE TOURNOI');
    END IF;
END$$
DELIMITER ;

--définition triggers

DELIMITER $$ 
CREATE TRIGGER affectation
AFTER INSERT 
ON tournoi
 FOR EACH ROW
 BEGIN  
DECLARE 
terrain varchar(50);     
    SELECT id_terrain 
         INTO terrain 
               FROM terrain     
                      WHERE NOT EXISTS(SELECT * FROM utilise     WHERE utilise.id_terrain=terrain.id_terrain)    
                              LIMIT 1;          
     IF terrain IS NOT NULL      
          THEN          
                UPDATE utilise SET id_terrain=terrain       
                        WHERE id_poule=NEW.id_poule;                   
           ELSE    
 INSERT INTO LOGERROR (MESSAGE) VALUES ('Erreur : Ce terrain n est pas disponible .');    
  END IF; 
 END $$ 

DELIMITER $$
 CREATE TRIGGER cloturation
 AFTER UPDATE 
ON tournoi 
FOR EACH ROW
 BEGIN  	     
DECLARE nombre_1 integer;    
DECLARE nombre_2 integer;        
        SET @nombre_1 := (SELECT COUNT(id_match)  					
		FROM tournoi, _match  					
		      WHERE _match.id_tournoi = tournoi.id_tournoi AND tournoi.id_tournoi=new.id_tournoi);  
	
 SET @nombre_2 := (SELECT COUNT(id_match)  						 	
                FROM tournoi,_match 
                           WHERE tournoi.id_tournoi=_match.id_tournoi   				
		 	                      AND id_match_statut='FINI' AND tournoi.id_tournoi=new.id_tournoi);  	
        IF nombre_1 = nombre_2
                  THEN         
               UPDATE tournoi SET id_tournoi_statut='CLOTURE' AND id_tournoi=new.id_tournoi;   
          ELSE    
 INSERT INTO LOGERROR (MESSAGE) VALUES ('Erreur ');       
        END IF;
 END $$