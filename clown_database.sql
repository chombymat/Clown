drop table if exists media;
drop table if exists article;
drop table if exists projet;
drop table if exists role;
drop table if exists utilisateur;
drop table if exists contact;

-- création de la table des projets :
-- titre obligatoire

create table projet(
	id_projet serial primary key,
	titre varchar(200) not null
);

-- création de la table des articles :
-- titre obligatoire
-- relié à un projet

create table article(
	id_article serial primary key,
	id_projet integer references projet(id_projet) on update cascade on delete restrict,
	titre varchar(200) not null,
	contenu text not null
);

-- création de la table des média :
-- chemin : nom du fichier dans le dossier media hebergé sur le serveur
-- relié à un article

create table media(
	id_media serial primary key,
	id_article integer references article(id_article) on update cascade on delete restrict,
	chemin varchar(200) not null,
	nom varchar(50) not null,
	type varchar(50) not null
);

-- création de la table des utilisateurs :
-- tous les champs obligatoires
-- prima_pass : mot de passe crypté en sha256 + salt : 'clown'

create table utilisateur(
	id_utilisateur serial primary key,
	nom varchar(100) not null,
	prenom varchar(100) not null,
	adresse_mail varchar(100) not null unique,
	login varchar(20) not null unique,
	prima_pass varchar(100) not null
);

-- création de la table des rôles : 
-- 2 : utilisateur
-- 4 : administrateur

create table role(
	id_utilisateur integer references utilisateur(id_utilisateur) 
		on update cascade on delete restrict,
	role varchar(100) default 'MatthiasLaFerme!'
);

-- création de la table de contact de l'entreprise : 
-- coordonnées
-- adresse civile

create table contact(
	numero_telephone varchar(10),
	adresse_mail_contact varchar(100),
	numero_rue varchar(6),
	rue varchar(200),
	code_postal varchar(5),
	ville varchar(200)
);

insert into utilisateur(id_utilisateur, nom, prenom, adresse_mail, login, prima_pass) values(1, 'Markey', 'Jeffrey', 'markey.jeffrey@gmail.com', 'Metarion', 'DH/hPDypUlaFDntpSXvYFCb1HSE6qG1uPMnn61q8YWY=');
insert into role(id_utilisateur, role) values(1, 'role4');

insert into projet(titre) values('atelier');
insert into projet(titre) values('demarche');
insert into projet(titre) values('ressource');
insert into projet(titre) values('formation');

insert into article(id_projet, titre, contenu) values(1, 'Le pain', 'Ceci est du pain. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'Le lait', 'Ceci est du lait. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1,'Les 7 familles', 'Ici je vous présente un nouveau métier : docteur pour aliments. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'Le menu équilibré', 'Ici je vous présente un nouveau métier : docteur pour aliments. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'Alimentation et environnement', '/!\ Ci vous faites un régime passé votre chemin.<br><br> Ici il y a un superbe désert.  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'Le spectacle', 'Voici un spectacle (oui je sais il n''est pas présent ayez un peu d''imagination).  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'accueil', 'Voici l''accueil de la page atelier.');
insert into article(id_projet, titre, contenu) values(2, 'Clown', 'Voici l''accueil de la page clown.');
insert into article(id_projet, titre, contenu) values(2, 'Pratique et sensoriel', 'Voici l''accueil de la page pratique_sensorielle.');
insert into article(id_projet, titre, contenu) values(2, 'Expression Corporelle', 'Voici l''accueil de la page expression_corporelle.');
insert into article(id_projet, titre, contenu) values(2, 'accueil', 'Voici l''accueil de la page demarche.');

insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070515.JPG', 'photo enfant pain 1', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070524.JPG', 'photo enfant pain 2', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070533.JPG', 'photo enfant pain 3', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070543.JPG', 'photo enfant pain 4', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070552.JPG', 'photo enfant pain 5', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070554.JPG', 'photo enfant pain 6', 'photo');

insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_144603.jpg', 'photo enfant lait 1', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_144603_R.jpg', 'photo enfant lait 2', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145415.jpg', 'photo enfant lait 3', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145415_R.jpg', 'photo enfant lait 4', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145430.jpg', 'photo enfant lait 5', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145841.jpg', 'photo enfant lait 6', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_150600.jpg', 'photo enfant lait 7', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_150818.jpg', 'photo enfant lait 8', 'photo');

insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_144319.jpg', 'photo enfant famille 1', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_144319_R.jpg', 'photo enfant famille 2', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_144509.jpg', 'photo enfant famille 3', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_145849.jpg', 'photo enfant famille 4', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_145849_R.jpg', 'photo enfant famille 5', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_151218.jpg', 'photo enfant famille 6', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_151218_R.jpg', 'photo enfant famille 7', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_153058.jpg', 'photo enfant famille 8', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTOS_ENFANTS/P_20170302_153734.jpg', 'photo enfant famille 9', 'photo');

insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/10687385_1007352505978324_2895073862515994972_o.jpg', 'photo enfant spectacle 1', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/12604844_1007352812644960_4199858945908434600_o.jpg', 'photo enfant spectacle 2', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/P1060885.JPG', 'photo enfant spectacle 3', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/P1070230.JPG', 'photo enfant spectacle 4', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/P1070230.JPG', 'photo enfant spectacle 5', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/P1070276.JPG', 'photo enfant spectacle 6', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/ONGLET_LES_ATELIERS/SOUS_ONGLET_LE_SPECTACLE/PHOTOS_ENFANTS/P1060829.JPG', 'photo enfant spectacle 7', 'photo');







