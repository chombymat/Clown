<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Les ateliers</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<script language="JavaScript">
function affiche_text(text){
	document.getElementById("change").innerHTML = text;
}
function change_video(url){
	document.getElementById("video").src = url;
}
function cacher(id){
	document.getElementById(id).style.display = 'none';
}
</script>
</head>
<body>
<p><span class="gauche"><button type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button type="submit" class="btn btn-sample">connexion</button></span><h1>Page d'acceuil</h1></p>
		<%@include file="/WEB-INF/navbar.jsp"%>
	<div id="menu_gauche">
		<ul>
			<li><input type="button" value="1. Le Pain" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="2 Le Lait" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="3. Les 7 Familles" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="4. Le Menu Equilibré" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="5. Alimentation et environnement" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="Le Spectacle" onclick="affiche_text('[texte] présentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
		</ul>
	</div>
	<div id="change">
		[texte] présentation générale des 5 ateliers et spectacle
	</div>
	<iframe id="video" width="560" height="315" src="https://www.youtube.com/embed/_TSZe3mfGYg" frameborder="0" allowfullscreen></iframe>[vidéo]
	<img id="image" width="560" height="315">[photos]</img>
</body>
</html>