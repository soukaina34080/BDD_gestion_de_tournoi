/*
FIchier : Creation_GroupeI.sql
Auteurs : 
Chaima ABRADI 21700074
Soukaina MESSAOUDI 21603069
Nom du groupe : I
*/

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
---------Tests fonction

SELECT nouveau_evenement('ID_ORGANISATEUR_BIDON', 'PARIS', '22-12-20', '3_JOUEURS');
SELECT nouveau_evenement('11', 'PARIS', '22-12-20', 'TYPE_DE_JEU_BIDON');
SELECT nouveau_evenement('11', 'PARIS', '22-12-20', '3_JOUEURS');

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
------------Test fonction

SELECT inscription_equipe_dans_un_tournoi('34', 999);
SELECT inscription_equipe_dans_un_tournoi('EQUIPE_BIDON', 1);
SELECT inscription_equipe_dans_un_tournoi('EQUIPE_BIDON', 999);
SELECT inscription_equipe_dans_un_tournoi('54', 1);
SELECT inscription_equipe_dans_un_tournoi('34', 1);

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


--Test trigger 

Test:
 --Insertion d'un terrain non disponible

 INSERT INTO utilise VALUES('poule_3','12');  

-- Affichage de l'erreur 
SELECT * FROM LOGERROR;  

--Affichage de la table utilise qui affecte une poule a un  terrain disponible 
SELECT * FROM utilise;

---Test: 
-- Mis a jour du statut du tournoi
 UPDATE tournoi SET id_tournoi_statut="EN COURS";
   -- Affichage de l'erreur 
 SELECT * FROM LOGERROR;
  --Affichage de la table : le statut de tournoi n'est pas mis a jour car la condition tu trigger n'est pas verifiée 
/* terrain disponible SELECT * FROM tournoi;

