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
	titre varchar(200) not null,
	description varchar(1000)
);

-- création de la table des articles :
-- titre obligatoire
-- relié à un projet

create table article(
	id_article serial primary key,
	onglet varchar(60) unique,
	titre varchar(200) not null,
	description varchar(1000) not null,
	contenu text not null
);

-- création de la table des média :
-- chemin : nom du fichier dans le dossier media hebergé sur le serveur
-- relié à un article

create table media(
	id_media serial primary key,
	-- id_article integer references article(id_article) on update cascade on delete restrict,
	chemin varchar(100) not null,
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
-- 1 : inutile
-- 2 : utilisateur
-- 3 : inutile
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
insert into article(onglet, titre, description, contenu) values('pain', '', '', 'Ceci est du pain. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(onglet, titre, description, contenu) values('lait', '', '', 'Ceci est du lait. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(onglet, titre, description, contenu) values('famille', '', '', 'Ne regardé pas cette onglet lorque vous avez faim. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(onglet, titre, description, contenu) values('menu', '', '', 'Ici je vous présente un nouveau métier : docteur pour aliments. Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(onglet, titre, description, contenu) values('alimentation', '', '', '/!\ Ci vous faites un régime passé votre chemin.<br><br> Ici il y a un superbe désert.  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(onglet, titre, description, contenu) values('spectacle', '', '', 'Voici un spectacle (oui je sais il n''est pas présent ayez un peu d''imagination).  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');



