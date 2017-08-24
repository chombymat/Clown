<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./js/admin.js"></script>
<link rel="stylesheet" href="style.css" />
<title>ClownEducatif.com – Compagnie de clown de théâtre Administration</title>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<button id="bt_galerie" class="btn btn-sample">Gestion galerie</button>
	<button id="bt_modif_article" class="btn btn-sample">Modifier article</button>
	<button id="bt_gestion_clowns" class="btn btn-sample">Gestion des clowns</button>
	<button id="bt_gestion_users" class="btn btn-sample">Gestion des utilisateurs</button>
	<!-- -------------------------------- Gestion galerie -------------------------- -->
	<div class="row col-md-12" id="page_galerie">
		<div class="container">
			<div id="content" class="row "></div>
			<div id="page_navigation"></div>
		</div>
		<p>
			<button id="bt_galerie_add_photo" class="btn btn-sample">Ajouter photo</button>
		</p>
		<div id="galerie_add_photo_info">
			<p>
				<label for="tb_galerie_name_new_photo">Nom de la photo </label> <input type="text" id="tb_galerie_name_new_photo">
				<button id="bt_galerie_get_photo" class="btn btn-sample">Importer photo</button>
				<input type="file" id="file_galerie_get_photo" accept="image/*">
				<button id="bt_galerie_add_photo_submit" class="btn btn-sample">Valider</button>
			</p>
		</div>
	</div>
	<!-- -------------------------------- Fin gestion galerie -------------------------- -->
	<!-- -------------------------------- Modifier article -------------------------- -->
	<div class="row col-md-12" id="page_modif_article" style="margin-bottom: 2%">
		<div class="row" id="modifier_article" style="margin-top: 3%">
			<p>Veuillez sélectionner l'article à modifier.</p>
			<select id="select" default="">
				<option disabled selected value hidden></option>
				<option id_article="7">Présentation des ateliers</option>
				<option id_article="1">Le pain</option>
				<option id_article="2">Le lait</option>
				<option id_article="3">Les 7 familles</option>
				<option id_article="4">Le menu équilibré</option>
				<option id_article="5">Alimentation et environnement</option>
				<option id_article="6">Le spectacle</option>
				<option disabled value></option>
				<option id_article="11">Présentation de notre démarche</option>
				<option id_article="8">Clown</option>
				<option id_article="9">Pratique et sensoriel</option>
				<option id_article="10">Expression Corporelle</option>
				<option disabled value></option>
				<option id_article="12">Formation</option>
			</select>
		</div>
		<div id="update_show_article" class="row">
			<ul class="nav nav-tabs">
				<li id="onglet_contenu" class="onglet active"><a>Contenu</a></li>
				<li id="onglet_photo" class="onglet"><a>Photo</a></li>
				<li id="onglet_video" class="onglet"><a>Vidéo</a></li>
				<li id="onglet_pdf" class="onglet"><a>PDF</a></li>
			</ul>
			<div id="update_content">
				<div class="row col-md-12">
					<div class="col-md-4 col-md-push-4">
						<textarea id="contenu_article" rows="15" cols="80" style="margin-top: 2%; margin-left: 6%;"></textarea>
					</div>
					<div id="listUrl" class="col-md-3 col-md-push-5" style="margin-top: 2%;"></div>
				</div>
				<button id="bt_add_url" class="btn btn-sample">Ajouter un lien</button>
				<button id="bt_submit_update_content" class="btn btn-sample">Mettre à jour</button>
			</div>
			<div id="update_gestion_photo">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_image" class="scroll-box-admin"></div>
					<div class="cover-bar"></div>
				</div>
				<button id="bt_update_add_photo" class="btn btn-sample">Ajouter photo</button>
				<div id="update_add_photo_info" style="margin-top: 2%">
					<label for="tb_update_name_photo">Nom de la photo </label> <input type="text" id="tb_update_name_photo"> <input type="checkbox" id="check_update_add_photo">Inscription requise ?<br>
					<button id="bt_update_get_photo" class="btn btn-sample">Importer photo</button>
					<input type="file" id="file_update_get_photo" accept="image/*">
					<button id="bt_update_add_photo_submit" class="btn btn-sample">Valider</button>
				</div>
			</div>
			<div id="update_pdf">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_pdf" class="scroll-box-admin"></div>
					<div class="cover-bar"></div>
				</div>
				<button id="bt_update_add_pdf" class="btn btn-sample">Ajouter PDF</button>
				<div id="update_get_pdf" class="row" hidden>
					<input type="file" id="file_update_get_pdf" accept="application/pdf"> <label for="tb_update_get_pdf">Nom du PDF :</label> <input type="text" id="tb_update_name_pdf"> <input type="checkbox" id="check_update_add_pdf">Inscription requise ?<br>
					<button id="bt_update_get_pdf" class="btn btn-sample">Importer PDF</button>
					<button id="bt_update_submit_pdf" class="btn btn-sample">Valider</button>
				</div>
			</div>
			<div id="update_video">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_video" class="scroll-box-admin"></div>
					<div class="cover-bar"></div>
				</div>
				<button id="bt_update_add_video" class="btn btn-sample">Ajouter vidéo</button>
				<div id="update_get_video" class="row" hidden>
					<label for="tb_update_url_video">Lien de la vidéo :</label> <input type="text" id="tb_update_url_video"> <input type="checkbox" id="check_update_add_video">Inscription requise ?<br>
					<button id="bt_update_submit_video" class="btn btn-sample">Valider</button>
				</div>
			</div>
		</div>
	</div>
	<!-- -------------------------------- Fin modifier article -------------------------- -->
	<!-- -------------------------------- Gestion clowns -------------------------------- -->
	<div id="gestion_clowns" class="row col-md-12" style="margin-bottom: 2%">
		<div class="row" style="margin-top: 3%">
			<p>Veuillez sélectionner le clown à modifier.</p>
			<select id="select_clown" default="">
				<option disabled selected value hidden></option>
			</select>
			<button id="bt_clown_add" class="btn btn-sample">Ajouter clown</button>
			<div id="add_clown">
				<label for="tb_name_add_clown">Nom du clown </label> <input type="text" id="tb_name_add_clown">
				<button id="bt_get_add_clown" class="btn btn-sample">Importer portrait</button>
				<button id="bt_submit_add_clown" class="btn btn-sample">Valider</button>
			</div>
		</div>
		<input type="file" id="file_change_portrait_clown" accept="image/*"> <input type="file" id="file_add_photo_clown" accept="image/*">
		<div id="info_clown" class="row col-md-12"></div>
	</div>
	<!--  ------------------------------- Fin gestion des clowns ------------------------ -->
	<!--  -------------------------------  Gestion des users ---------------------------- -->
	<div id="gestion_users" class="row col-md-12" style="margin-bottom: 2%">
		<div id="wrapper_gestion_users" class="row col-md-12">
			<div class="col-md-6 col-md-push-3">
				<table id="table_gestion_users" class="table table-striped table-bordered">
					<tr>
						<th>Nom</th>
						<th>Prenom</th>
						<th>Adresse mail</th>
						<th>Privilège</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--  ------------------------------- Fin gestion des users ------------------------ -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>