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
			var files = [];
			var filesGalerie = [];
			var ii = 1;
			
			$('#bt_add_article').on('click', function(){
				$('#remplir_galerie').hide();
				$('#creer_article').show();
			});
			
			$('#bt_add_photo').on('click', function(){
				$('#media').click();
			});
			
			$("#media").on('change', function(e){
				files = $.merge(files, $('#media')[0].files);
				
				$('#contenu') .val($('#contenu').val() + "\n<photo" + files.length + ">\n");

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
					        $(div).append("Photo " + ii);
					        $(div).append(preview);
					        $('#images').append(div);
					        console.log(current_file);
					        ii++;
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
					formData.append('media_' + i, files[i]);
				}
				
				formData.append('titre', $('#titre').val());
				formData.append('description', $('#description').val());
				formData.append('contenu', $('#contenu').val());
		 	
		        $.ajax({
		            url: $form.attr('action'),
		            type: $form.attr('method'),
		            mimeType:"multipart/form-data",
		            contentType: false,
		            processData: false,
		            data: formData,
		            success : function(){
		            	console.log("Ajout réussi.");
		            }
		        });
			});
				
			$('#creer_article').hide();
			$('#media').hide();
			
			/******************** separation article et galerie *************************/			

			$('#bt_add_galerie').on('click', function(){
				$('#creer_article').hide();
				$('#remplir_galerie').show();
			});
			
			$('#bt_add_photo_galerie').on('click', function(){
				$('#bt_file_photo').click();
			});
			
			$("#bt_file_photo").on('change', function(e){
				filesGalerie = $.merge(filesGalerie, $('#bt_file_photo')[0].files);
				
				var reader = new FileReader();
				var current_file = filesGalerie[filesGalerie.length - 1];
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
					        var desc = document.createElement('textArea');
					        $(desc).attr('placeholder', 'test');
					        $(preview).attr('src', canvas.toDataURL(current_file.type));
					        $(div).append(desc);
					        $(div).append(preview);
					        $('#images_galerie').append(div);
					        console.log(current_file);
				      }
				    }
				  reader.readAsDataURL(current_file);
				}					
			});
			
			
			$('#remplir_galerie').hide();
			$('#bt_file_photo').hide();
			
			
		});
	</script>
	<button id="bt_add_article" class="btn btn-sample">Ajouter article</button>	<button id="bt_add_galerie" class="btn btn-sample">Ajouter à la galerie</button>
	
	<!-- -------------------------------- Créer article -------------------------- -->
	
	<div class="row" id="creer_article">
		<div class="col-md-8">
			<form id="form_creer_article" action="./creerArticle" method="post" enctype="multipart/form-data">
				<br>
				<textarea id="titre" rows="1" cols="100" placeholder="Le titre de l'article" required></textarea>
				<br><br>
				<textarea id="description" rows="2" cols="100" placeholder="La description de l'article" required></textarea>
				<br><br>
				<textarea id="contenu" rows="20" cols="100" placeholder="Le contenu de l'article" required></textarea>
				<br>
				<input id="media" type="file" accept="video/*|image/*"/>
				<button type="button" id="bt_add_photo" class="btn btn-sample">Importer photo</button>
				<input type="submit" class="btn btn-sample" value="Creer article"/>
			</form>
		</div>
		<div class="col-md-2">
			<br>
			<div id="images" style="overflow-y: scroll; height:550px; overflow-x: hidden; width: 250px">			
			</div>
		</div>
	</div>
	
	<!-- -------------------------------- Fin créer article -------------------------- -->
	
	<!-- -------------------------------- Ajouter image -------------------------- -->
	<!-- 
	<div class="row" id="remplir_galerie">
		<div class="col-md-8">
			<form id="form_galerie" action="./remplirGalerie" method="post" enctype="multipart/form-data">
				<br>
				<input id="bt_file_photo" type="file" accept="image/*"/>
				<button type="button" id="bt_add_photo_galerie" class="btn btn-sample">Importer photo</button>
				<input type="submit" class="btn btn-sample" value="Ajouter photo"/>
			</form>
		</div>
		<div class="col-md-2">
			<br>
			<div id="images_galerie" style="overflow-y: scroll; height:550px; overflow-x: hidden; width: 250px">			
			</div>
		</div>
	</div> -->
	
	<div class="container">
		<div id="remplir_galerie" class="row">
			<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2" id="images_galerie"></div>
		</div>
		<div class="col-md-8">
			<form id="form_galerie" action="./remplirGalerie" method="post" enctype="multipart/form-data">
				<br>
				<input id="bt_file_photo" type="file" accept="image/*"/>
				<button type="button" id="bt_add_photo_galerie" class="btn btn-sample">Importer photo</button>
				<input type="submit" class="btn btn-sample" value="Ajouter photo"/>
			</form>
		</div>
	</div>
	
	
	<!-- -------------------------------- Fin d'image -------------------------- -->
	
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>