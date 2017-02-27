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
	<script>
		$(document).ready(function(){
			$('#bt_add_article').on('click', function(){
				$('#creer_article').show();
			});
			
			$('#bt_creer_article').on('click', function(){
				//ajax add article
			});
				
			$('#creer_article').hide();
		});
	</script>
	<p>Ceci est la page d'administration</p>
	<br>
	<button id="bt_add_article" class="btn btn-sample">Ajouter article</button>
	<div id="creer_article">
		<form action="./creerArticle" method="post" enctype="multipart/form-data">
			<textarea name="contenu" rows="30" cols="100"></textarea>
			<br>
			<input id="file" type="file" name="media" accept="video/*|image/*"/>
			<input type="submit" class="btn btn-sample" value="Creer article"/>
		</form>
	</div>
</body>
</html>