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
	id_projet integer references projet(id_projet) 
		on update cascade on delete restrict,
	titre varchar(200) not null,
	description varchar(1000),
	contenu text not null
);

-- création de la table des média :
-- chemin : nom du fichier dans le dossier media hebergé sur le serveur
-- relié à un article

create table media(
	id_media serial primary key,
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
