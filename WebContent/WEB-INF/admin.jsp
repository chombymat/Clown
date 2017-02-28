<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			$('#bt_add_article').on('click', function(){
				$('#creer_article').show();
			});
			
			$('#bt_creer_article').on('click', function(){
				//ajax add article
			});
			
			$('#form_creer_article').submit(function(e){
				e.preventDefault();
				
				var $form = $(this);
		        var formData = new FormData();
				
				if($('#media').val() != '')
				{
					var files = $('#media')[0].files;
					
					for(var i = 0; i < files.length; i++)
					{
						formData.append('media_' + i, files[i]);
					}
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
		});
	</script>
	<p>Ceci est la page d'administration</p>
	<br>
	<button id="bt_add_article" class="btn btn-sample">Ajouter article</button>
	<div id="creer_article">
		<form id="form_creer_article" action="./creerArticle" method="post" enctype="multipart/form-data">
			<br>
			<textarea id="titre" rows="1" cols="100" placeholder="Le titre de l'article" required></textarea>
			<br><br>
			<textarea id="description" rows="2" cols="100" placeholder="La description de l'article" required></textarea>
			<br><br>
			<textarea id="contenu" rows="20" cols="100" placeholder="Le contenu de l'article" required></textarea>
			<br>
			<input id="media" type="file" accept="video/*|image/*" multiple/>
			<input type="submit" class="btn btn-sample" value="Creer article"/>
		</form>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>