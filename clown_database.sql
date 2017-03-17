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
	role varchar(100) default 'Matthias'
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

insert into article(id_projet, titre, contenu) values(1, 'Le pain', 'Sentir la bonne odeur du pain chaud, croquer dans une tartine de beurre, la tremper dans un bon chocolat…<br>Le pain fait partie de la base de notre alimentation, nous en consommons chaque jour avec délice qu''il soit en baguette ou en tranches !<br>Avec la Prima Porta, suivez le parcours du blé au pain ; observez des épis de blé, touchez la farine et terminez par pétrir votre propre pain ! ');
insert into article(id_projet, titre, contenu) values(1, 'Le lait', 'Quoi de mieux qu''un bon bol de lait chaud en hiver ? Et ce yaourt que vous prenez plaisir à déguster à la fin de votre repas. Savez vous quel est le parcours du lait depuis les pis de la vache jusqu''au supermarché ?<br>Pas d''inquiétude, la compagnie La Prima Porta est là, prête à vous aider. Avec cet atelier, les enfants découvriront avec plaisir le lait et ses dérivés. ');
insert into article(id_projet, titre, contenu) values(1,'Les 7 familles', 'Savez-vous qu''il existe sept familles d''aliments ? Oui mais savez-vous les nommer sans vous tromper ? Avec tous ces aliments, pas facile de s''en sortir … Et la pomme de terre, dans la famille des féculents ou des légumes ?.<br>Afin de présenter ce sujet (pas toujours facile) aux enfants, nous vous proposons le jeu des sept familles grâce auquel les enfants apprendront avec plaisir les différences et les subtilités de ces sept familles. ');
insert into article(id_projet, titre, contenu) values(1, 'Le menu équilibré', 'Manger équilibré ; voilà la clef pour être en forme ! Grâce à cet atelier, vous aborderez des notions essentielles avec les enfants, tout en reprenant de manière ludique le contenu des ateliers précédents.<br>Composez avec les enfants votre propre menu équilibré, de l''entrée jusqu''au dessert.<br>Au menu du jour : carottes râpées, boîtes sensorielles de pâtes mais surtout un véritable poisson entier qui risque de faire fureur auprès des enfants !!! ');
insert into article(id_projet, titre, contenu) values(1, 'Alimentation et environnement', 'Ce dernier atelier est l''occasion de sensibiliser les enfants à la cause noble qu''est l''environnement. En se servant du support du yaourt à la fraise, il s''agit de comprendre les enjeux de la fabrication, les déplacements qu''il occasionne et les solutions possibles.<br>Avec cette dernière étape, la compagnie La Prima Porta vous emmène une dernière fois sur le chemin de la curiosité et du plaisir. ');
insert into article(id_projet, titre, contenu) values(1, 'Le spectacle', 'Voici un spectacle (oui je sais il n''est pas présent ayez un peu d''imagination).  Vous pouvez voir sur la gauche une image acheté pour la modique somme de xx,xx€.');
insert into article(id_projet, titre, contenu) values(1, 'accueil', 'Voici l''accueil de la page atelier.');
insert into article(id_projet, titre, contenu) values(2, 'Clown', 'C''est l''histoire d''une rencontre, une rencontre tout en poésie et en douceur. Quand le clown entre en scène, il se met à la hauteur des enfants, il partage leur univers, leur manière de voir le monde et leur ouverture à l''autre. <br>Naît alors un moment de partage et d''émotions ; le clown transmet et reçoit, il se nourrit de cette relation à l''autre, il délivre notre potentiel et met à jour nos émotions.<br><br>Avec lui, l''instant présent devient palpable ; en sa compagnie, les enfants grandissent, explorent et découvrent. Le chemin de cette rencontre sera bordé de rires, de joie et de beaux souvenirs que les enfants et les équipes éducatives auront plaisir à se remémorer. ');
insert into article(id_projet, titre, contenu) values(2, 'Pratique et sensoriel', 'Entendre, goûter, sentir, toucher et voir ; nous le faisons tous les jours mais y prêtons-nous vraiment attention ? Prenons-nous encore le temps de sentir la bonne odeur du pain frais le matin, d''écouter les bruits autour de nous ? Et pourtant, c''est grâce à ces cinq sens que nous découvrons et appréhendons le monde qui nous entoure. <br><br>C''est pour remettre les cinq sens à l''honneur que la Prima Porta propose des ateliers pratiques et sensoriels.<br>Autour du thème riche et varié qu''est l''alimentation, les enfants observent à la loupe, goûtent, mettent la main à la pâte (à pain), piochent dans un sac des légumes, expérimentent les boîtes sensorielles et bien d''autres choses encore !!!');
insert into article(id_projet, titre, contenu) values(2, 'Expression Corporelle', 'Reprendre par et avec le corps les concepts pour mieux les intégrer, les vivre pour mieux les assimiler, pour mieux les incorporer, voilà les valeurs de la compagnie La Prima Porta.<br>Chaque atelier se termine par un moment d''expression corporelle. L''idée est que chaque enfant intériorise à sa manière et à son rythme les différents éléments vus lors du solo de clown et de l''atelier pratique. <br>Avec bienveillance, rythme et sérénité, les enfants laissent parler leur imagination, leurs émotions ; ils communiquent avec leur corps, ils prennent leur place à côté de et avec l''autre. <br>Cette fin d''atelier se veut être un moment d''écoute, d''attention et de respect ; Il ne s''agit pas d''apprendre par cœur mais d''apprendre par corps ! ');
insert into article(id_projet, titre, contenu) values(2, 'accueil', 'Apprendre par le rire, par les sens et par le corps, le tout dans une atmosphère ludique et dynamique, voilà les motivations et les valeurs de la compagnie La Prima Porta. <br><br>Elle est composée de clowns de théâtre alliant poésie et humour, apprenez dans la joie et la bonne humeur.<br>A l''aide de notre démarche innovante basée sur trois temps, l''enfant demeure au cœur de l''apprentissage. Il partage avec le clown, expérimente avec l''atelier pratique et s''exprime avec le corps. <br>La Prima Porta ouvre la première porte, celle qui permet de se révéler, tout en s''ouvrant aux autres et au monde.');

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

insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/Deambulation-clowns-prima-porta-bien-etre-21.jpg', 'photo clown - Claire', 'photo_claire');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/Deambulation-clowns-prima-porta-bien-etre-32.jpg', 'photo clown - Claire', 'photo_claire');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4032.jpg', 'photo clown - Claire', 'photo_claire');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4037.jpg', 'photo clown - Claire', 'photo_claire');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4204.jpg', 'photo clown - Claire', 'photo_claire');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4211.jpg', 'photo clown - Claire', 'photo_claire');

insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_141428.jpg', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_142253.jpg', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_142753.jpg', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060614.JPG', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060617.JPG', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060691.JPG', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060700.JPG', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1070070.JPG', 'photo clown - Virginie', 'photo_virginie');
insert into media(id_article, chemin, nom, type) values(8, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1070097.JPG', 'photo clown - Virginie', 'photo_virginie');

insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.43.00.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.30.53.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.34.01.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.37.09.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.40.34.jpg', 'photo enfant - Pratique et Sensoriel', 'photo');
insert into media(id_article, chemin, nom, type) values(9, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/P1070143.JPG', 'photo enfant - Pratique et Sensoriel', 'photo');

insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/Capture_lenny_2.PNG', 'S''il vous plaut tué moi #JeSuisLenny', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.47.33.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.51.44.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.52.08.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.52.29.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.53.30.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_151653.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_153232.jpg', 'photo enfant - Expression Corporelle', 'photo');
insert into media(id_article, chemin, nom, type) values(10, 'images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_153311.jpg', 'photo enfant - Expression Corporelle', 'photo');
