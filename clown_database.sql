drop table if exists media;
drop table if exists article;
drop table if exists projet;
drop table if exists role;
drop table if exists utilisateur;
drop table if exists contact;
drop table if exists media_clown;
drop table if exists clown;

-- création de la table des projets :
-- titre obligatoire

create table projet(
	id_projet serial,
	titre varchar(200) not null,
	constraint pk_projet primary key(id_projet)
);

-- création de la table des articles :
-- titre obligatoire
-- relié à un projet

create table article(
	id_article serial,
	id_projet integer default null,
	titre varchar(200) not null,
	contenu text not null,
	constraint pk_article primary key(id_article),
	constraint fk_article_projet foreign key(id_projet) references projet(id_projet) on update cascade on delete restrict
);

-- création de la table des média :
-- chemin : nom du fichier dans le dossier media hebergé sur le serveur
-- relié à un article

create table media(
	id_media serial,
	id_article integer,
	chemin text not null,
	nom text not null,
	type varchar(50) not null,
	constraint pk_media primary key(id_media),
	constraint fk_media_article foreign key(id_article) references article(id_article) on update cascade on delete restrict
);

-- création de la table des utilisateurs :
-- tous les champs obligatoires
-- prima_pass : mot de passe crypté en sha256 + salt : 'clown'

create table utilisateur(
	id_utilisateur serial,
	nom varchar(100) not null,
	prenom varchar(100) not null,
	adresse_mail varchar(100) not null unique,
	login varchar(20) not null unique,
	prima_pass varchar(100) not null,
	constraint pk_utilisateur primary key(id_utilisateur)
);

-- création de la table des rôles : 
-- 2 : utilisateur
-- 4 : administrateur

