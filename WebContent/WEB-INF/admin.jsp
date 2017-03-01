<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Administration</title>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<script>
		$(document).ready(function(){
			var files = [];
			
			$('#bt_add_article').on('click', function(){
				$('#creer_article').show();
			});
			
			$('#bt_add_photo').on('click', function(){
				$('#media').click();
			});
			
			$("#media").on('change', function(e){
				files = $.merge(files, $('#media')[0].files)
				
				$('#contenu') .val($('#contenu').val() + "\n<photo" + files.length + ">\n");
				
				var current_file = this.files[0];
				var reader = new FileReader();
				if (current_file.type.indexOf('image') == 0) 
				{
				  reader.onload = function (event) 
				  {
				      var image = new Image();
				      image.src = event.target.result;

				      image.onload = function() 
				      {
				        var maxWidth = 200,
				            maxHeight = 200,
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
				        $("#preview").prop('src', canvas.toDataURL(current_file.type));
				        canvas.toBlob(function(blob){
				        	pp = blob;
				        }, "image/png");
				        
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
		});
	</script>
	<p>Ceci est la page d'administration</p>
	<br>
	<button id="bt_add_article" class="btn btn-sample">Ajouter article</button>
	
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
		<img id="preview">
				<!--  <textarea id="contenu" rows="20" cols="50" placeholder="Le contenu de l'article" required></textarea> -->
		</div>
	</div>
	
	<div>
	<%@include file="/WEB-INF/footer.html"%>
	</div>
</body>
</html>