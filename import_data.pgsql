--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: article; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE article (
    id_article integer NOT NULL,
    id_projet integer,
    titre character varying(200) NOT NULL,
    contenu text NOT NULL
);


ALTER TABLE article OWNER TO metarion;

--
-- Name: article_id_article_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE article_id_article_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE article_id_article_seq OWNER TO metarion;

--
-- Name: article_id_article_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE article_id_article_seq OWNED BY article.id_article;


--
-- Name: clown; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE clown (
    id_clown integer NOT NULL,
    nom character varying(100) NOT NULL
);


ALTER TABLE clown OWNER TO metarion;

--
-- Name: clown_id_clown_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE clown_id_clown_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clown_id_clown_seq OWNER TO metarion;

--
-- Name: clown_id_clown_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE clown_id_clown_seq OWNED BY clown.id_clown;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE contact (
    numero_telephone character varying(10),
    adresse_mail_contact character varying(100),
    numero_rue character varying(6),
    rue character varying(200),
    code_postal character varying(5),
    ville character varying(200)
);


ALTER TABLE contact OWNER TO metarion;

--
-- Name: media; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE media (
    id_media integer NOT NULL,
    id_article integer,
    chemin text NOT NULL,
    nom text,
    type character varying(50) NOT NULL,
    doitinscrit boolean DEFAULT false
);


ALTER TABLE media OWNER TO metarion;

--
-- Name: media_clown; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE media_clown (
    id_media integer NOT NULL,
    id_clown integer,
    type character varying(8) NOT NULL,
    nom character varying(100) NOT NULL,
    chemin text NOT NULL
);


ALTER TABLE media_clown OWNER TO metarion;

--
-- Name: media_clown_id_media_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE media_clown_id_media_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE media_clown_id_media_seq OWNER TO metarion;

--
-- Name: media_clown_id_media_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE media_clown_id_media_seq OWNED BY media_clown.id_media;


--
-- Name: media_id_media_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE media_id_media_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE media_id_media_seq OWNER TO metarion;

--
-- Name: media_id_media_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE media_id_media_seq OWNED BY media.id_media;


--
-- Name: projet; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE projet (
    id_projet integer NOT NULL,
    titre character varying(200) NOT NULL
);


ALTER TABLE projet OWNER TO metarion;

--
-- Name: projet_id_projet_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE projet_id_projet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projet_id_projet_seq OWNER TO metarion;

--
-- Name: projet_id_projet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE projet_id_projet_seq OWNED BY projet.id_projet;


--
-- Name: role; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE role (
    id_utilisateur integer,
    role character varying(100) DEFAULT 'role2'::character varying
);


ALTER TABLE role OWNER TO metarion;

--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE utilisateur (
    id_utilisateur integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    adresse_mail character varying(100) NOT NULL,
    login character varying(200) NOT NULL,
    prima_pass character varying(100) NOT NULL
);


ALTER TABLE utilisateur OWNER TO metarion;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: metarion
--

CREATE SEQUENCE utilisateur_id_utilisateur_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE utilisateur_id_utilisateur_seq OWNER TO metarion;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metarion
--

ALTER SEQUENCE utilisateur_id_utilisateur_seq OWNED BY utilisateur.id_utilisateur;


--
-- Name: validation; Type: TABLE; Schema: public; Owner: metarion
--