create table role(
	id_utilisateur integer,
	role varchar(100) default 'Matthias',
	constraint fk_role_utilisateur foreign key(id_utilisateur) references utilisateur(id_utilisateur) on update cascade on delete restrict
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

create table clown(
	id_clown serial,
	nom varchar(100) not null,
	constraint pk_clown primary key(id_clown)
);

create table media_clown(
	id_media serial,
	id_clown integer,
	type varchar(8) not null,
	nom varchar(100) not null,
	chemin text not null,
	constraint pk_media_clown primary key(id_media),
	constraint fk_media_clown_clown foreign key(id_clown) references clown(id_clown) on update cascade on delete cascade
);

insert into clown(nom) values('Claire');
insert into clown(nom) values('Virginie');

insert into media_clown(id_clown, type, nom, chemin) values(1, 'portrait', 'portrait Claire', 'images/clowns/1/portrait.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire', 'images/clowns/1/Deambulation-clowns-prima-porta-bien-etre-21.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire','images/clowns/1/Deambulation-clowns-prima-porta-bien-etre-32.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire','images/clowns/1/MG_4032.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire','images/clowns/1/MG_4037.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire','images/clowns/1/MG_4204.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(1, 'photo', 'photo Claire','images/clowns/1/MG_4211.jpg');

insert into media_clown(id_clown, type, nom, chemin) values(2, 'portrait', 'portrait Virginie', 'images/clowns/2/portrait.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie', 'images/clowns/2/P_20170209_141428.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P_20170209_142253.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P_20170209_142753.jpg');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1060614.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1060617.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1060691.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1060700.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1070070.JPG');
insert into media_clown(id_clown, type, nom, chemin) values(2, 'photo', 'photo Virginie','images/clowns/2/P1070097.JPG');

insert into utilisateur(id_utilisateur, nom, prenom, adresse_mail, login, prima_pass) values(1, 'Markey', 'Jeffrey', 'markey.jeffrey@gmail.com', 'Metarion', 'DH/hPDypUlaFDntpSXvYFCb1HSE6qG1uPMnn61q8YWY=');
insert into role(id_utilisateur, role) values(1, 'role4');

insert into projet(titre) values('atelier');
insert into projet(titre) values('demarche');
insert into projet(titre) values('ressource');

insert into article(id_projet, titre, contenu) values(1, 'Le pain', E'Sentir la bonne odeur du pain chaud, croquer dans une tartine de beurre, la tremper dans un bon chocolat…Le pain fait partie de la base de notre alimentation, nous en consommons chaque jour avec délice qu''il soit en baguette ou en tranches !\rAvec la Prima Porta, suivez le parcours du blé au pain ; observez des épis de blé, touchez la farine et terminez par pétrir votre propre pain ! ');
insert into article(id_projet, titre, contenu) values(1, 'Le lait', E'Quoi de mieux qu''un bon bol de lait chaud en hiver ? Et ce yaourt que vous prenez plaisir à déguster à la fin de votre repas. Savez vous quel est le parcours du lait depuis les pis de la vache jusqu''au supermarché ?\rPas d''inquiétude, la compagnie La Prima Porta est là, prête à vous aider. Avec cet atelier, les enfants découvriront avec plaisir le lait et ses dérivés. ');
insert into article(id_projet, titre, contenu) values(1,'Les 7 familles', E'Savez-vous qu''il existe sept familles d''aliments ? Oui mais savez-vous les nommer sans vous tromper ? Avec tous ces aliments, pas facile de s''en sortir … Et la pomme de terre, dans la famille des féculents ou des légumes ?.\rAfin de présenter ce sujet (pas toujours facile) aux enfants, nous vous proposons le jeu des sept familles grâce auquel les enfants apprendront avec plaisir les différences et les subtilités de ces sept familles. ');
insert into article(id_projet, titre, contenu) values(1, 'Le menu équilibré', E'Manger équilibré ; voilà la clef pour être en forme ! Grâce à cet atelier, vous aborderez des notions essentielles avec les enfants, tout en reprenant de manière ludique le contenu des ateliers précédents.\rComposez avec les enfants votre propre menu équilibré, de l''entrée jusqu''au dessert.\rAu menu du jour : carottes râpées, boîtes sensorielles de pâtes mais surtout un véritable poisson entier qui risque de faire fureur auprès des enfants !!! ');
insert into article(id_projet, titre, contenu) values(1, 'Alimentation et environnement', E'Ce dernier atelier est l''occasion de sensibiliser les enfants à la cause noble qu''est l''environnement. En se servant du support du yaourt à la fraise, il s''agit de comprendre les enjeux de la fabrication, les déplacements qu''il occasionne et les solutions possibles.\rAvec cette dernière étape, la compagnie La Prima Porta vous emmène une dernière fois sur le chemin de la curiosité et du plaisir. ');
insert into article(id_projet, titre, contenu) values(1, 'Le spectacle', E'Voici un spectacle (oui je sais il n''est pas présent ayez un peu d''imagination).  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'accueil', E'Grâce à la compagnie la Prima Porta, l''alimentation n''aura plus aucun secrets pour vous. Du pain jusqu''au yaourt à la fraise, ce cycle de cinq ateliers permet de sensibiliser les enfants à différentes questions : le parcours du blé au pain, le lait et ses dérivés, les sept familles d''aliments, la composition d''un menu équilibré et enfin, le parcours du yaourt à la fraise. Ce dernier atelier est également l''occasion de sensibiliser les enfants à l''environnement.');
insert into article(id_projet, titre, contenu) values(2, 'Clown', E'C''est l''histoire d''une rencontre, une rencontre tout en poésie et en douceur. Quand le clown entre en scène, il se met à la hauteur des enfants, il partage leur univers, leur manière de voir le monde et leur ouverture à l''autre. \rNaît alors un moment de partage et d''émotions ; le clown transmet et reçoit, il se nourrit de cette relation à l''autre, il délivre notre potentiel et met à jour nos émotions.\r\rAvec lui, l''instant présent devient palpable ; en sa compagnie, les enfants grandissent, explorent et découvrent. Le chemin de cette rencontre sera bordé de rires, de joie et de beaux souvenirs que les enfants et les équipes éducatives auront plaisir à se remémorer. ');
insert into article(id_projet, titre, contenu) values(2, 'Pratique et sensoriel', E'Entendre, goûter, sentir, toucher et voir ; nous le faisons tous les jours mais y prêtons-nous vraiment attention ? Prenons-nous encore le temps de sentir la bonne odeur du pain frais le matin, d''écouter les bruits autour de nous ? Et pourtant, c''est grâce à ces cinq sens que nous découvrons et appréhendons le monde qui nous entoure. \r\rC''est pour remettre les cinq sens à l''honneur que la Prima Porta propose des ateliers pratiques et sensoriels.\rAutour du thème riche et varié qu''est l''alimentation, les enfants observent à la loupe, goûtent, mettent la main à la pâte (à pain), piochent dans un sac des légumes, expérimentent les boîtes sensorielles et bien d''autres choses encore !!!');
insert into article(id_projet, titre, contenu) values(2, 'Expression Corporelle', E'Reprendre par et avec le corps les concepts pour mieux les intégrer, les vivre pour mieux les assimiler, pour mieux les incorporer, voilà les valeurs de la compagnie La Prima Porta.\rChaque atelier se termine par un moment d''expression corporelle. L''idée est que chaque enfant intériorise à sa manière et à son rythme les différents éléments vus lors du solo de clown et de l''atelier pratique. \rAvec bienveillance, rythme et sérénité, les enfants laissent parler leur imagination, leurs émotions ; ils communiquent avec leur corps, ils prennent leur place à côté de et avec l''autre. \rCette fin d''atelier se veut être un moment d''écoute, d''attention et de respect ; Il ne s''agit pas d''apprendre par cœur mais d''apprendre par corps ! ');
insert into article(id_projet, titre, contenu) values(2, 'accueil', E'Apprendre par le rire, par les sens et par le corps, le tout dans une atmosphère ludique et dynamique, voilà les motivations et les valeurs de la compagnie La Prima Porta. \r\rElle est composée de clowns de théâtre alliant poésie et humour, apprenez dans la joie et la bonne humeur.\rA l''aide de notre démarche innovante basée sur trois temps, l''enfant demeure au coeur de l''apprentissage. Il partage avec le clown, expérimente avec l''atelier pratique et s''exprime avec le corps. \rLa Prima Porta ouvre la première porte, celle qui permet de se révéler, tout en s''ouvrant aux autres et au monde.');
insert into article(titre, contenu) values('formation', '');

insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/1.JPG', 'photo enfant pain 1', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/2.JPG', 'photo enfant pain 2', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/3.JPG', 'photo enfant pain 3', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/4.JPG', 'photo enfant pain 4', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/5.JPG', 'photo enfant pain 5', 'photo');
insert into media(id_article, chemin, nom, type) values(1, 'images/article/1/PHOTOS_ENFANTS/6.JPG', 'photo enfant pain 6', 'photo');

insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/7.jpg', 'photo enfant lait 1', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/8.jpg', 'photo enfant lait 2', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/9.jpg', 'photo enfant lait 3', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/10.jpg', 'photo enfant lait 4', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/11.jpg', 'photo enfant lait 5', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/12.jpg', 'photo enfant lait 6', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/13.jpg', 'photo enfant lait 7', 'photo');
insert into media(id_article, chemin, nom, type) values(2, 'images/article/2/PHOTOS_ENFANTS/14.jpg', 'photo enfant lait 8', 'photo');

insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/15.jpg', 'photo enfant famille 1', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/16.jpg', 'photo enfant famille 2', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/17.jpg', 'photo enfant famille 3', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/18.jpg', 'photo enfant famille 4', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/19.jpg', 'photo enfant famille 5', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/20.jpg', 'photo enfant famille 6', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/21.jpg', 'photo enfant famille 7', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/22.jpg', 'photo enfant famille 8', 'photo');
insert into media(id_article, chemin, nom, type) values(3, 'images/article/3/PHOTOS_ENFANTS/23.jpg', 'photo enfant famille 9', 'photo');

insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/24.jpg', 'photo enfant spectacle 1', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/25.jpg', 'photo enfant spectacle 2', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/26.JPG', 'photo enfant spectacle 3', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/27.JPG', 'photo enfant spectacle 4', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/28.JPG', 'photo enfant spectacle 5', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/29.JPG', 'photo enfant spectacle 6', 'photo');
insert into media(id_article, chemin, nom, type) values(6, 'images/article/6/PHOTOS_ENFANTS/30.JPG', 'photo enfant spectacle 7', 'photo');

insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/31.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/32.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/33.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/34.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/35.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/article/9/36.JPG', 'photo enfant - Pratique et Sensoriel', 'photo');

insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/42.PNG', 'S''il vous plait tué moi #JeSuisLenny', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/38.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/39.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/40.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/41.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/37.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/43.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/44.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/article/10/45.jpg', 'photo enfant - Expression Corporelle', 'photo');

insert into media(id_article, chemin, nom, type) values(1, 'images/pdf/1/46.pdf', 'Fiche atelier 1 : du blé au pain (.pdf)', 'pdf');
insert into media(id_article, chemin, nom, type) values(2, 'images/pdf/2/47.pdf', 'Fiche atelier 2 : le lait et ses dérivés (.pdf)', 'pdf');
insert into media(id_article, chemin, nom, type) values(3, 'images/pdf/3/48.pdf', 'Fiche atelier 3 : le classement des aliments (.pdf)', 'pdf');
insert into media(id_article, chemin, nom, type) values(4, 'images/pdf/4/49.pdf', 'Fiche atelier 4 : un menu équilibré (.pdf)', 'pdf');
insert into media(id_article, chemin, nom, type) values(5, 'images/pdf/5/50.pdf', 'Fiche atelier 5 : le parcours du yaourt à la fraise (.pdf)', 'pdf');

insert into media(chemin, nom, type) values('images/galerie/51.png', 'galerie 1', 'galerie');
insert into media(chemin, nom, type) values('images/galerie/52.jpg', 'galerie 2', 'galerie');
insert into media(chemin, nom, type) values('images/galerie/53.jpg', 'Constance', 'galerie');
