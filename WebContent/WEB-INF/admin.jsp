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
<link rel="stylesheet" href="style.css" />
<title>ClownEducatif.com – Compagnie de clown de théâtre Administration</title>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp" %>
	<script>
		$(document).ready(function(){
			var showDivUrl = 0;
			var showDivAddArticle = 0;
			var showDivModifArticle = 0;

			/*********************************** Ajouter article ***********************************/
			
			var files = [];
			var filesGalerie = [];
			var ii = 1;
			
			$('#bt_add_article').on('click', function(){
				if(showDivModifArticle == 1)
				{
					showDivModifArticle = 0;				
					$('#page_modif_article').hide();
				}
				
				if(showDivAddArticle == 0)
				{
					showDivAddArticle = 1;					
					$('#page_article').show();
				}
				else
				{
					showDivAddArticle = 0;					
					$('#page_article').hide();
				}
			});
			
			$('#bt_add_photo').on('click', function(){
				$('#media').click();
			});
			
			$('#bt_url').on('click', function(){
				if(showDivUrl == 0)
				{
					showDivUrl = 1;				
					$('#saisir_url').show();
				}
				else
				{
					showDivUrl = 0;				
					$('#saisir_url').hide();
				}
			});
			
			$('#bt_add_url').on('click', function(){
				var lien = "<a href=\"" + $('#lien_url').val() + "\">" + $('#text_url').val() + "</a>";
				$('#contenu') .val($('#contenu').val() + " " + lien + " ");
				showDivUrl = 0;				
				$('#saisir_url').hide();
				
			});
			
			$("#media").on('change', function(e){
				files = $.merge(files, $('#media')[0].files);

				var reader = new FileReader();
				var current_file = files[files.length - 1];
				if (current_file.type.indexOf('image') == 0) 
				{
				  reader.onload = function (event) 
				  {
				      var image = new Image();
				      image.src = event.target.result;
						console.log(current_file);
				      image.onload = function() 
				      {
					        var maxWidth = 250,
					            maxHeight = 250,
					            imageWidth = image.width,
					            imageHeight = image.height;
	
	
					        if (imageWidth > imageHeight) 
					        {
					          if (imageWidth > maxWidth) 
					          {
					            imageHeight *= maxWidth / imageWidth;
					            imageWidth = maxWidth;
					          }
					        }
					        else 
					        {
					          if (imageHeight > maxHeight) 
					          {
					            imageWidth *= maxHeight / imageHeight;
					            imageHeight = maxHeight;
					          }
					        }
	
					        var canvas = document.createElement('canvas');
					        canvas.width = imageWidth;
					        canvas.height = imageHeight;
					        image.width = imageWidth;
					        image.height = imageHeight;
					        var ctx = canvas.getContext("2d");
					        ctx.drawImage(this, 0, 0, imageWidth, imageHeight);
						       
					        var div = document.createElement('div');
					        var preview = document.createElement('img');
					        $(preview).attr('src', canvas.toDataURL(current_file.type));
					        $(div).append(current_file.name);
					        $(div).append(preview);
					        $('#images').append(div);
					        ii++;
							$('#contenu') .val($('#contenu').val() + "\n< " + current_file.name + " >\n");
				      }
				    }
				  reader.readAsDataURL(current_file);
				}					
			});
			
			$('#form_creer_article').submit(function(e){
				e.preventDefault();
				
				var $form = $(this);
		        var form_data = new FormData();
				
				for(var i = 0; i < files.length; i++)
				{
					form_data.append('media_' + files[i].name, files[i]);
				}
				
				form_data.append('titre', $('#titre').val());
				form_data.append('description', $('#description').val());
				form_data.append('contenu', $('#contenu').val());
				form_data.append('ajax', true);
		 	
		        $.ajax({
		            url: $form.attr('action'),
		            type: $form.attr('method'),
		            mimeType:"multipart/form-data",
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function(json){
		            	var j = JSON.parse(json);
		            	if(j.article_creer != null)
		            	{
		            		$('#success').html(j.article_creer)
		            		$('#creer_article').hide();
		           		}
		            	if(j.erreur_titre == "true")
		            		$('#erreur_titre').val("Veuillez saisir un titre");
		            	if(j.erreur_description == "true")
		            		$('#erreur_description').val("Veuillez saisir une description");
		            	if(j.erreur_contenu == "true")
		            		$('#erreur_contenu').val("Veuillez saisir un contenu");
		            }
		        });
			});
			<%
			if(request.getAttribute("page_article") == null)
			{
				%>$('#page_article').hide();<%
			}
			%>
			$('#media').hide();
			$('#saisir_url').hide();
			
			/*********************************** Modifier article ***********************************/
			
			var id_article = null;
			var id_projet = null;
			
			$('#bt_modif_article').on('click', function(){
				if(showDivAddArticle == 1)
				{
					showDivAddArticle = 0;					
					$('#page_article').hide();
				}
				
				if(showDivModifArticle == 0)
				{
					showDivModifArticle = 1;				
					$('#page_modif_article').show();
				}
				else
				{
					showDivModifArticle = 0;				
					$('#page_modif_article').hide();
				}
			});
			
			$('#select').change(function(){
				var page = $(this).val();

				$.ajax({
		            url: './ModificationArticle',
		            type: 'GET',
		            data: {
		            	titre : page,
		            },
		            success : function(data)
		            {
		            	var json = jQuery.parseJSON(data);
		            	var array = json.medias;
		            	id_article = json.id;
		            	id_projet = json.id_projet;
		            	$('#modif_article_image').html("");
		            	for(var i = 0; i < array.length; i++)
		            	{
		            		$('#modif_article_image').append(
		            				"<div class=\"" + array[i].id + " col-md-3\"><img id=\"" + array[i].id +"\"class=\"myImg img-thumbnail\" src=\"" + array[i].chemin + "\" alt=\"" + array[i].nom +"\" ><br>" + 
		            				"<input id=\"name_" + array[i].id + "\" type=\"text\" value=\"" + array[i].nom + "\" maxlength=\"50\"\">" +
		            				"<button id_media=\"" + array[i].id + "\" class=\"bt_rename_photo btn btn-sample\">Renommer</button>   " +
		            				"<button id_media=\"" + array[i].id + "\" class=\"bt_delete_photo btn btn-sample\">Supprimer</button></div>");
		            	}
		            	initialiser();
		            	$('#contenu_article').val(json.contenu);
		            }
		        });
				
				$('#update_show_article').show();
			});
			
			$('#bt_submit_update_content').on('click', function(){
				var form_data = new FormData();
				form_data.append("type", "texte");
				form_data.append("id_article", id_article);
				form_data.append("texte", $('#contenu_article').val());
				
				$.ajax({
		            url: './ModificationArticle',
		            type: 'POST',
		            mimeType:'multipart/form-data',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function()
		            {
		            	// Afficher modification réussie
		            }
		        });
			});
			
			$('#bt_update_add_photo').on('click', function(){
				if($('#update_add_photo_info').is(':visible'))
					$('#update_add_photo_info').hide();
				else
					$('#update_add_photo_info').show();
			});
			
			$('#bt_update_add_photo_submit').on('click', function(){
				var form_data = new FormData();
				form_data.append("type", "add_photo");
				form_data.append("id_article", id_article);
				form_data.append("id_projet", id_projet);
				form_data.append('nom', $('#tb_update_name_photo').val());
				form_data.append('media', $('#file_update_get_photo')[0].files[0]);
				
				$.ajax({
		            url: './ModificationArticle',
		            type: 'POST',
		            mimeType:'multipart/form-data',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function(json)
		            {
		            	json = jQuery.parseJSON(json);
		            	$('#modif_article_image').append(
	            				"<div class=\"" + json.id_media + " col-md-3\">"+
	            				"<img id=\"" + json.id_media +"\"class=\"myImg img-thumbnail\" src=\"images/" + id_projet + "/" + id_article + "/PHOTOS_ENFANTS/" + json.nom + " alt=\""+ $('#tb_update_name_photo').val()  +"\"><br>" 
	            			  + "<input id=\"name_" + json.id_media + "\" type=\"text\" value=\"" + $('#tb_update_name_photo').val() + "\" maxlength=\"50\"\">" +
	            				"<button id_media=\"" + json.id_media + "\" class=\"bt_rename_photo btn btn-sample\">Renommer</button>   " +
	            				"<button id_media=\"" + json.id_media + "\" class=\"bt_delete_photo btn btn-sample\">Supprimer</button></div>");
		            }
		        });
			});
			
			$('#bt_update_get_photo').on('click', function(){
				$('#file_update_get_photo').click();
			});
			
			$('#page_modif_article').hide();
			$('#file_update_get_photo').hide();
			$('#update_add_photo_info').hide();
			$('#update_show_article').hide();
			
			function initialiser()
			{
				var modal = document.getElementById('myModal');

				var span = document.getElementsByClassName("close")[0];

				$('.myImg').on('click', function() {
					$('html, body').css({
						overflow : 'hidden',
						height : '100%'
					});
					$('#myModal').attr('style', 'display: block');
					$('#img01').attr('src', $(this).attr('src'));
					$('#caption').html($(this).attr('alt'));
				});
				
				span.onclick = function() {
					$('html, body').css({
						overflow : 'auto',
						height : 'auto'
					});
					modal.style.display = "none";
				}
				
				$('.bt_delete_photo').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append("type", "delete_photo");
					form_data.append("id_article", id_article);
					form_data.append("id_media", id_media);
					form_data.append("chemin", $('#' + id_media).attr('src'));
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	$('.' + id_media).remove();
			            }
			        });
				});
				

				$('.bt_rename_photo').on('click', function()
				{
					var id_media = $(this).attr("id_media");
					var new_name = $('#name_' + id_media).val();
					var form_data = new FormData();
					
					form_data.append("type", "rename_photo");
					form_data.append("newName", new_name);
					form_data.append("id_media", id_media);
					
					console.log($('#name_' + id_media).val());
					console.log($(this).attr("id_media"));
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	$('#' + id_media).attr('alt', new_name);
			            }
			        });
				});
			}
		});
	</script>
	<button id="bt_add_article" class="btn btn-sample">Ajouter article</button> <button id="bt_modif_article" class="btn btn-sample">Modifier article</button>
	
	<!-- -------------------------------- Créer article -------------------------- -->
	
	<div class="row" id="page_article">
		<span id="success" class="success">${ requestScope.article_creer }</span>
		<div class="row" id="creer_article">
			<div class="col-md-12">
				<form id="form_creer_article" action="./creerArticle" method="post" enctype="multipart/form-data">
					<br>
					<span id="erreur_titre" class="erreur">${ requestScope.erreur_titre }</span>
					<textarea id="titre" rows="1" cols="100" placeholder="Le titre de l'article" required></textarea>
					<br><br>
					<span id="erreur_description" class="erreur">${ requestScope.erreur_description }</span>
					<textarea id="description" rows="2" cols="100" placeholder="La description de l'article" required></textarea>
					<br><br>
					<span id="erreur_contenu" class="erreur">${ requestScope.erreur_contenu }</span>
					<textarea id="contenu" rows="15" cols="100" placeholder="Le contenu de l'article" required></textarea>
					<br>
					<input id="media" type="file" accept="image/*"/>
					<button type="button" id="bt_add_photo" class="btn btn-sample">Importer photo</button>
					<button type="button" id="bt_url" class="btn btn-sample">Ajouter lien</button>
					<input type="submit" class="btn btn-sample" value="Creer article"/>
				</form>
			<div class="col-md-12">
				<div id="images">			
				</div>
			</div>
			</div>
		</div>
	</div>
	
	<!-- -------------------------------- Fin créer article -------------------------- -->
	
	<!-- -------------------------------- Modifier article -------------------------- -->
	
	<div class="row col-md-12" id="page_modif_article" style="margin-bottom: 2%">
		<div class="row" id="modifier_article">
			<p>Veuillez sélectionner l'article à modifier.</p>
			<select id="select" default="">
				<option disabled selected value hidden></option>
				<option value="Le pain">Le pain</option>
				<option value="Le lait">Le lait</option>
				<option value="Les 7 familles">Les 7 familles</option>
				<option value="Le menu équilibré">Le menu équilibré</option>
				<option value="Alimentation et environnement">Alimentation et environnement</option>
				<option value="Le spectacle">Le spectacle</option>
				<option value="Clown">Clown</option>
				<option value="Pratique et sensoriel">Pratique et sensoriel</option>
				<option value="Expression Corporelle">Expression Corporelle</option>
			</select>
		</div>
		<div id="update_show_article" class="row">
			<div class="col-md-6">
				<textarea id="contenu_article" rows="15" cols="80" style="margin-top: 2%; margin-left: 2%"></textarea><br><button id="bt_submit_update_content" class="btn btn-sample">Mettre à jour</button>
			</div>
			<div class="col-md-6">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_image" class="scroll-box-admin">
					</div>
					<div class="cover-bar">
					</div>
				</div>
				<button id="bt_update_add_photo" class="btn btn-sample">Ajouter photo</button>
				<div id="update_add_photo_info" style="margin-top: 2%">
					<label for="tb_update_name_photo">Nom de la photo </label>
					<input type="text" id="tb_update_name_photo">
					<button id="bt_update_get_photo" class="btn btn-sample">Importer photo</button>
					<input type="file" id="file_update_get_photo" accept="image/*">
					<button id="bt_update_add_photo_submit" class="btn btn-sample">Valider</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>
	
	<!-- -------------------------------- Fin modifier article -------------------------- -->
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>