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
		        var formData = new FormData();
				
				for(var i = 0; i < files.length; i++)
				{
					formData.append('media_' + files[i].name, files[i]);
				}
				
				formData.append('titre', $('#titre').val());
				formData.append('description', $('#description').val());
				formData.append('contenu', $('#contenu').val());
				formData.append('ajax', true);
		 	
		        $.ajax({
		            url: $form.attr('action'),
		            type: $form.attr('method'),
		            mimeType:"multipart/form-data",
		            contentType: false,
		            processData: false,
		            data: formData,
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
				console.log(page);
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
		            	
		            	$('#modif_article_image').html("");
		            	for(var i = 0; i < array.length; i++)
		            	{
		            		$('#modif_article_image').append(
		            				"<div><img class=\"myImg img-thumbnail\" data-value=\"" + array[i].id + "\" src=\"" + array[i].chemin + "\"><br>" + 
		            				"<input data-value=\"" + array[i].id + "\" type=\"text\" value=\"" + array[i].nom + "\"><button data-value=\"" + array[i].id + "\" class=\"bt_delete_photo\">Supprimer</button></div>");
		            	}
		            	bindBtDeletePhoto();
		            	$('#contenu_article').val(json.contenu);
		            }
		        });
			});
			
			$('#bt_submit_update').on('click', function(){
				console.log("update texte");
			});
			
			$('#bt_update_add_photo').on('click', function(){
				console.log("add photo");
			});
			
			$('#page_modif_article').hide();
		});
		
		function bindBtDeletePhoto()
		{
			$('.bt_delete_photo').on('click', function(){
				console.log("delete photo : " + $(this).attr('data-value'));
			});
		}
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
	
	<div class="row" id="page_modif_article">
		<div class="row col-md-12" id="modifier_article">
			<p>Veuillez séléctionner l'article à modifier.</p>
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
		<div class="row">
			<div class="col-md-8">
				<textarea id="contenu_article" rows="15" cols="80" style="margin-top: 2%; margin-left: 2%"></textarea><br><button id="bt_submit_update">Mettre à jour</button>
			</div>
			<div class="col-md-3">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_image" class="scroll-box-admin">
					</div>
					<div class="cover-bar">
					</div>
				</div>
				<button id="bt_update_add_photo">Ajouter photo</button>
			</div>
		</div>
	</div>
	
	<!-- -------------------------------- Fin modifier article -------------------------- -->
		
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>