CREATE TABLE validation (
    id_utilisateur integer,
    token character varying(10) NOT NULL,
    modifiedpassword character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE validation OWNER TO metarion;

--
-- Name: article id_article; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY article ALTER COLUMN id_article SET DEFAULT nextval('article_id_article_seq'::regclass);


--
-- Name: clown id_clown; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY clown ALTER COLUMN id_clown SET DEFAULT nextval('clown_id_clown_seq'::regclass);


--
-- Name: media id_media; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media ALTER COLUMN id_media SET DEFAULT nextval('media_id_media_seq'::regclass);


--
-- Name: media_clown id_media; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media_clown ALTER COLUMN id_media SET DEFAULT nextval('media_clown_id_media_seq'::regclass);


--
-- Name: projet id_projet; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY projet ALTER COLUMN id_projet SET DEFAULT nextval('projet_id_projet_seq'::regclass);


--
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('utilisateur_id_utilisateur_seq'::regclass);


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY article (id_article, id_projet, titre, contenu) FROM stdin;
1	1	Le pain	Sentir la bonne odeur du pain chaud, croquer dans une tartine de beurre, la tremper dans un bon chocolat…Le pain fait partie de la base de notre alimentation, nous en consommons chaque jour avec délice qu'il soit en baguette ou en tranches !\rAvec la Prima Porta, suivez le parcours du blé au pain ; observez des épis de blé, touchez la farine et terminez par pétrir votre propre pain !
2	1	Le lait	Quoi de mieux qu'un bon bol de lait chaud en hiver ? Et ce yaourt que vous prenez plaisir à déguster à la fin de votre repas. Savez vous quel est le parcours du lait depuis les pis de la vache jusqu'au supermarché ?\rPas d'inquiétude, la compagnie La Prima Porta est là, prête à vous aider. Avec cet atelier, les enfants découvriront avec plaisir le lait et ses dérivés.
3	1	Les 7 familles	Savez-vous qu'il existe sept familles d'aliments ? Oui mais savez-vous les nommer sans vous tromper ? Avec tous ces aliments, pas facile de s'en sortir … Et la pomme de terre, dans la famille des féculents ou des légumes ?.\rAfin de présenter ce sujet (pas toujours facile) aux enfants, nous vous proposons le jeu des sept familles grâce auquel les enfants apprendront avec plaisir les différences et les subtilités de ces sept familles.
4	1	Le menu équilibré	Manger équilibré ; voilà la clef pour être en forme ! Grâce à cet atelier, vous aborderez des notions essentielles avec les enfants, tout en reprenant de manière ludique le contenu des ateliers précédents.\rComposez avec les enfants votre propre menu équilibré, de l'entrée jusqu'au dessert.\rAu menu du jour : carottes râpées, boîtes sensorielles de pâtes mais surtout un véritable poisson entier qui risque de faire fureur auprès des enfants !!!
5	1	Alimentation et environnement	Ce dernier atelier est l'occasion de sensibiliser les enfants à la cause noble qu'est l'environnement. En se servant du support du yaourt à la fraise, il s'agit de comprendre les enjeux de la fabrication, les déplacements qu'il occasionne et les solutions possibles.\rAvec cette dernière étape, la compagnie La Prima Porta vous emmène une dernière fois sur le chemin de la curiosité et du plaisir.
6	1	Le spectacle	Le spectacle avec des enfants.
7	1	accueil	Grâce à la compagnie la Prima Porta, l'alimentation n'aura plus aucun secrets pour vous. Du pain jusqu'au yaourt à la fraise, ce cycle de cinq ateliers permet de sensibiliser les enfants à différentes questions : le parcours du blé au pain, le lait et ses dérivés, les sept familles d'aliments, la composition d'un menu équilibré et enfin, le parcours du yaourt à la fraise. Ce dernier atelier est également l'occasion de sensibiliser les enfants à l'environnement.
8	2	Clown	C'est l'histoire d'une rencontre, une rencontre tout en poésie et en douceur. Quand le clown entre en scène, il se met à la hauteur des enfants, il partage leur univers, leur manière de voir le monde et leur ouverture à l'autre. \rNaît alors un moment de partage et d'émotions ; le clown transmet et reçoit, il se nourrit de cette relation à l'autre, il délivre notre potentiel et met à jour nos émotions.\r\rAvec lui, l'instant présent devient palpable ; en sa compagnie, les enfants grandissent, explorent et découvrent. Le chemin de cette rencontre sera bordé de rires, de joie et de beaux souvenirs que les enfants et les équipes éducatives auront plaisir à se remémorer.
9	2	Pratique et sensoriel	Entendre, goûter, sentir, toucher et voir ; nous le faisons tous les jours mais y prêtons-nous vraiment attention ? Prenons-nous encore le temps de sentir la bonne odeur du pain frais le matin, d'écouter les bruits autour de nous ? Et pourtant, c'est grâce à ces cinq sens que nous découvrons et appréhendons le monde qui nous entoure. \r\rC'est pour remettre les cinq sens à l'honneur que la Prima Porta propose des ateliers pratiques et sensoriels.\rAutour du thème riche et varié qu'est l'alimentation, les enfants observent à la loupe, goûtent, mettent la main à la pâte (à pain), piochent dans un sac des légumes, expérimentent les boîtes sensorielles et bien d'autres choses encore !!!
10	2	Expression Corporelle	Reprendre par et avec le corps les concepts pour mieux les intégrer, les vivre pour mieux les assimiler, pour mieux les incorporer, voilà les valeurs de la compagnie La Prima Porta.\rChaque atelier se termine par un moment d'expression corporelle. L'idée est que chaque enfant intériorise à sa manière et à son rythme les différents éléments vus lors du solo de clown et de l'atelier pratique. \rAvec bienveillance, rythme et sérénité, les enfants laissent parler leur imagination, leurs émotions ; ils communiquent avec leur corps, ils prennent leur place à côté de et avec l'autre. \rCette fin d'atelier se veut être un moment d'écoute, d'attention et de respect ; Il ne s'agit pas d'apprendre par cœur mais d'apprendre par corps !
11	2	accueil	Apprendre par le rire, par les sens et par le corps, le tout dans une atmosphère ludique et dynamique, voilà les motivations et les valeurs de la compagnie La Prima Porta. \r\rElle est composée de clowns de théâtre alliant poésie et humour, apprenez dans la joie et la bonne humeur.\rA l'aide de notre démarche innovante basée sur trois temps, l'enfant demeure au coeur de l'apprentissage. Il partage avec le clown, expérimente avec l'atelier pratique et s'exprime avec le corps. \rLa Prima Porta ouvre la première porte, celle qui permet de se révéler, tout en s'ouvrant aux autres et au monde.
12	\N	Formation
\.


--
-- Name: article_id_article_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('article_id_article_seq', 12, true);


--
-- Data for Name: clown; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY clown (id_clown, nom) FROM stdin;
1	Mademoiselle Lulu
2	Chef Ratatouille
\.


--
-- Name: clown_id_clown_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('clown_id_clown_seq', 2, true);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY contact (numero_telephone, adresse_mail_contact, numero_rue, rue, code_postal, ville) FROM stdin;
\.


--
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY media (id_media, id_article, chemin, nom, type, doitinscrit) FROM stdin;
1	1	images/article/1/PHOTOS_ENFANTS/1.JPG	photo enfant pain 1	photo	f
2	1	images/article/1/PHOTOS_ENFANTS/2.JPG	photo enfant pain 2	photo	f
3	1	images/article/1/PHOTOS_ENFANTS/3.JPG	photo enfant pain 3	photo	f
4	1	images/article/1/PHOTOS_ENFANTS/4.JPG	photo enfant pain 4	photo	f
5	1	images/article/1/PHOTOS_ENFANTS/5.JPG	photo enfant pain 5	photo	f
6	1	images/article/1/PHOTOS_ENFANTS/6.JPG	photo enfant pain 6	photo	f
7	2	images/article/2/PHOTOS_ENFANTS/7.jpg	photo enfant lait 1	photo	f
8	2	images/article/2/PHOTOS_ENFANTS/8.jpg	photo enfant lait 2	photo	f
9	2	images/article/2/PHOTOS_ENFANTS/9.jpg	photo enfant lait 3	photo	f
10	2	images/article/2/PHOTOS_ENFANTS/10.jpg	photo enfant lait 4	photo	f
11	2	images/article/2/PHOTOS_ENFANTS/11.jpg	photo enfant lait 5	photo	f
12	2	images/article/2/PHOTOS_ENFANTS/12.jpg	photo enfant lait 6	photo	f
13	2	images/article/2/PHOTOS_ENFANTS/13.jpg	photo enfant lait 7	photo	f
14	2	images/article/2/PHOTOS_ENFANTS/14.jpg	photo enfant lait 8	photo	f
15	3	images/article/3/PHOTOS_ENFANTS/15.jpg	photo enfant famille 1	photo	f
16	3	images/article/3/PHOTOS_ENFANTS/16.jpg	photo enfant famille 2	photo	f
17	3	images/article/3/PHOTOS_ENFANTS/17.jpg	photo enfant famille 3	photo	f
18	3	images/article/3/PHOTOS_ENFANTS/18.jpg	photo enfant famille 4	photo	f
19	3	images/article/3/PHOTOS_ENFANTS/19.jpg	photo enfant famille 5	photo	f
20	3	images/article/3/PHOTOS_ENFANTS/20.jpg	photo enfant famille 6	photo	f
21	3	images/article/3/PHOTOS_ENFANTS/21.jpg	photo enfant famille 7	photo	f
22	3	images/article/3/PHOTOS_ENFANTS/22.jpg	photo enfant famille 8	photo	f
23	3	images/article/3/PHOTOS_ENFANTS/23.jpg	photo enfant famille 9	photo	f
24	6	images/article/6/PHOTOS_ENFANTS/24.jpg	photo enfant spectacle 1	photo	f
25	6	images/article/6/PHOTOS_ENFANTS/25.jpg	photo enfant spectacle 2	photo	f
26	6	images/article/6/PHOTOS_ENFANTS/26.JPG	photo enfant spectacle 3	photo	f
27	6	images/article/6/PHOTOS_ENFANTS/27.JPG	photo enfant spectacle 4	photo	f
28	6	images/article/6/PHOTOS_ENFANTS/28.JPG	photo enfant spectacle 5	photo	f
29	6	images/article/6/PHOTOS_ENFANTS/29.JPG	photo enfant spectacle 6	photo	f
30	6	images/article/6/PHOTOS_ENFANTS/30.JPG	photo enfant spectacle 7	photo	f
31	9	images/article/9/31.jpg	photo enfant - Pratique et Sensoriel	photo	f
32	9	images/article/9/32.jpg	photo enfant - Pratique et Sensoriel	photo	f
33	9	images/article/9/33.jpg	photo enfant - Pratique et Sensoriel	photo	f
34	9	images/article/9/34.jpg	photo enfant - Pratique et Sensoriel	photo	f
35	9	images/article/9/35.jpg	photo enfant - Pratique et Sensoriel	photo	f
36	9	images/article/9/36.JPG	photo enfant - Pratique et Sensoriel	photo	f
37	10	images/article/10/42.PNG	photo enfant - Expression Corporelle	photo	f
38	10	images/article/10/38.jpg	photo enfant - Expression Corporelle	photo	f
39	10	images/article/10/39.jpg	photo enfant - Expression Corporelle	photo	f
40	10	images/article/10/40.jpg	photo enfant - Expression Corporelle	photo	f
41	10	images/article/10/41.jpg	photo enfant - Expression Corporelle	photo	f
42	10	images/article/10/37.jpg	photo enfant - Expression Corporelle	photo	f
43	10	images/article/10/43.jpg	photo enfant - Expression Corporelle	photo	f
44	10	images/article/10/44.jpg	photo enfant - Expression Corporelle	photo	f
45	10	images/article/10/45.jpg	photo enfant - Expression Corporelle	photo	f
46	1	Pdf?id=46&id_a=1	Fiche atelier 1 : du blé au pain (.pdf)	pdf	t
47	2	Pdf?id=47&id_a=2	Fiche atelier 2 : le lait et ses dérivés (.pdf)	pdf	t
48	3	Pdf?id=48&id_b=3	Fiche atelier 3 : le classement des aliments (.pdf)	pdf	t
49	4	Pdf?id=49&id_a=4	Fiche atelier 4 : un menu équilibré (.pdf)	pdf	t
50	5	Pdf?id=50&id_a=5	Fiche atelier 5 : le parcours du yaourt à la fraise (.pdf)	pdf	t
51	\N	images/galerie/51.png	galerie 1	galerie	f
52	\N	images/galerie/52.jpg	galerie 2	galerie	f
53	\N	images/galerie/53.jpg	Constance	galerie	f
55	1	<iframe src="https://player.vimeo.com/video/217464170" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/217464170">Le pain</a> from <a href="https://vimeo.com/primaporta">Prima Porta</a> on <a href="https://vimeo.com">Vimeo</a>.</p>	\N	video	f
56	2	<iframe src="https://player.vimeo.com/video/217472944" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/217472944">Le Lait</a> from <a href="https://vimeo.com/primaporta">Prima Porta</a> on <a href="https://vimeo.com">Vimeo</a>.</p>	\N	video	f
57	5	<iframe src="https://player.vimeo.com/video/219402026" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/219402026">Alimentation et environnement</a> from <a href="https://vimeo.com/primaporta">Prima Porta</a> on <a href="https://vimeo.com">Vimeo</a>.</p>	\N	video	f
58	4	<iframe src="https://player.vimeo.com/video/220602484" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/220602484">Le menu &eacute;quilibr&eacute;</a> from <a href="https://vimeo.com/primaporta">Prima Porta</a> on <a href="https://vimeo.com">Vimeo</a>.</p>	\N	video	f
59	6	<iframe src="https://player.vimeo.com/video/219404190" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/219404190">Le voyage des grands chefs</a> from <a href="https://vimeo.com/primaporta">Prima Porta</a> on <a href="https://vimeo.com">Vimeo</a>.</p>	\N	video	f
\.


--
-- Data for Name: media_clown; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY media_clown (id_media, id_clown, type, nom, chemin) FROM stdin;
1	1	portrait	portrait	images/clowns/1/1.JPG
2	1	photo	photo Mademoiselle Lulu	images/clowns/1/2.jpg
3	1	photo	photo Mademoiselle Lulu	images/clowns/1/3.jpg
4	1	photo	photo Mademoiselle Lulu	images/clowns/1/4.jpg
5	1	photo	photo Mademoiselle Lulu	images/clowns/1/5.jpg
6	1	photo	photo Mademoiselle Lulu	images/clowns/1/6.jpg
7	1	photo	photo Mademoiselle Lulu	images/clowns/1/7.jpg
8	2	portrait	portrait	images/clowns/2/8.JPG
9	2	photo	photo Chef Ratatouille	images/clowns/2/9.jpg
10	2	photo	photo Chef Ratatouille	images/clowns/2/10.jpg
11	2	photo	photo Chef Ratatouille	images/clowns/2/11.jpg
12	2	photo	photo Chef Ratatouille	images/clowns/2/12.JPG
13	2	photo	photo Chef Ratatouille	images/clowns/2/13.JPG
14	2	photo	photo Chef Ratatouille	images/clowns/2/14.JPG
15	2	photo	photo Chef Ratatouille	images/clowns/2/15.JPG
16	2	photo	photo Chef Ratatouille	images/clowns/2/16.JPG
17	2	photo	photo Chef Ratatouille	images/clowns/2/17.JPG
\.


--
-- Name: media_clown_id_media_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('media_clown_id_media_seq', 17, true);


--
-- Name: media_id_media_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('media_id_media_seq', 59, true);


--
-- Data for Name: projet; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY projet (id_projet, titre) FROM stdin;
1	atelier
2	demarche
3	ressource
\.


--
-- Name: projet_id_projet_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('projet_id_projet_seq', 3, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY role (id_utilisateur, role) FROM stdin;
1	role4
1	role4
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY utilisateur (id_utilisateur, nom, prenom, adresse_mail, login, prima_pass) FROM stdin;
1	Markey	Jeffrey	markey.jeffrey@gmail.com	Ha8gvAbW3Q1A1U+Duqc/xDa7dCVh1R6W75lms3MTj9o=	DH/hPDypUlaFDntpSXvYFCb1HSE6qG1uPMnn61q8YWY=
\.


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: metarion
--

SELECT pg_catalog.setval('utilisateur_id_utilisateur_seq', 1, false);


--
-- Data for Name: validation; Type: TABLE DATA; Schema: public; Owner: metarion
--

COPY validation (id_utilisateur, token, modifiedpassword) FROM stdin;
\.


--
-- Name: article pk_article; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY article
    ADD CONSTRAINT pk_article PRIMARY KEY (id_article);


--
-- Name: clown pk_clown; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY clown
    ADD CONSTRAINT pk_clown PRIMARY KEY (id_clown);


--
-- Name: media pk_media; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media
    ADD CONSTRAINT pk_media PRIMARY KEY (id_media);


--
-- Name: media_clown pk_media_clown; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media_clown
    ADD CONSTRAINT pk_media_clown PRIMARY KEY (id_media);


--
-- Name: projet pk_projet; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY projet
    ADD CONSTRAINT pk_projet PRIMARY KEY (id_projet);


--
-- Name: utilisateur pk_utilisateur; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT pk_utilisateur PRIMARY KEY (id_utilisateur);


--
-- Name: utilisateur utilisateur_adresse_mail_key; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT utilisateur_adresse_mail_key UNIQUE (adresse_mail);


--
-- Name: utilisateur utilisateur_login_key; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY utilisateur
    ADD CONSTRAINT utilisateur_login_key UNIQUE (login);


--
-- Name: validation validation_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY validation
    ADD CONSTRAINT validation_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- Name: article fk_article_projet; Type: FK CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY article
    ADD CONSTRAINT fk_article_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: media fk_media_article; Type: FK CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media
    ADD CONSTRAINT fk_media_article FOREIGN KEY (id_article) REFERENCES article(id_article) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: media_clown fk_media_clown_clown; Type: FK CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY media_clown
    ADD CONSTRAINT fk_media_clown_clown FOREIGN KEY (id_clown) REFERENCES clown(id_clown) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role fk_role_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY role
    ADD CONSTRAINT fk_role_utilisateur FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: validation fk_validation_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: metarion
--

ALTER TABLE ONLY validation
    ADD CONSTRAINT fk_validation_utilisateur FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: article; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE article TO clown;


--
-- Name: article_id_article_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE article_id_article_seq TO clown;


--
-- Name: clown; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE clown TO clown;


--
-- Name: clown_id_clown_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE clown_id_clown_seq TO clown;


--
-- Name: contact; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE contact TO clown;


--
-- Name: media; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE media TO clown;


--
-- Name: media_clown; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE media_clown TO clown;


--
-- Name: media_clown_id_media_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE media_clown_id_media_seq TO clown;


--
-- Name: media_id_media_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE media_id_media_seq TO clown;


--
-- Name: projet; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE projet TO clown;


--
-- Name: projet_id_projet_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE projet_id_projet_seq TO clown;


--
-- Name: role; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE role TO clown;


--
-- Name: utilisateur; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE utilisateur TO clown;


--
-- Name: utilisateur_id_utilisateur_seq; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON SEQUENCE utilisateur_id_utilisateur_seq TO clown;


--
-- Name: validation; Type: ACL; Schema: public; Owner: metarion
--

GRANT ALL ON TABLE validation TO clown;


--
-- PostgreSQL database dump complete
--
